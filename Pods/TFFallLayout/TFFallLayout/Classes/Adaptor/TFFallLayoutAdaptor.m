//
//  TFFallLayoutAdaptor.m
//
//  Created by zerozheng on 2018/11/27.
//  Copyright © 2018 JingLing. All rights reserved.
//

#import "TFFallLayoutAdaptor.h"
#import "TFFallLayoutSectionItem.h"
#import "TFCollectionViewCell.h"

@implementation TFFallLayoutAdaptor

- (NSArray<TFFallLayoutSectionBaseItem *> *)items {
    return [super items];
}

- (void)setItems:(NSArray<TFFallLayoutSectionItem *> *)items {
    [super setItems:items];
}


- (id<TFFallLayoutCompositor>)collectionView:(UICollectionView *)collectionView collectionViewLayout:(UICollectionViewLayout *)layout compositorForSection:(NSInteger)section {
    TFFallLayoutSectionBaseItem *sectionItem = self.items[section];
    return sectionItem.compositor;
}

/// 分组头部
- (TFFallLayoutHeader *)collectionView:(UICollectionView *)collectionView collectionViewLayout:(UICollectionViewLayout *)layout headerForSection:(NSInteger)section {
    TFFallLayoutSectionBaseItem *sectionItem = self.items[section];
    return sectionItem.header;
}

/// 分组脚部
- (TFFallLayoutFooter *)collectionView:(UICollectionView *)collectionView collectionViewLayout:(UICollectionViewLayout *)layout footerForSection:(NSInteger)section {
    TFFallLayoutSectionBaseItem *sectionItem = self.items[section];
    return sectionItem.footer;
}

/// 分组背景
- (TFFallLayoutBackground *)collectionView:(UICollectionView *)collectionView collectionViewLayout:(UICollectionViewLayout *)layout backgroundForSection:(NSInteger)section {
    TFFallLayoutSectionBaseItem *sectionItem = self.items[section];
    return sectionItem.background;
}

/// 分组padding
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView collectionViewLayout:(UICollectionViewLayout *)layout paddingForSection:(NSInteger)section {
    TFFallLayoutSectionBaseItem *sectionItem = self.items[section];
    return sectionItem.sectionPadding;
}

/// 分组margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView collectionViewLayout:(UICollectionViewLayout *)layout marginForSection:(NSInteger)section {
    TFFallLayoutSectionBaseItem *sectionItem = self.items[section];
    return sectionItem.sectionMargin;
}

- (CGSize)collectionView:(UICollectionView *)collectionView collectionViewLayout:(UICollectionViewLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TFFallLayoutSectionBaseItem *sectionItem = self.items[indexPath.section];
    id<TFCollectionReusableViewItemProtocol> item = sectionItem.sectionItems[indexPath.item];
    if (item.cellSize) return [item.cellSize CGSizeValue];
    CGSize size = CGSizeZero;
    if ([item.cellClass respondsToSelector:@selector(collectionView:sizeForItem:)]) {
        size = [item.cellClass collectionView:collectionView sizeForItem:item];
    }
    item.cellSize = [NSValue valueWithCGSize:size];
    return [item.cellSize CGSizeValue];
}

@end
