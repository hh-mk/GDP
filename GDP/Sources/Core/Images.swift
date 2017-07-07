//
//  HHDicomDecoderUtils.swift
//  HHDicom
//
//  Created by iOS on 2017/4/20.
//  Copyright © 2017年 HH. All rights reserved.
//

import UIKit

struct DecoderUtils
{
    static let Bit_8: Int = 8
    static let Bit_16: Int = 16
    static let Max_Bit16: Int = 65535
    
}




struct CreateImage
{
    
    static func create(config:ImageConfig) ->UIImage?
    {
        
        guard let aPixels = config.pixels else { return nil }
        
        let width = config.width
        
        let height = config.height
        
        let capacity = aPixels.count
        
        let data = UnsafeMutablePointer<UInt8>.allocate(capacity: capacity)
        
        data.initialize(from: aPixels, count: capacity)
        
        let bytesPerRow = config.space * width
        
        let context = CGContext(data: data, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: config.colorSpace, bitmapInfo: config.bitmapInfo.rawValue)
        
        guard let cgImage = context?.makeImage() else { return nil }
        
        data.deallocate(capacity: aPixels.count)
        
        return UIImage(cgImage: cgImage)

    }
}


struct ImageConfig
{
    var width = 0
    
    var height = 0
    
    var pixels: [UInt8]?
    
    var space = 1
    
    var colorSpace = CGColorSpaceCreateDeviceGray()
    
    var bitmapInfo = CGBitmapInfo(rawValue:CGImageAlphaInfo.none.rawValue)

}


struct ImageBuilder
{
    var width = 0
    
    var height = 0
    
    var pixels: [UInt8]?
    
    init(w:Int,h:Int,pData:[UInt8]?)
    {
        width = w
        
        height = h
        
        pixels = pData
    }
    
    
    func builde(gray:Bool) ->ImageConfig
    {
        var config = ImageConfig()
        
        config.height = height
        
        config.width = width
        
        config.pixels = pixels
        
        if !gray
        {
            config.colorSpace = CGColorSpaceCreateDeviceRGB()
            
            config.bitmapInfo = CGBitmapInfo(rawValue:  CGImageAlphaInfo.noneSkipLast.rawValue )
            
            config.space = 4
        }
        
        return config
    }
}

