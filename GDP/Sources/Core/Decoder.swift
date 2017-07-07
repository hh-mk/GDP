//
//  HHDicomDecoder.swift
//  HHDicom
//
//  Created by iOS on 2017/4/20.
//  Copyright © 2017年 HH. All rights reserved.
//


import UIKit

class Decoder
{
    fileprivate var mDicom: DicomFile
    
    var mChangeValWidth: Float = 0.5
    
    var mChangeValCenter: Float = 0.5
    
    init(dicomFile: DicomFile)
    {
        mDicom = dicomFile
    }
    
    
    fileprivate func lookupParam( _ winWidth: Int, _ winCenter: Int) ->LookupParam
    {
        var param = LookupParam(winw: winWidth, winc: winCenter)
        
        param.bwReverse = mDicom.bwReverse
        
        param.min = mDicom.minPixel
        
        param.max = mDicom.maxPixel
        
        return param
    }
    
    
    fileprivate  func bitChange( _ winWidth:Int)
    {
        if isBit16()
        {
            setBit16Change(winWidth: winWidth)
        }
        else
        {
            setBit8Change()
        }

    }
    
    
    func image(winWidth: Int, winCenter: Int) -> UIImage?
    {
        bitChange(winWidth)
        
        var params = ColorsParam(w: mDicom.width, h: mDicom.height)
        
        params.offset = mDicom.offset()
        
        params.lut = Lookup.lookupTable(config: lookupParam( winWidth,winCenter))
        
        params.pix = mDicom.pixelData
        
        params.planarConfiguration = mDicom.planarConfiguration
        
        let gray = !isDecode24Image()
        
        params.gray = gray
        
        let pix = ColorsFactory.createColors(param: params)
        
        let config = ImageBuilder(w: mDicom.width, h: mDicom.height, pData: pix).builde(gray: gray)
        
        return CreateImage.create(config: config)
    
    }
    

    
    func setBit16Change(winWidth: Int)
    {
        if winWidth < 5000
        {
            mChangeValWidth = 2.0
            mChangeValCenter = 2.0
        }
        else if winWidth > 40000
        {
            mChangeValWidth = 50
            mChangeValCenter = 50
        }
        else
        {
            mChangeValWidth = 25
            mChangeValCenter = 25
        }
    }
    
    func setBit8Change()
    {
        mChangeValWidth = 0.1
        mChangeValCenter = 0.1
    }
    
    func isBit16() -> Bool
    {
        return mDicom.bitsAllocated == DecoderUtils.Bit_16
    }
    
    func isDecode24Image() -> Bool
    {
        return mDicom.bitsAllocated == DecoderUtils.Bit_8 && mDicom.samplesPerPixel == 3
    }

}
