//
//  ViewController.swift
//  TFFallLayoutSwiftDemo
//
//  Created by 范庆宇 on 2023/2/7.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.btn)
        self.btn.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(CGSizeMake(100, 40))
            
        }
    }

    lazy var btn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("进入Demo", for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for:.touchUpInside)
        return btn
        
    }()
    
    @objc func btnClick() {
        let vc = Demo1ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}

