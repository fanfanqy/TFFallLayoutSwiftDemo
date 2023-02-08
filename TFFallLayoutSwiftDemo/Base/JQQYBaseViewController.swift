//
//  JQ_QYBaseViewController.swift
//  TFFallLayoutSwiftDemo
//
//  Created by 范庆宇 on 2023/2/7.
//

import UIKit

class JQQYBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        initView()
        initData()
        
    }
    
    func initView() {
        self.collectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.size.height+44)
            
        }
    }
    
    func initData() {
        
    }
    
    lazy var adaptor = TFFallLayoutAdaptor()
    
    lazy var collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: TFFallLayout()).then { obj in
        obj.showsVerticalScrollIndicator = false
        obj.showsHorizontalScrollIndicator = false
        obj.delegate = self.adaptor
        obj.dataSource = self.adaptor
        self.view.addSubview(obj)
        self.adaptor.collectionView = obj
        
    }
}
