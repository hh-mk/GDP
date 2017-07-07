//
//  Extension.swift
//  GDP
//
//  Created by iOS on 2017/7/7.
//  Copyright © 2017年 HH. All rights reserved.
//

import UIKit
import SnapKit

extension UIView
{
    func addView(nibName:String?,bundle:Bundle)
    {
        guard let nib = nibName else { return }
        
        guard let subView = UINib(nibName:nib, bundle: bundle).instantiate(withOwner: self, options: nil)[0] as? UIView else { return }
        
        addSubview(subView)
        
        subView.snp.makeConstraints { (make) in
            
            make.center.equalTo(self)
            
            make.width.height.equalTo(self)
        }

    }
}

