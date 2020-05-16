//
//  BaseXibView.swift
//  LoLProject
//
//  Created by Антон on 16.05.2020.
//  Copyright © 2020 Антон. All rights reserved.
//

import UIKit

open class XibBasedView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        guard let contentView = Bundle.main.loadNibNamed(String (describing: type(of: self)), owner: self, options: nil)?.first as? UIView else { return }
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setupUI()
    }
    
    open func setupUI() {
        
    }
}
