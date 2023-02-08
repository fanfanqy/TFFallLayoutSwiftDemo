//
//  JQ_QYBaseViewModel.swift
//  TFFallLayoutSwiftDemo
//
//  Created by 范庆宇 on 2023/2/7.
//

import UIKit


open class JQQYBaseViewModel: NSObject,TFCollectionViewAdaptorDelegate,TFCollectionViewCellDelegate {
    
    open var viewController:UIViewController?
    
    open var dataArray:Array = Array<JQQYBaseCellAdapter>()
    
    open func generateSectionItems() -> Array<TFFallLayoutSectionItem> {
        var array = Array<TFFallLayoutSectionItem>()
        if let item = self.makeSection(with: self.dataArray) {
            array.append(item)
        }
        return array
        
    }
    
    open func makeSection(with array: Array<JQQYBaseCellAdapter>?) -> TFFallLayoutSectionItem? {
        return nil
        
    }
    
    open func handleClickCell(at indexPath:IndexPath, with object:TFCollectionReusableViewItemProtocol) {
        
    }
    
    open func handleCellResponse(viewIdentifier identifier: String?, object: TFCollectionReusableViewItemProtocol?) {
        
    }
    
    // MARK: - TFCollectionViewAdaptorDelegate
    open func collectionView(_ collectionView: UICollectionView, didSelectObject object: TFCollectionReusableViewItemProtocol, rowAt indexPath: IndexPath) {
        handleClickCell(at: indexPath, with: object)
        
    }
    
    // MARK: - TFCollectionViewCellDelegate
    open func collectionViewCell(_ cell: TFCollectionViewCell?, didTappedView view: UIView?, viewIdentifier identifier: String?, cellObject object: TFCollectionReusableViewItemProtocol) {
        handleCellResponse(viewIdentifier: identifier, object: object)
        
    }
    
    

}
