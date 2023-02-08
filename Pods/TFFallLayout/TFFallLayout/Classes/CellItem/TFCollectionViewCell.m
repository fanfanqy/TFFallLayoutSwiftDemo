//
//  TFCollectionViewCell.m
//
//  Created by ZhangJun on 2018/10/25.
//  Copyright © 2018 JingLing. All rights reserved.
//

#import "TFCollectionViewCell.h"

@implementation TFCollectionViewCell

+ (CGSize)collectionView:(UICollectionView *)collectionView sizeForItem:(id<TFCollectionReusableViewItemProtocol>)object {
    CGSize size = CGSizeZero;
    if (object.cellSize) {
        size = [object.cellSize CGSizeValue];
    }
    return size;
}

- (void)setObject:(id<TFCollectionReusableViewItemProtocol>)object {
    if (_object == object) return;
    
    _object = object;
    
    if ([_object respondsToSelector:@selector(setAssociatedCell:)]) {
        _object.associatedCell = self;
    }
}

@end
