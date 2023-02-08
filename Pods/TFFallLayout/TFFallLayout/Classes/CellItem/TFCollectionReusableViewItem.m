//
//  TFCollectionReusableViewItem.m
//
//  Created by ZhangJun on 2018/10/25.
//  Copyright © 2018 JingLing. All rights reserved.
//

#import "TFCollectionReusableViewItem.h"

@implementation TFCollectionReusableViewItem

@synthesize cellClass, cellType = _cellType, cellSize, cellResponse, cellResponseBlock, model, useNib, accessibilityIdentifier, associatedCell;

- (NSString *)cellType {
    return _cellType?:NSStringFromClass(self.cellClass);
}

@end

