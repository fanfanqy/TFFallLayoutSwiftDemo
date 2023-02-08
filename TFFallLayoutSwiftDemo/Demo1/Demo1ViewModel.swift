//
//  Demo1ViewModel.swift
//  TFFallLayoutSwiftDemo
//
//  Created by 范庆宇 on 2023/2/7.
//

import UIKit

class Demo1ViewModel: JQQYBaseViewModel {
    
    override func makeSection(with array: Array<JQQYBaseCellAdapter>?) -> TFFallLayoutSectionItem? {
        var sectionItems = Array<TFCollectionReusableViewItem>()
        if let tempArray = array,tempArray.count > 0 {
            for model in tempArray {
                let item = TFCollectionReusableViewItem()
                item.model = model
                item.cellClass = JQQYBaseCollectionViewCell<Demo1CellItemView>.self
                item.cellResponse = self
                sectionItems.append(item)
            }
        }
        let section = TFFallLayoutSectionItem()
        section.sectionItems = NSMutableArray.init(array: sectionItems)
        return section
        
    }
    
    override func handleClickCell(at indexPath: IndexPath, with object: TFCollectionReusableViewItemProtocol) {
        print("%@:%@",indexPath,object)
        if indexPath.item == 0 {
            Demo1Logic.logic1(params: nil) { success in
                print(success)
                
            }
            
        }else {
            Demo1Logic.logic2(params: ["a":NSNumber.init(value: true)]) { success in
                print(success)
                
            }
        }
    }
    
    override func handleCellResponse(viewIdentifier identifier: String?, object: TFCollectionReusableViewItemProtocol?) {
        print("%@:%@",identifier ?? "",object)
        
    }
    
}
