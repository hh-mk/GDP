//
//  DicomViewer.swift
//  GDP
//
//  Created by iOS on 2017/7/7.
//  Copyright © 2017年 HH. All rights reserved.
//

import UIKit

open class DicomViewer: UIView
{
    @IBOutlet weak var mImageView: UIImageView!

    @IBOutlet weak var mWinInfo: UILabel!
    
    var mViewModel:DicomVM?

    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        addView(nibName: "DicomViewer", bundle: Bundle(for: DicomViewer.self))
        
        addPanGesture()
    }

    
    
    open func onBind(viewModel:DicomVM?)
    {
        self.mViewModel = viewModel
        
        self.mViewModel?.mObservable = { [weak self] in
        
            self?.mImageView.image = $0
            
            self?.mWinInfo.text = self?.mViewModel?.winInfo()
        }
    }
    
}



extension DicomViewer
{
    
    
    fileprivate func addPanGesture()
    {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        
        panGesture.maximumNumberOfTouches = 1
        
        panGesture.cancelsTouchesInView = false
        
        self.mImageView.addGestureRecognizer(panGesture)
        
        self.mImageView.isUserInteractionEnabled = true
    }
    
    
    func handlePanGesture(gesture: UIPanGestureRecognizer)
    {
        
        let point = gesture.location(in: self)

        switch gesture.state
        {
        case .began:
            
            mViewModel?.begin(location: point)
        
        case .changed, .ended:
            
            mViewModel?.end(location: point)
           
        default:
            break
        }
    }

}
