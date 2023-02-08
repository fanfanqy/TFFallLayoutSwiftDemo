//
//  TFFallLayoutCompositor.h
//  TFFallLayout
//
//  Created by 黄楠 on 2021/2/26.
//

#import <Foundation/Foundation.h>
#import "TFFallLayoutRender.h"
#import "TFFallLayoutHeader.h"
#import "TFFallLayoutFooter.h"
#import "TFFallLayoutBackground.h"
#import "TFCollectionViewConstant.h"




@interface TFFallLayoutCompositorItemObject : NSObject
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) NSInteger index;

- (instancetype)initWithSize:(CGSize)size index:(NSInteger)index;
@end

@interface TFFallLayoutCompositorResult : NSObject
@property (nonatomic, strong) UICollectionViewLayoutAttributes *headerAttributes;
@property (nonatomic, strong) UICollectionViewLayoutAttributes *footerAttributes;
@property (nonatomic, strong) UICollectionViewLayoutAttributes *backgroundAttributes;
@property (nonatomic, copy) NSArray<UICollectionViewLayoutAttributes *> *itemAttributes;
@property (nonatomic, assign) CGRect sectionRect;

- (instancetype)initWithHeaderAttributes:(UICollectionViewLayoutAttributes *)headerAttributes footerAttributes:(UICollectionViewLayoutAttributes *)footerAttributes backgroundAttributes:(UICollectionViewLayoutAttributes *)backgroundAttributes itemAttributes:(NSArray<UICollectionViewLayoutAttributes *> *)itemAttributes sectionRect:(CGRect)sectionRect;

@end


@protocol TFFallLayoutCompositor <NSObject>
- (TFFallLayoutCompositorResult *)prepareItems:(NSArray<TFFallLayoutCompositorItemObject *> *)items header:(TFFallLayoutHeader *)header footer:(TFFallLayoutFooter *)footer background:(TFFallLayoutBackground *)background padding:(UIEdgeInsets)padding margin:(UIEdgeInsets)margin scrollDirection:(UICollectionViewScrollDirection)scrollDirection offset:(CGFloat)offset crossScrollDirectionDimension:(CGFloat)crossScrollDirectionDimension sectionIndex:(NSInteger)sectionIndex;
@end


@interface TFFallLayoutCompositor : NSObject <TFFallLayoutCompositor>

- (instancetype)initWithRender:(TFFallLayoutRender *)render columnCount:(NSInteger)columnCount columnSpacing:(CGFloat)columnSpacing itemSpacing:(CGFloat)itemSpacing;

@end


@interface TFFallLayoutFlowCompositor : NSObject <TFFallLayoutCompositor>

- (instancetype)initWithItemDimension:(CGFloat)itemDimension columnSpacing:(CGFloat)columnSpacing itemSpacing:(CGFloat)itemSpacing;

@end


