//
//  TFFallLayout.h
//
//  Created by zerozheng on 2018/11/28.
//  Copyright © 2018 JingLing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFFallLayoutConfiguration.h"
#import "TFFallLayoutCompositor.h"


/**
1. 垂直滚动的collectionview
|------------------------------------------ |
| ----------------------------------------- |
||                   m.t                   ||
||    ---------------------------------    ||
||m.l|             header              |m.r||
||    ---------------------------------    ||
||                   p.t                   ||
||        ----   ----   ----   ----        ||
||       |    |c|    |c|    |c|    |       ||
||        ----   ----   ----   ----        ||
||m.l p.l        itemSpace          p.r m.r||
||        ----   ----   ----   ----        ||
||       |    |c|    |c|    |c|    |       ||
||        ----   ----   ----   ----        ||
||                   p.b                   ||
||    ---------------------------------    ||
||m.l|             footer              |m.r||
||    ---------------------------------    ||
||                   m.b                   ||
| ----------------------------------------- |
|                                           |
|                                           |
|                                           |


2. 水平滚动的collectionview 布局跟 垂直的差不多，只是方向变成横的了

*/





@protocol TFFallLayoutDelegate<NSObject>

/// 分组渲染
- (id<TFFallLayoutCompositor>)collectionView:(UICollectionView *)collectionView collectionViewLayout:(UICollectionViewLayout *)layout compositorForSection:(NSInteger)section;

/// 分组头部
- (TFFallLayoutHeader *)collectionView:(UICollectionView *)collectionView collectionViewLayout:(UICollectionViewLayout *)layout headerForSection:(NSInteger)section;

/// 分组脚部
- (TFFallLayoutFooter *)collectionView:(UICollectionView *)collectionView collectionViewLayout:(UICollectionViewLayout *)layout footerForSection:(NSInteger)section;

/// 分组背景
- (TFFallLayoutBackground *)collectionView:(UICollectionView *)collectionView collectionViewLayout:(UICollectionViewLayout *)layout backgroundForSection:(NSInteger)section;

/// 分组padding
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView collectionViewLayout:(UICollectionViewLayout *)layout paddingForSection:(NSInteger)section;

/// 分组margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView collectionViewLayout:(UICollectionViewLayout *)layout marginForSection:(NSInteger)section;

/// item大小
- (CGSize)collectionView:(UICollectionView *)collectionView collectionViewLayout:(UICollectionViewLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface TFFallLayout : UICollectionViewLayout

@property (nonatomic, copy)TFFallLayoutConfiguration *configuration;
@property (nonatomic, strong, readonly, nullable) UIScrollView *linkageView;

- (instancetype)init;
- (instancetype)initWithConfiguration:(TFFallLayoutConfiguration *)configuration NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;


- (CGFloat)originXOfSection:(NSInteger)section __attribute__((deprecated("use offsetDimensionOfSection: instead.")));

- (CGFloat)offsetDimensionOfSection:(NSInteger)section;

@end



