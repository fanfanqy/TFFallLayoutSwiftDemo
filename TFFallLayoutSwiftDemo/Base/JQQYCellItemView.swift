//
//  JQQYCellItemView.swift
//  TFFallLayoutSwiftDemo
//
//  Created by 范庆宇 on 2023/2/8.
//

import UIKit

class JQQYCellItemView: UIView {
        
    var object: TFCollectionReusableViewItemProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
    
    }
    
    func configConstraints() {
        
    }

}
