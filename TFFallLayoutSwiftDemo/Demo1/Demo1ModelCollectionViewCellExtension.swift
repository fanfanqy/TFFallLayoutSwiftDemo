//
//  Demo1ModelCollectionViewCellExtension.swift
//  TFFallLayoutSwiftDemo
//
//  Created by 范庆宇 on 2023/2/7.
//

import Foundation

extension Demo1Model:Demo1CollectionViewCellAdapter {
    
    func btnTitle1() -> String? {
        return self.title1
        
    }
    
    func btnTitle2() -> String? {
        return self.title2
        
    }
    
    func cellWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
        
    }
    
    func cellHeight() -> CGFloat {
        return 50
        
    }
    
}
