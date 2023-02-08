//
//  TFCollectionViewSectionItem.m
//
//  Created by ZhangJun on 2018/10/25.
//  Copyright © 2018 JingLing. All rights reserved.
//

#import "TFCollectionViewSectionItem.h"

@implementation TFCollectionViewSectionItem

@synthesize sectionItems = _sectionItems, headerItem, footerItem, backgroundItem, sectionIdentifier, minimumLineSpacing, minimumInteritemSpacing, insetForSection;

- (NSMutableArray *)sectionItems {
    if (!_sectionItems) {
        _sectionItems = [NSMutableArray array];
    }
    return _sectionItems;
}

@end
