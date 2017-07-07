//
//  DicomViewModel.swift
//  GDP
//
//  Created by iOS on 2017/7/7.
//  Copyright © 2017年 HH. All rights reserved.
//

import UIKit

public struct DicomVM
{
    
    var mStart = CGPoint.zero
    
    var mDecoder:Decoder?
    
    var mWinW:Int = 0
    
    var mWinC:Int = 0
    
    var mObservable:((UIImage?)->Void)?
    {
        didSet{
        
            mObservable?(createImage())
        }
    }
    
    init(file:DicomFile)
    {
        mDecoder = Decoder(dicomFile: file)
        
        mWinC = file.wl
        
        mWinW = file.ww
        
    }
    
    mutating func begin(location:CGPoint)
    {
        mStart = location
    }
    
    mutating func end(location:CGPoint)
    {
        let offsetX = location.x - mStart.x
        
        let offsetY = location.y - mStart.y
        
        begin(location: location)
        
        updateParam(Float(offsetX), Float(offsetY))
        
        mObservable?(createImage())
    }
    
    
    mutating func updateParam( _ offsetX: Float, _ offsetY: Float)
    {
        mWinW += Int(offsetX * (mDecoder?.mChangeValWidth ?? 0))
        
        mWinC += Int(offsetY * (mDecoder?.mChangeValCenter ?? 0))
        
        if mWinW < 1
        {
            mWinW = 1
        }

    }
    
    
    func createImage() ->UIImage?
    {
        return mDecoder?.image(winWidth: mWinW, winCenter: mWinC)
    }
    
    func winInfo() ->String
    {
        return "ww:\(mWinW)  wl:\(mWinC)"
    }
}
