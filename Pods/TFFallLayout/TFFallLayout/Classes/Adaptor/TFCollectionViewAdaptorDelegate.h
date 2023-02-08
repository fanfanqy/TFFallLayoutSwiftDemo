//
//  TFCollectionViewAdaptorDelegate.h
//
//  Created by ZhangJun on 2018/10/25.
//  Copyright © 2018 JingLing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFCollectionViewSectionItemProtocol.h"
#import "TFCollectionReusableViewItemProtocol.h"



@protocol TFCollectionViewAdaptorDelegate <UIScrollViewDelegate>

@optional
// 选中cell
- (void)collectionView:(UICollectionView *)collectionView didSelectObject:(id<TFCollectionReusableViewItemProtocol>)object rowAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath;

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath;

//自动加载更多
- (void)needAutoLoadmoreForCollectionView:(UICollectionView *)collectionView;

@end


