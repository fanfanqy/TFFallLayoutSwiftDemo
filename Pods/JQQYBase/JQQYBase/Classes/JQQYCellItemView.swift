//
//  JQQYCellItemView.swift
//  TFFallLayoutSwiftDemo
//
//  Created by 范庆宇 on 2023/2/8.
//

import UIKit


open class JQQYCellItemView: UIView {
    
    open var object: TFCollectionReusableViewItemProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configConstraints()
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupUI() {
    
    }
    
    open func configConstraints() {
        
    }

}
