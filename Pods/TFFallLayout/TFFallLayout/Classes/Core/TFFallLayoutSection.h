//
//  TFFallLayoutSection.h
//  TFUIKit
//
//  Created by 黄楠 on 2019/12/23.
//

#import <Foundation/Foundation.h>
#import "TFFallLayoutCompositor.h"



@interface TFFallLayoutSection : NSObject

- (instancetype)initWithCompositor:(id<TFFallLayoutCompositor>)compositor header:(TFFallLayoutHeader *)header footer:(TFFallLayoutFooter *)footer background:(TFFallLayoutBackground *)background padding:(UIEdgeInsets)padding margin:(UIEdgeInsets)margin scrollDirection:(UICollectionViewScrollDirection)scrollDirection offset:(CGFloat)offset crossScrollDirectionDimension:(CGFloat)crossScrollDirectionDimension index:(NSInteger)index;


@property (nonatomic, strong, nullable, readonly) UICollectionViewLayoutAttributes *headerAttribute;
@property (nonatomic, strong, nullable, readonly) UICollectionViewLayoutAttributes *footerAttribute;
@property (nonatomic, strong, nullable, readonly) UICollectionViewLayoutAttributes *backgroundAttribute;
@property (nonatomic, strong, readonly) NSArray<UICollectionViewLayoutAttributes *> *items;
@property (nonatomic, strong, readonly) NSIndexPath *indexPath;
@property (nonatomic, assign, readonly) CGFloat offset; /// 分组滚动主轴偏移量
@property (nonatomic, assign, readonly) CGFloat dimension; ///分组的尺寸
@property (nonatomic, assign, readonly) UIEdgeInsets margin;
@property (nonatomic, strong, nullable, readonly) TFFallLayoutHeader *header; /// 头部
@property (nonatomic, strong, nullable, readonly) TFFallLayoutFooter *footer; /// 底部
@property (nonatomic, strong, nullable, readonly) TFFallLayoutBackground *background; /// 背景


- (BOOL)intersectsWithRect:(CGRect)rect;
- (NSArray<UICollectionViewLayoutAttributes *> *)itemsInRect:(CGRect)rect;
- (NSArray<UICollectionViewLayoutAttributes *> *)supplementsInRect:(CGRect)rect;
- (NSArray<UICollectionViewLayoutAttributes *> *)elementsInRect:(CGRect)rect;

- (void)prepareItems:(NSArray<TFFallLayoutCompositorItemObject *> *)items;

@end


