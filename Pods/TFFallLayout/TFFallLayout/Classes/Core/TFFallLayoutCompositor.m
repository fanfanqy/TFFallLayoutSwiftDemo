//
//  TFFallLayoutCompositor.m
//  TFFallLayout
//
//  Created by 黄楠 on 2021/2/26.
//

#import "TFFallLayoutCompositor.h"
#import "TFFallLayoutColumn.h"


@implementation TFFallLayoutCompositorItemObject

- (instancetype)initWithSize:(CGSize)size index:(NSInteger)index {
    self = [super init];
    if (self) {
        _size = size;
        _index = index;
    }
    return self;
}

@end

@implementation TFFallLayoutCompositorResult

- (instancetype)initWithHeaderAttributes:(UICollectionViewLayoutAttributes *)headerAttributes footerAttributes:(UICollectionViewLayoutAttributes *)footerAttributes backgroundAttributes:(UICollectionViewLayoutAttributes *)backgroundAttributes itemAttributes:(NSArray<UICollectionViewLayoutAttributes *> *)itemAttributes sectionRect:(CGRect)sectionRect {
    self = [super init];
    if (self) {
        _headerAttributes = headerAttributes;
        _footerAttributes = footerAttributes;
        _backgroundAttributes = backgroundAttributes;
        _itemAttributes = itemAttributes.copy;
        _sectionRect = sectionRect;
    }
    return self;
}

@end


@interface TFFallLayoutCompositor ()
/// 渲染轴
@property (nonatomic, strong) TFFallLayoutRender *render;
/// 列数
@property (nonatomic, assign) NSInteger columnCount;
/// 列间距
@property (nonatomic, assign) CGFloat columnSpacing;
/// 元素间距，水平轴为水平间距，垂直轴为垂直间距
@property (nonatomic, assign) CGFloat itemSpacing;
@end

@implementation TFFallLayoutCompositor

- (instancetype)initWithRender:(TFFallLayoutRender *)render columnCount:(NSInteger)columnCount columnSpacing:(CGFloat)columnSpacing itemSpacing:(CGFloat)itemSpacing {
    self = [super init];
    if (self) {
        _render = render;
        _columnCount = MAX(columnCount, 1);
        _columnSpacing = columnSpacing;
        _itemSpacing = itemSpacing;
    }
    return self;
}

#pragma mark - TFFallLayoutCompositor Protocol


- (TFFallLayoutCompositorResult *)prepareItems:(NSArray<TFFallLayoutCompositorItemObject *> *)items header:(TFFallLayoutHeader *)header footer:(TFFallLayoutFooter *)footer background:(TFFallLayoutBackground *)background padding:(UIEdgeInsets)padding margin:(UIEdgeInsets)margin scrollDirection:(UICollectionViewScrollDirection)scrollDirection offset:(CGFloat)offset crossScrollDirectionDimension:(CGFloat)crossScrollDirectionDimension sectionIndex:(NSInteger)sectionIndex {
    
    CGFloat finalOffset = offset;
    
    UICollectionViewLayoutAttributes *headerAttributes = [self prepareHeader:header margin:margin scrollDirection:scrollDirection offset:&finalOffset crossScrollDirectionDimension:crossScrollDirectionDimension sectionIndex:sectionIndex];
    
    NSArray<UICollectionViewLayoutAttributes *> *itemAttributes = [self prepareItems:items padding:padding margin:margin scrollDirection:scrollDirection offset:&finalOffset crossScrollDirectionDimension:crossScrollDirectionDimension sectionIndex:sectionIndex];
    
    UICollectionViewLayoutAttributes *footerAttributes = [self prepareFooter:footer margin:margin scrollDirection:scrollDirection offset:&finalOffset crossScrollDirectionDimension:crossScrollDirectionDimension sectionIndex:sectionIndex];
    
    UICollectionViewLayoutAttributes *backgroundAttributes = [self prepareBackground:background scrollDirection:scrollDirection beginOffset:offset finalOffset:finalOffset crossScrollDirectionDimension:crossScrollDirectionDimension sectionIndex:sectionIndex];
    
    CGRect rect;
    switch (scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            rect = CGRectMake(0, offset, crossScrollDirectionDimension, finalOffset-offset);
        }
            break;
            
        case UICollectionViewScrollDirectionHorizontal: {
            rect = CGRectMake(offset, 0, finalOffset-offset, crossScrollDirectionDimension);
        }
            break;
    }
    
    TFFallLayoutCompositorResult *result = [[TFFallLayoutCompositorResult alloc] initWithHeaderAttributes:headerAttributes footerAttributes:footerAttributes backgroundAttributes:backgroundAttributes itemAttributes:itemAttributes sectionRect:rect];
    return result;
}

#pragma mark - private

- (UICollectionViewLayoutAttributes *)prepareHeader:(TFFallLayoutHeader *)header margin:(UIEdgeInsets)margin scrollDirection:(UICollectionViewScrollDirection)scrollDirection offset:(CGFloat *)offset crossScrollDirectionDimension:(CGFloat)crossScrollDirectionDimension sectionIndex:(NSInteger)sectionIndex {
    
    switch (scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            *offset = (*offset + margin.top);
        }
            break;
            
        case UICollectionViewScrollDirectionHorizontal: {
            *offset = (*offset + margin.left);
        }
            break;
    }
    
    if (!header) return nil;
    
    CGFloat width = 0;
    CGFloat height = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    
    switch (scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            width = crossScrollDirectionDimension - margin.left - margin.right;
            height = header.dimension;
            x = margin.left;
            y = *offset;
            *offset = (*offset + height);
        }
            break;
            
        case UICollectionViewScrollDirectionHorizontal: {
            width = header.dimension;
            height = crossScrollDirectionDimension - margin.top - margin.bottom;
            x = *offset;
            y = margin.top;
            *offset = (*offset + width);
        }
            break;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:sectionIndex];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
    attributes.frame = CGRectMake(x, y, width, height);
    attributes.zIndex = header.zIndex;
    
    
    return attributes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)prepareItems:(NSArray<TFFallLayoutCompositorItemObject *> *)items padding:(UIEdgeInsets)padding margin:(UIEdgeInsets)margin scrollDirection:(UICollectionViewScrollDirection)scrollDirection offset:(CGFloat *)offset crossScrollDirectionDimension:(CGFloat)crossScrollDirectionDimension sectionIndex:(NSInteger)sectionIndex {

    CGFloat itemCrossScrollDirectionDimension;
    CGFloat paddingTopOrLeftDimension;
    switch (scrollDirection) {
        case UICollectionViewScrollDirectionVertical:
            itemCrossScrollDirectionDimension = (crossScrollDirectionDimension - margin.left - padding.left - padding.right - margin.right - (self.columnCount-1)*self.columnSpacing)/self.columnCount;
            paddingTopOrLeftDimension = padding.top;
            break;
            
        case UICollectionViewScrollDirectionHorizontal:
            itemCrossScrollDirectionDimension = (crossScrollDirectionDimension - margin.top - padding.top - padding.bottom - margin.bottom - (self.columnCount-1)*self.columnSpacing)/self.columnCount;
            paddingTopOrLeftDimension = padding.left;

            break;
    }
    
    itemCrossScrollDirectionDimension = ceil(itemCrossScrollDirectionDimension * UIScreen.mainScreen.scale)/UIScreen.mainScreen.scale; //像素对齐
    *offset = (*offset + paddingTopOrLeftDimension);
    
    NSMutableArray<UICollectionViewLayoutAttributes *> *allAttributes = [NSMutableArray arrayWithCapacity:items.count];
    NSMutableArray<TFFallLayoutColumn *> *columns = [NSMutableArray arrayWithCapacity:self.columnCount];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [columns addObject:[[TFFallLayoutColumn alloc] init]];
    }

    for (int i = 0; i < items.count; i++) {
        CGSize size = items[i].size;
        NSInteger index = items[i].index;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:sectionIndex];

        NSInteger nextColumnIndex = [self nextColumnIndexForItemAtIndex:i withColumns:columns scrollDirection:scrollDirection];
        TFFallLayoutColumn *column = columns[nextColumnIndex];
        CGFloat itemSpacing = column.items.count > 0 ? self.itemSpacing : 0;


        CGFloat width = size.width;
        CGFloat height = size.height;
        CGFloat x;
        CGFloat y;
        
        switch (scrollDirection) {
            case UICollectionViewScrollDirectionVertical: {
                switch (self.render.axis) {
                    case TFFallLayoutRenderAxisHorizontal: {
                        x = margin.left + padding.left + column.width + itemSpacing;
                        y = *offset;
                    }
                        break;

                    case TFFallLayoutRenderAxisVertical: {
                        x = margin.left + padding.left + nextColumnIndex * (itemCrossScrollDirectionDimension + self.columnSpacing);
                        y = *offset + itemSpacing + column.height;
                    }
                        break;
                }
            }
                break;

            case UICollectionViewScrollDirectionHorizontal: {
                switch (self.render.axis) {
                    case TFFallLayoutRenderAxisHorizontal: {
                        x = *offset + column.width + itemSpacing;
                        y = margin.top + padding.top + nextColumnIndex * (itemCrossScrollDirectionDimension + self.columnSpacing);
                    }
                        break;

                    case TFFallLayoutRenderAxisVertical: {
                        x = *offset;
                        y = margin.top + padding.top + column.height + itemSpacing;
                    }
                        break;
                }
            }
                break;
        }
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

        /// Fixed:rect为CGRectNull时的Crash
        CGRect rect = CGRectMake(x, y, width, height);
        if (CGRectIsNull(rect)) {
            rect = CGRectZero;
        }
        
        attributes.frame = rect;
        attributes.zIndex = TFFallLayoutZIndexItem;
        
        [column push:attributes];
        [allAttributes addObject:attributes];
    }
    
    
    switch (scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            switch (self.render.axis) {
                case TFFallLayoutRenderAxisHorizontal: {
                    TFFallLayoutColumn *column = columns.firstObject;
                    *offset = *offset + column.height + padding.bottom;
                }
                    break;

                case TFFallLayoutRenderAxisVertical: {
                    CGFloat maxColumnDimension = [self maxColumnDimensionWithColumns:columns renderAxis:TFFallLayoutRenderAxisVertical];
                    *offset = *offset + maxColumnDimension + padding.bottom;
                }
                    break;
            }
        }
            break;

        case UICollectionViewScrollDirectionHorizontal: {
            switch (self.render.axis) {
                case TFFallLayoutRenderAxisHorizontal: {
                    CGFloat maxColumnDimension = [self maxColumnDimensionWithColumns:columns renderAxis:TFFallLayoutRenderAxisHorizontal];
                    *offset = *offset + maxColumnDimension + padding.right;
                }
                    break;

                case TFFallLayoutRenderAxisVertical: {
                    TFFallLayoutColumn *column = columns.firstObject;
                    *offset = *offset + column.width + padding.right;
                }
                    break;
            }
        }
            break;
    }

    return allAttributes;
}

- (CGFloat)maxColumnDimensionWithColumns:(NSArray<TFFallLayoutColumn *> *)columns renderAxis:(TFFallLayoutRenderAxis)renderAxis {
    CGFloat dimension = 0;
    
    for (NSInteger i = 0; i < columns.count; i++) {
        switch (renderAxis) {
            case TFFallLayoutRenderAxisVertical: {
                CGFloat height = columns[i].height;
                if (height > dimension) dimension = height;
                break;
            }
                
            case TFFallLayoutRenderAxisHorizontal: {
                CGFloat width = columns[i].width;
                if (width > dimension) dimension = width;
                break;
            }
        }
    }
    
    return dimension;
}


- (NSInteger)shortestColumnIndexWithColumns:(NSArray<TFFallLayoutColumn *> *)columns renderAxis:(TFFallLayoutRenderAxis)renderAxis {
    NSInteger index = 0;
    
    for (NSInteger i = index+1; i < columns.count; i++) {
        switch (renderAxis) {
            case TFFallLayoutRenderAxisVertical:
                if (columns[i].height < columns[index].height) index = i;
                break;
                
            case TFFallLayoutRenderAxisHorizontal:
                if (columns[i].width < columns[index].width) index = i;
                break;
        }
    }
    
    return index;
}

- (NSInteger)nextColumnIndexForItemAtIndex:(NSInteger)index withColumns:(NSArray<TFFallLayoutColumn *> *)columns scrollDirection:(UICollectionViewScrollDirection)scrollDirection {
#if DEBUG
    NSAssert(columns.count > 0, @"column count be great than 0");
#endif
    
    switch (scrollDirection) {
        //垂直滚动
        case UICollectionViewScrollDirectionVertical: {
            
            switch (self.render.axis) {
                case TFFallLayoutRenderAxisHorizontal:
                    return 0;
                    
                case TFFallLayoutRenderAxisVertical: {
                    switch (self.render.direction) {
                        case TFFallLayoutRenderDirectionShortest:
                            return [self shortestColumnIndexWithColumns:columns renderAxis:TFFallLayoutRenderAxisVertical];
                        case TFFallLayoutRenderDirectionLeftToRight:
                            return index % self.columnCount;
                        case TFFallLayoutRenderDirectionRightToLeft:
                            return (self.columnCount-1) - (index+1)%self.columnCount;
                    }
                }
            }
            
        }
        
        //水平滚动
        case UICollectionViewScrollDirectionHorizontal: {
            
            switch (self.render.axis) {
                case TFFallLayoutRenderAxisVertical:
                    return 0;
                    
                case TFFallLayoutRenderAxisHorizontal: {
                    switch (self.render.direction) {
                        case TFFallLayoutRenderDirectionShortest:
                            return [self shortestColumnIndexWithColumns:columns renderAxis:TFFallLayoutRenderAxisHorizontal];
                        case TFFallLayoutRenderDirectionTopToBottom:
                            return index % self.columnCount;
                        case TFFallLayoutRenderDirectionBottomToTop:
                            return (self.columnCount-1) - (index+1)%self.columnCount;
                    }
                }
            }
            
        }
    }
}


- (UICollectionViewLayoutAttributes *)prepareFooter:(TFFallLayoutFooter *)footer margin:(UIEdgeInsets)margin scrollDirection:(UICollectionViewScrollDirection)scrollDirection offset:(CGFloat *)offset crossScrollDirectionDimension:(CGFloat)crossScrollDirectionDimension sectionIndex:(NSInteger)sectionIndex {
    
    
    if (!footer) {
        switch (scrollDirection) {
            case UICollectionViewScrollDirectionVertical: {
                *offset = (*offset + margin.bottom);
            }
                break;
                
            case UICollectionViewScrollDirectionHorizontal: {
                *offset = (*offset + margin.right);
            }
                break;
        }
        
        return nil;
    }
    
    CGFloat width = 0;
    CGFloat height = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    
    switch (scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            width = crossScrollDirectionDimension - margin.left - margin.right;
            height = footer.dimension;
            x = margin.left;
            y = *offset;
            *offset = (*offset + height + margin.bottom);
        }
            break;
            
        case UICollectionViewScrollDirectionHorizontal: {
            width = footer.dimension;
            height = crossScrollDirectionDimension - margin.top - margin.bottom;
            x = *offset;
            y = margin.top;
            *offset = (*offset + width + margin.right);
        }
            break;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:sectionIndex];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:indexPath];
    attributes.frame = CGRectMake(x, y, width, height);
    attributes.zIndex = TFFallLayoutZIndexTopOfItem;
    return attributes;
}

- (UICollectionViewLayoutAttributes *)prepareBackground:(TFFallLayoutBackground *)background scrollDirection:(UICollectionViewScrollDirection)scrollDirection beginOffset:(CGFloat)beginOffset finalOffset:(CGFloat)finalOffset crossScrollDirectionDimension:(CGFloat)crossScrollDirectionDimension sectionIndex:(NSInteger)sectionIndex {

    if (!background) return nil;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:sectionIndex];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionBackground withIndexPath:indexPath];
    attributes.frame = scrollDirection == UICollectionViewScrollDirectionVertical ? CGRectMake(0, beginOffset, crossScrollDirectionDimension, finalOffset-beginOffset) : CGRectMake(beginOffset, 0, finalOffset-beginOffset, crossScrollDirectionDimension);
    attributes.zIndex = TFFallLayoutZIndexBackground;
    return attributes;
}



@end





@interface TFFallLayoutFlowCompositor ()
///元素主轴方向上的尺寸
@property (nonatomic, assign) CGFloat itemDimension;
/// 列间距
@property (nonatomic, assign) CGFloat columnSpacing;
/// 元素间距，水平轴为水平间距，垂直轴为垂直间距
@property (nonatomic, assign) CGFloat itemSpacing;
@end


@implementation TFFallLayoutFlowCompositor

- (instancetype)initWithItemDimension:(CGFloat)itemDimension columnSpacing:(CGFloat)columnSpacing itemSpacing:(CGFloat)itemSpacing {
    self = [super init];
    if (self) {
        _itemDimension = itemDimension;
        _columnSpacing = columnSpacing;
        _itemSpacing = itemSpacing;
    }
    return self;
}


#pragma mark - TFFallLayoutCompositor Protocol
- (TFFallLayoutCompositorResult *)prepareItems:(NSArray<TFFallLayoutCompositorItemObject *> *)items header:(TFFallLayoutHeader *)header footer:(TFFallLayoutFooter *)footer background:(TFFallLayoutBackground *)background padding:(UIEdgeInsets)padding margin:(UIEdgeInsets)margin scrollDirection:(UICollectionViewScrollDirection)scrollDirection offset:(CGFloat)offset crossScrollDirectionDimension:(CGFloat)crossScrollDirectionDimension sectionIndex:(NSInteger)sectionIndex {
    
    CGFloat finalOffset = offset;
    
    UICollectionViewLayoutAttributes *headerAttributes = [self prepareHeader:header margin:margin scrollDirection:scrollDirection offset:&finalOffset crossScrollDirectionDimension:crossScrollDirectionDimension sectionIndex:sectionIndex];
    
    NSArray<UICollectionViewLayoutAttributes *> *itemAttributes = [self prepareItems:items padding:padding margin:margin scrollDirection:scrollDirection offset:&finalOffset crossScrollDirectionDimension:crossScrollDirectionDimension sectionIndex:sectionIndex];
    
    UICollectionViewLayoutAttributes *footerAttributes = [self prepareFooter:footer margin:margin scrollDirection:scrollDirection offset:&finalOffset crossScrollDirectionDimension:crossScrollDirectionDimension sectionIndex:sectionIndex];
    
    UICollectionViewLayoutAttributes *backgroundAttributes = [self prepareBackground:background scrollDirection:scrollDirection beginOffset:offset finalOffset:finalOffset crossScrollDirectionDimension:crossScrollDirectionDimension sectionIndex:sectionIndex];
    
    
    CGRect rect = scrollDirection == UICollectionViewScrollDirectionVertical ? CGRectMake(0, offset, crossScrollDirectionDimension, finalOffset-offset) : CGRectMake(offset, 0, finalOffset-offset, crossScrollDirectionDimension);
    
    TFFallLayoutCompositorResult *result = [[TFFallLayoutCompositorResult alloc] initWithHeaderAttributes:headerAttributes footerAttributes:footerAttributes backgroundAttributes:backgroundAttributes itemAttributes:itemAttributes sectionRect:rect];
    return result;
}

#pragma mark - private

- (UICollectionViewLayoutAttributes *)prepareHeader:(TFFallLayoutHeader *)header margin:(UIEdgeInsets)margin scrollDirection:(UICollectionViewScrollDirection)scrollDirection offset:(CGFloat *)offset crossScrollDirectionDimension:(CGFloat)crossScrollDirectionDimension sectionIndex:(NSInteger)sectionIndex {
    
    switch (scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            *offset = (*offset + margin.top);
        }
            break;
            
        case UICollectionViewScrollDirectionHorizontal: {
            *offset = (*offset + margin.left);
        }
            break;
    }
    
    if (!header) return nil;
    
    CGFloat width = 0;
    CGFloat height = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    
    switch (scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            width = crossScrollDirectionDimension - margin.left - margin.right;
            height = header.dimension;
            x = margin.left;
            y = *offset;
            *offset = (*offset + height);
        }
            break;
            
        case UICollectionViewScrollDirectionHorizontal: {
            width = header.dimension;
            height = crossScrollDirectionDimension - margin.top - margin.bottom;
            x = *offset;
            y = margin.top;
            *offset = (*offset + width);
        }
            break;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:sectionIndex];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
    attributes.frame = CGRectMake(x, y, width, height);
    attributes.zIndex = header.zIndex;
    
    
    return attributes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)prepareItems:(NSArray<TFFallLayoutCompositorItemObject *> *)items padding:(UIEdgeInsets)padding margin:(UIEdgeInsets)margin scrollDirection:(UICollectionViewScrollDirection)scrollDirection offset:(CGFloat *)offset crossScrollDirectionDimension:(CGFloat)crossScrollDirectionDimension sectionIndex:(NSInteger)sectionIndex {

    CGFloat maxItemCrossScrollDirectionDimension;
    CGFloat paddingTopOrLeftDimension;
    CGFloat paddingBottomOrRightDimension;
    switch (scrollDirection) {
        case UICollectionViewScrollDirectionVertical:
            maxItemCrossScrollDirectionDimension = crossScrollDirectionDimension - margin.left - padding.left - padding.right - margin.right;
            paddingTopOrLeftDimension = padding.top;
            paddingBottomOrRightDimension = padding.bottom;
            break;

        case UICollectionViewScrollDirectionHorizontal:
            maxItemCrossScrollDirectionDimension = crossScrollDirectionDimension - margin.top - padding.top - padding.bottom - margin.bottom;
            paddingTopOrLeftDimension = padding.left;
            paddingBottomOrRightDimension = padding.right;
            break;
    }
    
    maxItemCrossScrollDirectionDimension = ceil(maxItemCrossScrollDirectionDimension * UIScreen.mainScreen.scale)/UIScreen.mainScreen.scale; //像素对齐
    *offset = (*offset + paddingTopOrLeftDimension);
    
    NSMutableArray<UICollectionViewLayoutAttributes *> *allAttributes = [NSMutableArray arrayWithCapacity:items.count];


    for (int i = 0; i < items.count; i++) {
        CGSize size = items[i].size;
        NSInteger index = items[i].index;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:sectionIndex];

        UICollectionViewLayoutAttributes *last = allAttributes.lastObject;

        CGFloat lastCrossMaxDimension; //1⃣️
        CGFloat lastMinDimension; //2⃣️
        CGFloat lastMaxDimension; //3⃣️
        CGFloat itemCrossDimension; //4⃣️
        CGFloat crossPaddingAndMargin; //5⃣️
        CGFloat paddingAndHeaderAndMarginAndOffset; //6⃣️
        
        /**
         //垂直滚动
         |        6⃣️
         |        ⬇️
         |     --------       ----------  |
         |5⃣️➡️|        |     |          | |
         |     --------       ----------  |
         |                                |
         |        2⃣️                      |
         |        ⬇️                      |
         |     --------                   |
         |    |   1⃣️ ➡️|                  |
         |    |        |                  |
         |    |⬅️ 4⃣️ ➡️|                  |
         |    |        |                  |
         |    |   3⃣️   |                  |
         |    |   ⬇️   |                  |
         |     --------                   |
         |                                |
         
         //水平滚动
         类似
         */
        switch (scrollDirection) {
            case UICollectionViewScrollDirectionVertical: {
                lastCrossMaxDimension = CGRectGetMaxX(last.frame);
                lastMinDimension = CGRectGetMinY(last.frame);
                lastMaxDimension = lastMinDimension + self.itemDimension;
                itemCrossDimension = MIN(maxItemCrossScrollDirectionDimension, size.width);
                crossPaddingAndMargin = margin.left + padding.left;
                paddingAndHeaderAndMarginAndOffset = *offset;
            }
                break;
                
            case UICollectionViewScrollDirectionHorizontal: {
                lastCrossMaxDimension = CGRectGetMaxY(last.frame);
                lastMinDimension = CGRectGetMinX(last.frame);
                lastMaxDimension = lastMinDimension + self.itemDimension;
                itemCrossDimension = MIN(maxItemCrossScrollDirectionDimension, size.height);
                crossPaddingAndMargin = margin.top + padding.top;
                paddingAndHeaderAndMarginAndOffset = *offset;
            }
                break;
        }
        
        CGFloat nextX = 0;
        CGFloat nextY = 0;
        
        if (last == nil) {
            nextX = scrollDirection == UICollectionViewScrollDirectionVertical ? crossPaddingAndMargin : paddingAndHeaderAndMarginAndOffset;
            nextY = scrollDirection == UICollectionViewScrollDirectionVertical ? paddingAndHeaderAndMarginAndOffset : crossPaddingAndMargin;
        }else{
            if (lastCrossMaxDimension + self.columnSpacing + itemCrossDimension <= crossPaddingAndMargin + maxItemCrossScrollDirectionDimension) {
                nextX = scrollDirection == UICollectionViewScrollDirectionVertical ? lastCrossMaxDimension + self.columnSpacing : lastMinDimension;
                nextY = scrollDirection == UICollectionViewScrollDirectionVertical ? lastMinDimension : lastCrossMaxDimension + _columnSpacing;
            }else{
                nextX = scrollDirection == UICollectionViewScrollDirectionVertical ? crossPaddingAndMargin : lastMaxDimension + _itemSpacing;
                nextY = scrollDirection == UICollectionViewScrollDirectionVertical ? lastMaxDimension + _itemSpacing : crossPaddingAndMargin;
            }
        }

        CGFloat width = scrollDirection == UICollectionViewScrollDirectionVertical ? itemCrossDimension : size.width;
        CGFloat height = scrollDirection == UICollectionViewScrollDirectionVertical ? size.height : itemCrossDimension;
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        /// Fixed:rect为CGRectNull时的Crash
        CGRect rect = CGRectMake(nextX, nextY, width, height);
        if (CGRectIsNull(rect)) {
            rect = CGRectZero;
        }
        
        attributes.frame = rect;
        attributes.zIndex = TFFallLayoutZIndexItem;
        
        [allAttributes addObject:attributes];
    }


    switch (scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            CGFloat maxY = CGRectGetMaxY(allAttributes.lastObject.frame);
            CGFloat minY = CGRectGetMinY(allAttributes.firstObject.frame);
            *offset = *offset + maxY - minY + padding.bottom;
        }
            break;

        case UICollectionViewScrollDirectionHorizontal: {
            CGFloat maxX = CGRectGetMaxX(allAttributes.lastObject.frame);
            CGFloat minX = CGRectGetMinX(allAttributes.firstObject.frame);
            *offset = *offset + maxX - minX + padding.right;
        }
            break;
    }

    return allAttributes;
}


- (UICollectionViewLayoutAttributes *)prepareFooter:(TFFallLayoutFooter *)footer margin:(UIEdgeInsets)margin scrollDirection:(UICollectionViewScrollDirection)scrollDirection offset:(CGFloat *)offset crossScrollDirectionDimension:(CGFloat)crossScrollDirectionDimension sectionIndex:(NSInteger)sectionIndex {
    
    
    if (!footer) {
        switch (scrollDirection) {
            case UICollectionViewScrollDirectionVertical: {
                *offset = (*offset + margin.bottom);
            }
                break;
                
            case UICollectionViewScrollDirectionHorizontal: {
                *offset = (*offset + margin.right);
            }
                break;
        }
        
        return nil;
    }
    
    CGFloat width = 0;
    CGFloat height = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    
    switch (scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            width = crossScrollDirectionDimension - margin.left - margin.right;
            height = footer.dimension;
            x = margin.left;
            y = *offset;
            *offset = (*offset + height + margin.bottom);
        }
            break;
            
        case UICollectionViewScrollDirectionHorizontal: {
            width = footer.dimension;
            height = crossScrollDirectionDimension - margin.top - margin.bottom;
            x = *offset;
            y = margin.top;
            *offset = (*offset + width + margin.right);
        }
            break;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:sectionIndex];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:indexPath];
    attributes.frame = CGRectMake(x, y, width, height);
    attributes.zIndex = TFFallLayoutZIndexTopOfItem;
    return attributes;
}

- (UICollectionViewLayoutAttributes *)prepareBackground:(TFFallLayoutBackground *)background scrollDirection:(UICollectionViewScrollDirection)scrollDirection beginOffset:(CGFloat)beginOffset finalOffset:(CGFloat)finalOffset crossScrollDirectionDimension:(CGFloat)crossScrollDirectionDimension sectionIndex:(NSInteger)sectionIndex {

    if (!background) return nil;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:sectionIndex];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionBackground withIndexPath:indexPath];
    attributes.frame = scrollDirection == UICollectionViewScrollDirectionVertical ? CGRectMake(0, beginOffset, crossScrollDirectionDimension, finalOffset-beginOffset) : CGRectMake(beginOffset, 0, finalOffset-beginOffset, crossScrollDirectionDimension);
    attributes.zIndex = TFFallLayoutZIndexBackground;
    return attributes;
}

@end
