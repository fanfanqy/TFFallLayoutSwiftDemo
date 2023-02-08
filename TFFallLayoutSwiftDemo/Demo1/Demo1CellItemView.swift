//
//  Demo1CellItemView.swift
//  TFFallLayoutSwiftDemo
//
//  Created by 范庆宇 on 2023/2/8.
//

import UIKit

class Demo1CellItemView: JQQYCellItemView {

    override var object: TFCollectionReusableViewItemProtocol! {
        didSet {
            if let item = object.model {
                let itemProtocol = item as! Demo1CollectionViewCellAdapter
                self.btn1.setTitle(itemProtocol.btnTitle1(), for: .normal)
                self.btn2.setTitle(itemProtocol.btnTitle2(), for: .normal)
                
            }
        }
    }

    @objc func btnClick(_ btn:UIButton) {
        let tag = btn.tag
        if let item = self.object.model {
            let itemProtocol = item as! Demo1CollectionViewCellAdapter
            if let cellRes = self.object?.cellResponse {
                if cellRes.responds(to: #selector(TFCollectionViewCellDelegate.collectionViewCell(_:didTappedView:viewIdentifier:cellObject:))) {
                    if tag == 1000 {
                        cellRes.collectionViewCell(nil, didTappedView: btn, viewIdentifier: itemProtocol.btnTitle1() ?? "", cellObject: object!)

                    }else {
                        cellRes.collectionViewCell(nil, didTappedView: btn, viewIdentifier: itemProtocol.btnTitle2() ?? "", cellObject: object!)
                        
                    }
                }
            }
            
        }
    }
    
    override func setupUI() {
        super.setupUI()
        addSubview(self.btn1)
        addSubview(self.btn2)
        addSubview(self.lineView)
        
    }
    
    override func configConstraints() {
        super.configConstraints()
        self.btn1.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSizeMake(100, 30))
            
        }
        self.btn2.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSizeMake(100, 30))
            
        }
        self.lineView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
            
        }
    }
    
    lazy var btn1 = UIButton(type: .custom).then { btn in
        btn.backgroundColor = .red
        btn.tag = 1000
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
    }
    
    lazy var btn2 = UIButton(type: .custom).then { btn in
        btn.backgroundColor = .green
        btn.tag = 1001
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
    }
    
    lazy var lineView = UIView().then {
        $0.backgroundColor = .lightGray
    }

}
