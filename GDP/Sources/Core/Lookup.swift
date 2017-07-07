//
//  HHDicomLookup.swift
//  HHDicom
//
//  Created by iOS on 2017/4/20.
//  Copyright © 2017年 HH. All rights reserved.
//

struct Lookup
{

    
    static func lookupTable(config:LookupParam) -> [UInt8]
    {
        
        let maxValue = config.max
        
        let minValue = config.min
        
        var color = ColorByte(wl: config.wl, ww: config.ww)
        
        if config.bwReverse
        {
            color.reverse()
        }
        
        let offset = config.offset()
        
        var lookup: [UInt8] = []
       
        if offset < 0
        {
            lookup = [UInt8](repeating: 0, count: maxValue - minValue + 1)
        }
        else
        {
            lookup = [UInt8](repeating: 0, count: maxValue - minValue + offset + 1)
        }
        
        for i in minValue ... maxValue
        {
            lookup[offset + i] = UInt8(color.byte(i))
        }
        return lookup
    }
    
}



fileprivate struct ColorByte
{
    var high = 0
    
    var low = 0
    
    var white = 255
    
    var black = 0
    
    var opt = 1
    
    var ww = 0
    
    init(wl:Int,ww:Int)
    {
        high = wl + ww/2
        
        low = wl - ww/2

        self.ww = ww
    }
    
    
    mutating func reverse()
    {
        white = 0
        
        black = 255
        
        opt = -1
    }
    
    func byte(_ index:Int) ->Int
    {
        
        var colorByte = index
        
        guard ww > 0 else { return colorByte}
        
        if index < low
        {
            colorByte = black
        }
        else if index > high
        {
            colorByte = white
        }
        else
        {
            colorByte = black + opt * (index - low) * 255 / ww
        }

        return colorByte
    }
    
}


struct LookupParam
{
    var ww:Int = 0
    
    var wl:Int = 0
    
    var max = 0
    
    var min = 0
    
    var bwReverse = false
    
    init(winw:Int,winc:Int)
    {
        self.ww = winw
        
        self.wl = winc
    }
    
    func offset() ->Int
    {
        return min < 0 ? 0 - min : -min
    }
    
}
