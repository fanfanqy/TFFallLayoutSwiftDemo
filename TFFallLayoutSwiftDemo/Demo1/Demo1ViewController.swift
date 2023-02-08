//
//  Demo1ViewController.swift
//  TFFallLayoutSwiftDemo
//
//  Created by 范庆宇 on 2023/2/7.
//

import UIKit

class Demo1ViewController: JQQYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        
    }
    
    func reloadData() {
        self.adaptor.items = self.viewModel.generateSectionItems() as? [any TFFallLayoutSectionBaseItem & TFCollectionViewSectionItemProtocol]
        self.collectionView.reloadData()
        
    }
    
    override func initData() {
        super.initData()
        do {
            let model = Demo1Model()
            model.title1 = "按钮1"
            model.title2 = "按钮2"
            self.viewModel.dataArray.append(model)
        }
        do {
            let model = Demo1Model()
            model.title1 = "按钮3"
            model.title2 = "按钮4"
            self.viewModel.dataArray.append(model)
        }
        self.adaptor.delegate = self.viewModel
    }
    
    lazy var viewModel: Demo1ViewModel = {
        let viewModel = Demo1ViewModel()
        viewModel.viewController = self
        return viewModel
        
    }()
    
}
