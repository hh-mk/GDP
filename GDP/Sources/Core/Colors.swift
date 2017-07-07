//
//  HHDicomColorsFactory.swift
//  HHDicom
//
//  Created by iOS on 2017/4/21.
//  Copyright © 2017年 HH. All rights reserved.
//



struct ColorsFactory
{
    
    
    static func createColors(param:ColorsParam) ->[UInt8]?
    {
        
        return convert(param, model: switchModel(param))
    }
    
    
    
    fileprivate static func  switchModel( _ param:ColorsParam) ->Colors?
    {
    
        var model:Colors? = nil
        
        if param.isPlanar()
        {
            model = Planer()
        }
        else
        {
            if param.gray
            {
                model = Gray()
            }
            else
            {
                model = Rgb()
            }
        }

        
        return model
        
    }
    
    
    
    
    fileprivate static func convert(_ param:ColorsParam,model:Colors?) -> [UInt8]?
    {
        guard let lut = param.lut , let pix = param.pix else {
            
            return nil
        }
        
        let width = param.width
        
        let height = param.height
        
        let offset = param.offset
        
        return model?.convert(width: width, height: height, lut: lut, pix: pix, offset: offset)
    }
    

}




protocol Colors
{
    func convert(width:Int, height:Int, lut:[UInt8], pix:[Int], offset: Int) ->[UInt8]
}



struct Gray:Colors
{
    func convert(width:Int, height:Int, lut:[UInt8], pix:[Int], offset: Int) ->[UInt8]
    {
        let numberOfBytes = width * height
        
        var imageData = [UInt8](repeating: 0, count: numberOfBytes)
        var k: Int = 0
        var p: UInt8 = 0
        for i in 0 ..< height
        {
            k = i * width
            for j in 0 ..< width
            {
                let idx = k + j
                p = lut[pix[idx] + offset]
                imageData[idx] = p
            }
        }
        return imageData

    }
}


struct Rgb:Colors
{
    func convert(width:Int, height:Int, lut:[UInt8], pix:[Int], offset: Int) ->[UInt8]
    {
        let numberOfBytes = width * height * 4
        var imageData = [UInt8](repeating: 0, count: numberOfBytes)
        let width3 = width * 3
        let width4 = width * 4
        var k: Int = 0
        var l: Int = 0
        
        var r: UInt8 = 0
        var g: UInt8 = 0
        var b: UInt8 = 0
        for i in 0 ..< height
        {
            l = i * width3
            k = i * width4
            var m: Int = 0
            for j in stride(from: 0, to: width4, by: 4)
            {
                r = lut[pix[l + m] + offset]
                g = lut[pix[l + m + 1] + offset]
                b = lut[pix[l + m + 2] + offset]
                m += 3
                imageData[k + j] = r
                imageData[k + j + 1] = g
                imageData[k + j + 2] = b
                imageData[k + j + 3] = 255
            }
        }
        return imageData
    }
}



struct Planer:Colors
{
    func convert(width:Int, height:Int, lut:[UInt8], pix:[Int], offset: Int) ->[UInt8]
    {
        let numberOfBytes = width * height
        
        var imageData = [UInt8](repeating: 0, count: numberOfBytes*4)
        let width4 = width * 4
        var k: Int = 0
        var r: UInt8 = 0
        var g: UInt8 = 0
        var b: UInt8 = 0
        var n : Int = 0
        for i in 0 ..< height
        {
            k = i * width
            
            n = i * width4
            
            var l:Int = 0
            
            for j in 0 ..< width
            {
                
                let m = k + j + offset
                r = lut[pix[m]]
                g = lut[pix[m + numberOfBytes]]
                b = lut[pix[m + numberOfBytes * 2]]
                imageData[n + l] = r
                imageData[n + l + 1] = g
                imageData[n + l + 2] = b
                imageData[n + l + 3] = 255
                
                if l < width4
                {
                    l += 4
                }
                
            }
        }
        return imageData
    }
}


struct ColorsParam
{
    var planarConfiguration = 0
    
    var width = 0
    
    var height = 0
    
    var lut:[UInt8]?
    
    var pix:[Int]?
    
    var offset = 0
    
    var gray = true
    
    init(w:Int,h:Int)
    {
        width = w
        
        height = h 
    }
    
    func isPlanar() ->Bool
    {
        return planarConfiguration == 1
    }
}


