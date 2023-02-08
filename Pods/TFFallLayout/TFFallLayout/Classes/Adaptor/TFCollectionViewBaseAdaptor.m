//
//  TFCollectionViewBaseAdaptor.m
//
//  Created by ZhangJun on 2018/10/25.
//  Copyright © 2018 JingLing. All rights reserved.
//

#import "TFCollectionViewBaseAdaptor.h"
#import "TFCollectionViewConstant.h"
#import "TFCollectionViewCell.h"


@implementation TFCollectionViewBaseAdaptor

- (void)dealloc {
#if DEBUG
    NSLog(@"%@ -- dealloc", self);
#endif
}

- (void)setItems:(NSArray<id<TFCollectionViewSectionItemProtocol>> *)items {
    _items = items;
    
    NSMutableSet *cellIdentifierSet = [NSMutableSet set];
    NSMutableSet *headerIdentifierSet = [NSMutableSet set];
    NSMutableSet *footerIdentifierSet = [NSMutableSet set];
    NSMutableSet *backgroundIdentifierSet = [NSMutableSet set];
    for (id<TFCollectionViewSectionItemProtocol> sectionItem in items) {
        for (id<TFCollectionReusableViewItemProtocol> cellItem in sectionItem.sectionItems) {
            if (![cellIdentifierSet containsObject:cellItem.cellType] && cellItem.cellType.length) {
                [cellIdentifierSet addObject:cellItem.cellType];
                if (cellItem.useNib) {
                    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(cellItem.cellClass) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellItem.cellType];
                } else {
                    [self.collectionView registerClass:cellItem.cellClass forCellWithReuseIdentifier:cellItem.cellType];
                }
            }
        }
        if (![headerIdentifierSet containsObject:sectionItem.headerItem.cellType] && sectionItem.headerItem.cellType.length) {
            [headerIdentifierSet addObject:sectionItem.headerItem.cellType];
            if (sectionItem.headerItem.useNib) {
                [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(sectionItem.headerItem.cellClass) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionItem.headerItem.cellType];
            } else {
                [self.collectionView registerClass:sectionItem.headerItem.cellClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionItem.headerItem.cellType];
            }
        }
        if (![footerIdentifierSet containsObject:sectionItem.footerItem.cellType] && sectionItem.footerItem.cellType.length) {
            [footerIdentifierSet addObject:sectionItem.footerItem.cellType];
            if (sectionItem.footerItem.useNib) {
                [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(sectionItem.footerItem.cellClass) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:sectionItem.footerItem.cellType];
            } else {
                [self.collectionView registerClass:sectionItem.footerItem.cellClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:sectionItem.footerItem.cellType];
            }
        }
        if (![backgroundIdentifierSet containsObject:sectionItem.backgroundItem.cellType] && sectionItem.backgroundItem.cellType.length) {
            [backgroundIdentifierSet addObject:sectionItem.backgroundItem.cellType];
            if (sectionItem.backgroundItem.useNib) {
                [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(sectionItem.backgroundItem.cellClass) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionBackground withReuseIdentifier:sectionItem.backgroundItem.cellType];
            } else {
                [self.collectionView registerClass:sectionItem.backgroundItem.cellClass forSupplementaryViewOfKind:UICollectionElementKindSectionBackground withReuseIdentifier:sectionItem.backgroundItem.cellType];
            }
        }
    }
}

#pragma mark - Private

- (Class)cellClassForObject:(id<TFCollectionReusableViewItemProtocol>)object {
    Class cellClass = nil;
    if (object) {
        cellClass = [object cellClass];
    }
    return cellClass;
}

- (id<TFCollectionReusableViewItemProtocol>)objectForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<TFCollectionViewSectionItemProtocol> sectionItem = [self objectAtSection:indexPath.section];
    if (sectionItem.sectionItems.count > indexPath.row) {
        return sectionItem.sectionItems[indexPath.row];
    }
    return nil;
}

- (NSInteger)numberOfSections {
    return self.items.count;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    id<TFCollectionViewSectionItemProtocol> sectionItem = [self objectAtSection:section];
    return sectionItem.sectionItems.count;
}

- (id<TFCollectionViewSectionItemProtocol>)objectAtSection:(NSInteger)section {
    if (section >= self.items.count) {
        return nil;
    }
    return self.items[section];
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<TFCollectionReusableViewItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    if (object.cellSize != nil) {
        return object.cellSize.CGSizeValue;
    }
    Class cellClass = [self cellClassForObject:object];
    return [cellClass collectionView:self.collectionView sizeForItem:object];
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeZero;
    if (self.collectionView == nil) {
        self.collectionView = collectionView;
    }
    size = [self sizeForItemAtIndexPath:indexPath];
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    id<TFCollectionViewSectionItemProtocol> sectionItem = [self objectAtSection:section];
    return [sectionItem.insetForSection UIEdgeInsetsValue];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    id<TFCollectionViewSectionItemProtocol> sectionItem = [self objectAtSection:section];
    return sectionItem.minimumLineSpacing.floatValue;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    id<TFCollectionViewSectionItemProtocol> sectionItem = [self objectAtSection:section];
    return sectionItem.minimumInteritemSpacing.floatValue;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    id<TFCollectionViewSectionItemProtocol> sectionItem = [self objectAtSection:section];
    id<TFCollectionReusableViewItemProtocol> headerItem = sectionItem.headerItem;
    Class cellClass = [self cellClassForObject:headerItem];
    return [cellClass collectionView:self.collectionView sizeForItem:headerItem];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    id<TFCollectionViewSectionItemProtocol> sectionItem = [self objectAtSection:section];
    id<TFCollectionReusableViewItemProtocol> footerItem = sectionItem.footerItem;
    Class cellClass = [self cellClassForObject:footerItem];
    return [cellClass collectionView:self.collectionView sizeForItem:footerItem];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id<TFCollectionReusableViewItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:didSelectObject:rowAtIndexPath:)]) {
        [self.delegate collectionView:collectionView didSelectObject:object rowAtIndexPath:indexPath];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self numberOfItemsInSection:section];
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    id<TFCollectionViewSectionItemProtocol> sectionItem = [self objectAtSection:indexPath.section];
    TFCollectionViewCell *cell;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionItem.headerItem.cellType forIndexPath:indexPath];
        [cell setObject:sectionItem.headerItem];
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:sectionItem.footerItem.cellType forIndexPath:indexPath];
        [cell setObject:sectionItem.footerItem];
    } else if ([kind isEqualToString:UICollectionElementKindSectionBackground]) {
        cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionBackground withReuseIdentifier:sectionItem.backgroundItem.cellType forIndexPath:indexPath];
        [cell setObject:sectionItem.backgroundItem];
    }
    
    return cell;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<TFCollectionReusableViewItemProtocol> object = [self objectForRowAtIndexPath:indexPath];
    TFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:object.cellType forIndexPath:indexPath];
    [cell setObject:object];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:willDisplayCell:forItemAtIndexPath:)]) {
        [self.delegate collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath  {
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:willDisplaySupplementaryView:forElementKind:atIndexPath:)]) {
        [self.delegate collectionView:collectionView willDisplaySupplementaryView:view forElementKind:elementKind atIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:didEndDisplayingCell:forItemAtIndexPath:)]) {
        [self.delegate collectionView:collectionView didEndDisplayingCell:cell forItemAtIndexPath:indexPath];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:didEndDisplayingSupplementaryView:forElementOfKind:atIndexPath:)]) {
        [self.delegate collectionView:collectionView didEndDisplayingSupplementaryView:view forElementOfKind:elementKind atIndexPath:indexPath];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:canMoveItemAtIndexPath:)]) {
        return [self.delegate collectionView:collectionView canMoveItemAtIndexPath:indexPath];
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:moveItemAtIndexPath:toIndexPath:)]) {
        [self.delegate collectionView:collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2) {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.delegate scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.delegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0) {
    if ([self.delegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.delegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    /// 自动加载更多逻辑
    if ([self.delegate respondsToSelector:@selector(needAutoLoadmoreForCollectionView:)]) {
        CGFloat currentContentOffsetY = scrollView.contentOffset.y;
        if ((currentContentOffsetY > 0) && [self.collectionView respondsToSelector:@selector(calculate)]) {
            [self.collectionView performSelector:@selector(calculate)];
        }
    }
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.delegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.delegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.delegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.delegate viewForZoomingInScrollView:scrollView];
    }
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2) {
    if ([self.delegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.delegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.delegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.delegate scrollViewShouldScrollToTop:scrollView];
    }
    return scrollView.scrollsToTop;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.delegate scrollViewDidScrollToTop:scrollView];
    }
}

- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView API_AVAILABLE(ios(11.0), tvos(11.0)) {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidChangeAdjustedContentInset:)]) {
        [self.delegate scrollViewDidChangeAdjustedContentInset:scrollView];
    }
}

@end
