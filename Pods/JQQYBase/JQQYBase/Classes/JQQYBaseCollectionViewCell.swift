//
//  JQ_QYBaseCollectionViewCell.swift
//  TFFallLayoutSwiftDemo
//
//  Created by 范庆宇 on 2023/2/7.
//

import UIKit


public final class JQQYBaseCollectionViewCell<V:JQQYCellItemView>: TFCollectionViewCell {
    
    private let view:V
    
    override init(frame: CGRect) {
        view = .init()
        super.init(frame: frame)
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override class func collectionView(_ collectionView: UICollectionView?, sizeForItem object: TFCollectionReusableViewItemProtocol) -> CGSize {
        if let item:JQQYBaseCellAdapter = object.model as? JQQYBaseCellAdapter {
            return CGSizeMake(item.cellWidth!(), item.cellHeight!())
            
        }
        return super.collectionView(collectionView, sizeForItem: object)
        
    }
    
    public override var object: TFCollectionReusableViewItemProtocol {
        didSet{
            super.object = object
            view.object = object
        }
    }
}
