//
//  TFFallLayoutSection.m
//  TFUIKit
//
//  Created by 黄楠 on 2019/12/23.
//

#import "TFFallLayoutSection.h"

@interface TFFallLayoutSection ()
@property (nonatomic, strong, nullable) UICollectionViewLayoutAttributes *headerAttribute;
@property (nonatomic, strong, nullable) UICollectionViewLayoutAttributes *footerAttribute;
@property (nonatomic, strong, nullable) UICollectionViewLayoutAttributes *backgroundAttribute;
@property (nonatomic, strong) NSArray<UICollectionViewLayoutAttributes *> *items;
@property (nonatomic, assign) CGRect sectionRect;

/// 头部
@property (nonatomic, strong, nullable) TFFallLayoutHeader *header;
/// 底部
@property (nonatomic, strong, nullable) TFFallLayoutFooter *footer;
/// 背景
@property (nonatomic, strong, nullable) TFFallLayoutBackground *background;
/// 分组内部padding
@property (nonatomic, assign) UIEdgeInsets padding;
/// 分组外部margin
@property (nonatomic, assign) UIEdgeInsets margin;
/// collectionView滚动方法
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;
/// 分组滚动主轴偏移量
@property (nonatomic, assign) CGFloat offset;
/// 分组滚动交叉轴的尺寸
@property (nonatomic, assign) CGFloat crossScrollDirectionDimension;
/// 第几个分组
@property (nonatomic, assign) NSInteger index;

@end

@implementation TFFallLayoutSection {
    id<TFFallLayoutCompositor> _compositor;
}


- (instancetype)initWithCompositor:(id<TFFallLayoutCompositor>)compositor header:(TFFallLayoutHeader *)header footer:(TFFallLayoutFooter *)footer background:(TFFallLayoutBackground *)background padding:(UIEdgeInsets)padding margin:(UIEdgeInsets)margin scrollDirection:(UICollectionViewScrollDirection)scrollDirection offset:(CGFloat)offset crossScrollDirectionDimension:(CGFloat)crossScrollDirectionDimension index:(NSInteger)index {
    self = [super init];
    if (self) {
        _compositor = compositor;
        _header = header;
        _footer = footer;
        _background = background;
        _padding = padding;
        _margin = margin;
        _scrollDirection = scrollDirection;
        _offset = offset;
        _crossScrollDirectionDimension = crossScrollDirectionDimension;
        _index = index;
        _indexPath = [NSIndexPath indexPathForItem:0 inSection:index];
    }
    return self;
}


- (CGFloat)dimension {
    switch (self.scrollDirection) {
        case UICollectionViewScrollDirectionVertical:
            return self.sectionRect.size.height;
            
        case UICollectionViewScrollDirectionHorizontal:
            return self.sectionRect.size.width;
    }
}

- (BOOL)intersectsWithRect:(CGRect)rect {
    return CGRectIntersectsRect(rect, self.sectionRect);
}


- (void)prepareItems:(NSArray<TFFallLayoutCompositorItemObject *> *)items {
    
    TFFallLayoutCompositorResult *result = [_compositor prepareItems:items header:self.header footer:self.footer background:self.background padding:self.padding margin:self.margin scrollDirection:self.scrollDirection offset:self.offset crossScrollDirectionDimension:self.crossScrollDirectionDimension sectionIndex:self.index];
    
    self.headerAttribute = result.headerAttributes;
    self.footerAttribute = result.footerAttributes;
    self.backgroundAttribute = result.backgroundAttributes;
    self.items = result.itemAttributes;
    self.sectionRect = result.sectionRect;
}



- (NSArray<UICollectionViewLayoutAttributes *> *)itemsInRect:(CGRect)rect {
    
    NSMutableArray *items = [NSMutableArray array];
    if (![self intersectsWithRect:rect]) {
        return items;
    }
    
    [self.items enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectIntersectsRect(obj.frame, rect)) {
            [items addObject:obj];
        }
    }];
    return items;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)supplementsInRect:(CGRect)rect {
    NSMutableArray *items = [NSMutableArray array];
    if (![self intersectsWithRect:rect]) {
        return items;
    }
    
    NSMutableArray *all = [NSMutableArray array];
    if (self.headerAttribute) [all addObject:self.headerAttribute];
    if (self.footerAttribute) [all addObject:self.footerAttribute];
    if (self.backgroundAttribute) [all addObject:self.backgroundAttribute];
    [all enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectIntersectsRect(obj.frame, rect)) {
            [items addObject:obj];
        }
    }];
    return items;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)elementsInRect:(CGRect)rect {
    NSMutableArray *all = [NSMutableArray array];
    [all addObjectsFromArray:[self itemsInRect:rect]];
    [all addObjectsFromArray:[self supplementsInRect:rect]];
    return all;
}

@end


