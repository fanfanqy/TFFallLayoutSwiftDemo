//
//  JQ_QYBaseViewModel.swift
//  TFFallLayoutSwiftDemo
//
//  Created by 范庆宇 on 2023/2/7.
//

import UIKit

class JQQYBaseViewModel: NSObject,TFCollectionViewAdaptorDelegate,TFCollectionViewCellDelegate {
    
    var viewController:UIViewController?
    
    var dataArray:Array = Array<JQQYBaseCellAdapter>()
    
    func generateSectionItems() -> Array<TFFallLayoutSectionItem> {
        var array = Array<TFFallLayoutSectionItem>()
        if let item = self.makeSection(with: self.dataArray) {
            array.append(item)
        }
        return array
        
    }
    
    func makeSection(with array: Array<JQQYBaseCellAdapter>?) -> TFFallLayoutSectionItem? {
        return nil
        
    }
    
    func handleClickCell(at indexPath:IndexPath, with object:TFCollectionReusableViewItemProtocol) {
        
    }
    
    func handleCellResponse(viewIdentifier identifier: String?, object: TFCollectionReusableViewItemProtocol?) {
        
    }
    
    // MARK: - TFCollectionViewAdaptorDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectObject object: TFCollectionReusableViewItemProtocol, rowAt indexPath: IndexPath) {
        handleClickCell(at: indexPath, with: object)
        
    }
    
    // MARK: - TFCollectionViewCellDelegate
    func collectionViewCell(_ cell: TFCollectionViewCell?, didTappedView view: UIView?, viewIdentifier identifier: String?, cellObject object: TFCollectionReusableViewItemProtocol) {
        handleCellResponse(viewIdentifier: identifier, object: object)
        
    }
    
    

}
