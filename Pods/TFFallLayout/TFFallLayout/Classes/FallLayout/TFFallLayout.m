//
//  TFFallLayout.m
//
//  Created by zerozheng on 2018/11/28.
//  Copyright © 2018 JingLing. All rights reserved.
//

#import "TFFallLayout.h"
#import "TFFallLayoutSection.h"


@implementation TFFallLayout {
    NSMutableArray<TFFallLayoutSection *> *_sections;
    TFFallLayoutConfiguration *_configuration;
}

#pragma mark - Init
- (instancetype)initWithConfiguration:(TFFallLayoutConfiguration *)configuration {
    self = [super init];
    if (self) {
        _configuration = [configuration copy];
        _sections = [NSMutableArray array];
        [self setupLinkageView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _configuration = [[TFFallLayoutConfiguration alloc] init];
        _sections = [NSMutableArray array];
        [self setupLinkageView];
    }
    return self;
}

- (instancetype)init {
    return [self initWithConfiguration:[[TFFallLayoutConfiguration alloc] init]];
}


#pragma mark - Configuration
- (void)setConfiguration:(TFFallLayoutConfiguration *)configuration {
    _configuration = [configuration copy];
    [self setupLinkageView];
    [self invalidateLayout];
}


#pragma mark -- 私有方法

- (void)setupLinkageView {
    [_linkageView removeFromSuperview];
    if (self.configuration.linkage == nil) {
        _linkageView = nil;
    }else{
        if (_linkageView == nil) {
            _linkageView = [[UIScrollView alloc] init];
            _linkageView.showsVerticalScrollIndicator = NO;
            _linkageView.showsHorizontalScrollIndicator = NO;
            if (@available(iOS 11.0, *)) {
                _linkageView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
    }
}

- (id<TFFallLayoutCompositor>)compositorForSection:(NSInteger)section {
    
#if DEBUG
    NSAssert(self.collectionView, @"collectionView must not be nil");
    NSAssert(self.collectionView.delegate, @"collectionView delegate must not be nil");
    
    BOOL conform = [self.collectionView.delegate conformsToProtocol:@protocol(TFFallLayoutDelegate)];
    NSAssert(conform, @"collectionView delegate must conforms to TFFallLayoutDelegate");
    
    BOOL responds = [self.collectionView.delegate respondsToSelector:@selector(collectionView:collectionViewLayout:compositorForSection:)];
    NSAssert(responds, @"collectionView delegate must responds to collectionView:collectionViewLayout:compositorForSection:");
#endif
    
    return [((id<TFFallLayoutDelegate>)self.collectionView.delegate) collectionView:self.collectionView collectionViewLayout:self compositorForSection:section];
}

- (TFFallLayoutHeader *)headerForSection:(NSInteger)section {
#if DEBUG
    NSAssert(self.collectionView, @"collectionView must not be nil");
    NSAssert(self.collectionView.delegate, @"collectionView delegate must not be nil");
    
    BOOL conform = [self.collectionView.delegate conformsToProtocol:@protocol(TFFallLayoutDelegate)];
    NSAssert(conform, @"collectionView delegate must conforms to TFFallLayoutDelegate");
    
    BOOL responds = [self.collectionView.delegate respondsToSelector:@selector(collectionView:collectionViewLayout:headerForSection:)];
    NSAssert(responds, @"collectionView delegate must responds to collectionView:collectionViewLayout:headerForSection:");
#endif
    
    return [((id<TFFallLayoutDelegate>)self.collectionView.delegate) collectionView:self.collectionView collectionViewLayout:self headerForSection:section];
}

- (TFFallLayoutFooter *)footerForSection:(NSInteger)section {
#if DEBUG
    NSAssert(self.collectionView, @"collectionView must not be nil");
    NSAssert(self.collectionView.delegate, @"collectionView delegate must not be nil");
    
    BOOL conform = [self.collectionView.delegate conformsToProtocol:@protocol(TFFallLayoutDelegate)];
    NSAssert(conform, @"collectionView delegate must conforms to TFFallLayoutDelegate");
    
    BOOL responds = [self.collectionView.delegate respondsToSelector:@selector(collectionView:collectionViewLayout:footerForSection:)];
    NSAssert(responds, @"collectionView delegate must responds to collectionView:collectionViewLayout:footerForSection:");
#endif
    
    return [((id<TFFallLayoutDelegate>)self.collectionView.delegate) collectionView:self.collectionView collectionViewLayout:self footerForSection:section];
}

- (TFFallLayoutBackground *)backgroundForSection:(NSInteger)section {
#if DEBUG
    NSAssert(self.collectionView, @"collectionView must not be nil");
    NSAssert(self.collectionView.delegate, @"collectionView delegate must not be nil");
    
    BOOL conform = [self.collectionView.delegate conformsToProtocol:@protocol(TFFallLayoutDelegate)];
    NSAssert(conform, @"collectionView delegate must conforms to TFFallLayoutDelegate");
    
    BOOL responds = [self.collectionView.delegate respondsToSelector:@selector(collectionView:collectionViewLayout:backgroundForSection:)];
    NSAssert(responds, @"collectionView delegate must responds to collectionView:collectionViewLayout:backgroundForSection:");
#endif
    
    return [((id<TFFallLayoutDelegate>)self.collectionView.delegate) collectionView:self.collectionView collectionViewLayout:self backgroundForSection:section];
}

- (UIEdgeInsets)padingForSection:(NSInteger)section {
#if DEBUG
    NSAssert(self.collectionView, @"collectionView must not be nil");
    NSAssert(self.collectionView.delegate, @"collectionView delegate must not be nil");
    
    BOOL conform = [self.collectionView.delegate conformsToProtocol:@protocol(TFFallLayoutDelegate)];
    NSAssert(conform, @"collectionView delegate must conforms to TFFallLayoutDelegate");
    
    BOOL responds = [self.collectionView.delegate respondsToSelector:@selector(collectionView:collectionViewLayout:paddingForSection:)];
    NSAssert(responds, @"collectionView delegate must responds to collectionView:collectionViewLayout:paddingForSection:");
#endif
    
    return [((id<TFFallLayoutDelegate>)self.collectionView.delegate) collectionView:self.collectionView collectionViewLayout:self paddingForSection:section];
}

- (UIEdgeInsets)marginForSection:(NSInteger)section {
#if DEBUG
    NSAssert(self.collectionView, @"collectionView must not be nil");
    NSAssert(self.collectionView.delegate, @"collectionView delegate must not be nil");
    
    BOOL conform = [self.collectionView.delegate conformsToProtocol:@protocol(TFFallLayoutDelegate)];
    NSAssert(conform, @"collectionView delegate must conforms to TFFallLayoutDelegate");
    
    BOOL responds = [self.collectionView.delegate respondsToSelector:@selector(collectionView:collectionViewLayout:marginForSection:)];
    NSAssert(responds, @"collectionView delegate must responds to collectionView:collectionViewLayout:marginForSection:");
#endif
    
    return [((id<TFFallLayoutDelegate>)self.collectionView.delegate) collectionView:self.collectionView collectionViewLayout:self marginForSection:section];
}

- (CGSize)itemSizeForSection:(NSInteger)section index:(NSInteger)index {
#if DEBUG
    NSAssert(self.collectionView, @"collectionView must not be nil");
    NSAssert(self.collectionView.delegate, @"collectionView delegate must not be nil");
    
    BOOL conform = [self.collectionView.delegate conformsToProtocol:@protocol(TFFallLayoutDelegate)];
    NSAssert(conform, @"collectionView delegate must conforms to TFFallLayoutDelegate");
    
    BOOL responds = [self.collectionView.delegate respondsToSelector:@selector(collectionView:collectionViewLayout:sizeForItemAtIndexPath:)];
    NSAssert(responds, @"collectionView delegate must responds to collectionView:collectionViewLayout:sizeForItemAtIndexPath:");
#endif
    
    return [((id<TFFallLayoutDelegate>)self.collectionView.delegate) collectionView:self.collectionView collectionViewLayout:self sizeForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:section]];
}


- (void)generateLayout {
    [_sections removeAllObjects];
    
    NSInteger numberOfSections = self.collectionView.numberOfSections;
    if (numberOfSections == 0) return;
    
    CGFloat crossScrollDirectionDimension = self.configuration.scrollDirection == UICollectionViewScrollDirectionVertical ? self.collectionView.bounds.size.width : self.collectionView.bounds.size.height;
    
    CGFloat offset = 0;
    for (int index = 0; index < numberOfSections; index++) {
        
        id<TFFallLayoutCompositor> compositor = [self compositorForSection:index];
        TFFallLayoutHeader *header = [self headerForSection:index];
        TFFallLayoutFooter *footer = [self footerForSection:index];
        TFFallLayoutBackground *background = [self backgroundForSection:index];
        UIEdgeInsets margin = [self marginForSection:index];
        UIEdgeInsets padding = [self padingForSection:index];
        TFFallLayoutSection *section = [[TFFallLayoutSection alloc] initWithCompositor:compositor header:header footer:footer background:background padding:padding margin:margin scrollDirection:self.configuration.scrollDirection offset:offset crossScrollDirectionDimension:crossScrollDirectionDimension index:index];
        
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:index];
        NSMutableArray<TFFallLayoutCompositorItemObject *> *allItems = [NSMutableArray arrayWithCapacity:itemCount];
        for (int item = 0; item < itemCount; item++) {
            CGSize size = [self itemSizeForSection:index index:item];
            TFFallLayoutCompositorItemObject *obj = [[TFFallLayoutCompositorItemObject alloc] initWithSize:size index:item];
            [allItems addObject:obj];
        }
        [section prepareItems:allItems];
        
        [_sections addObject:section];
        offset += section.dimension;
    }
}


#pragma mark - 父类方法重写
- (void)prepareLayout {
    
    if (_linkageView && _linkageView.superview) [_linkageView removeFromSuperview];
    
    //collection不存在或者大小为0时，不计算
    if (self.collectionView == nil || (self.configuration.scrollDirection == UICollectionViewScrollDirectionVertical && self.collectionView.bounds.size.width <= 0) || (self.configuration.scrollDirection == UICollectionViewScrollDirectionHorizontal && self.collectionView.bounds.size.height <= 0)) {
        [_sections removeAllObjects];
        return;
    }
        
    [self generateLayout];
    
    if (_linkageView) {
        [self.collectionView addSubview:_linkageView];
        
        _linkageView.frame = self.configuration.scrollDirection == UICollectionViewScrollDirectionVertical ? CGRectMake(0, [self totalDimensionOfSections], self.configuration.linkage.linkageViewPortSize.width, self.configuration.linkage.linkageViewPortSize.height) : CGRectMake([self totalDimensionOfSections], 0, self.configuration.linkage.linkageViewPortSize.width, self.configuration.linkage.linkageViewPortSize.height);
    }
}

- (CGFloat)totalDimensionOfSections {
    __block CGFloat dimension = 0;
    [_sections enumerateObjectsUsingBlock:^(TFFallLayoutSection *section, NSUInteger idx, BOOL * _Nonnull stop) {
        dimension += section.dimension;
    }];
    return dimension;
}

- (CGSize)collectionViewContentSize {
    if (self.collectionView == nil) return CGSizeZero;
    
    switch (self.configuration.scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            CGFloat width = self.collectionView.bounds.size.width;
            CGFloat height = [self totalDimensionOfSections];
            
            if (self.configuration.linkage) {
                height += self.configuration.linkage.linkageViewPortSize.height;
            }
            return CGSizeMake(width, height);
        }
            break;
            
        case UICollectionViewScrollDirectionHorizontal: {
            CGFloat width = [self totalDimensionOfSections];
            CGFloat height = self.collectionView.bounds.size.height;
            
            if (self.configuration.linkage) {
                width += self.configuration.linkage.linkageViewPortSize.width;
            }
            return CGSizeMake(width, height);
        }
            break;
    }
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    //越界处理
    if (indexPath.section < 0 || indexPath.section >= _sections.count) {
        return nil;
    }
    
    TFFallLayoutSection *section = _sections[indexPath.section];
    
    if (elementKind == UICollectionElementKindSectionFooter) {
        return section.footerAttribute;
    }else if (elementKind == UICollectionElementKindSectionBackground) {
        return section.backgroundAttribute;
    }else if (elementKind == UICollectionElementKindSectionHeader) {
        //没有头部
        if (section.headerAttribute == nil) return nil;
        //不需要固定
        if (section.header == nil || section.header.stick == nil) return section.headerAttribute;
        
        CGFloat offset = self.configuration.scrollDirection == UICollectionViewScrollDirectionVertical ? self.collectionView.contentOffset.y : self.collectionView.contentOffset.x;
        
        //当前分组的偏移量
        CGFloat sectionOffset = section.offset;
        
        CGFloat minOffset = sectionOffset + (self.configuration.scrollDirection == UICollectionViewScrollDirectionVertical ? section.margin.top : section.margin.left);
        
        CGFloat footerDimension = self.configuration.scrollDirection == UICollectionViewScrollDirectionVertical ? CGRectGetHeight(section.footerAttribute.frame) : CGRectGetWidth(section.footerAttribute.frame);
        CGFloat marginDimension = self.configuration.scrollDirection == UICollectionViewScrollDirectionVertical ? section.margin.bottom : section.margin.right;
        CGFloat maxOffset = sectionOffset + section.dimension - marginDimension - footerDimension;
        
        CGRect frame = section.headerAttribute.frame;
        switch (self.configuration.scrollDirection) {
            case UICollectionViewScrollDirectionVertical:
                frame.origin.y = MIN(maxOffset-section.header.dimension, MAX(minOffset, offset+section.header.stick.offset));
                break;
                
            case UICollectionViewScrollDirectionHorizontal:
                frame.origin.x = MIN(maxOffset-section.header.dimension, MAX(minOffset, offset+section.header.stick.offset));
                break;
        }
        
        section.headerAttribute.frame = frame;
        return section.headerAttribute;
    }
    
    return nil;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //分组越界处理
    if (indexPath.section < 0 || indexPath.section >= _sections.count) {
        return nil;
    }
    
    TFFallLayoutSection *section = _sections[indexPath.section];

    //item越界处理
    if (indexPath.item < 0 || indexPath.item >= section.items.count) {
        return nil;
    }
    return section.items[indexPath.item];
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray<UICollectionViewLayoutAttributes *> *all = [NSMutableArray array];
    [_sections enumerateObjectsUsingBlock:^(TFFallLayoutSection *section, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![section intersectsWithRect:rect]) return;
        
        NSArray *items = [section itemsInRect:rect];
        [all addObjectsFromArray:items];
        
        UICollectionViewLayoutAttributes *background = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionBackground atIndexPath:section.indexPath];
        if (background && CGRectIntersectsRect(background.frame, rect)) {
            [all addObject:background];
        }
        
        UICollectionViewLayoutAttributes *footer = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:section.indexPath];
        if (footer && CGRectIntersectsRect(footer.frame, rect)) {
            [all addObject:footer];
        }
        
        UICollectionViewLayoutAttributes *header = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:section.indexPath];
        if (header && CGRectIntersectsRect(header.frame, rect)) {
            [all addObject:header];
        }
    }];
    return all;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    if (self.collectionView == nil) return NO;
    BOOL sizeChange = !CGSizeEqualToSize(self.collectionView.bounds.size, newBounds.size);

    //如果size改变了，直接重新布局
    if (sizeChange) return YES;
    
    //如果size没有改变
    NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
    [_sections enumerateObjectsUsingBlock:^(TFFallLayoutSection *section, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![section intersectsWithRect:newBounds]) return;
        if (section.header.stick == nil) return;
        [indexPaths addObject:section.indexPath];
    }];
    
    if (indexPaths.count > 0) {
        UICollectionViewLayoutInvalidationContext *context = [[UICollectionViewLayoutInvalidationContext alloc] init];
        [context invalidateSupplementaryElementsOfKind:UICollectionElementKindSectionHeader atIndexPaths:indexPaths];
        [self invalidateLayoutWithContext:context];
    }
    
    return NO;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingSupplementaryElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)elementIndexPath {
    return [self layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:elementIndexPath];
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingSupplementaryElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)elementIndexPath {
    return [self layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:elementIndexPath];
}


#pragma mark - 公共方法
- (CGFloat)originXOfSection:(NSInteger)section {
    return [self offsetDimensionOfSection:section];
}

- (CGFloat)offsetDimensionOfSection:(NSInteger)section {
    //越界处理
    if (section < 0 || section >= _sections.count) {
        return 0;
    }
    
    return _sections[section].offset;
}

@end
