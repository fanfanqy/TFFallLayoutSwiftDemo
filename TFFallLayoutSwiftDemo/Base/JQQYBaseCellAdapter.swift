//
//  JQ_QYBaseCellAdapter.swift
//  TFFallLayoutSwiftDemo
//
//  Created by 范庆宇 on 2023/2/7.
//

import Foundation
@objc protocol JQQYBaseCellAdapter {
    @objc optional func cellHeight()->CGFloat
    
    @objc optional func cellWidth()->CGFloat
    
}
