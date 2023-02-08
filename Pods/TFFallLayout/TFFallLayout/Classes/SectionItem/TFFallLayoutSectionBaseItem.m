//
//  TFFallLayoutSectionBaseItem.m
//  TFFallLayout
//
//  Created by 黄楠 on 2021/3/4.
//

#import "TFFallLayoutSectionBaseItem.h"

@implementation TFFallLayoutSectionBaseItem

- (instancetype)init {
    self = [super init];
    if (self) {
        _sectionHeaderDimension = 0;
        _sectionFooterDimension = 0;
        _sectionPadding = UIEdgeInsetsZero;
        _sectionMargin = UIEdgeInsetsZero;
        _stick = nil;
        _headerZIndex = TFFallLayoutZIndexTopOfItem;
    }
    return self;
}

- (id<TFFallLayoutCompositor>)compositor {
    NSAssert(false, @"不要直接使用这个类，请使用 `TFFallLayoutSectionItem` 或者 `TFFallLayoutFlowSectionItem`");
    return nil;
}

- (TFFallLayoutHeader *)header {
    if (self.headerItem == nil) return nil;
    return [[TFFallLayoutHeader alloc] initWithDimension:self.sectionHeaderDimension stick:self.stick zIndex:self.headerZIndex];
}

- (TFFallLayoutFooter *)footer {
    if (self.footerItem == nil) return nil;
    return [[TFFallLayoutFooter alloc] initWithDimension:self.sectionFooterDimension];
}

- (TFFallLayoutBackground *)background {
    if (self.backgroundItem == nil) return nil;
    return [[TFFallLayoutBackground alloc] init];
}

@end


@implementation TFFallLayoutSectionBaseItem (Deprecated)

- (CGFloat)sectionFooterHeight {
    return _sectionFooterDimension;
}

- (CGFloat)sectionHeaderHeight {
    return _sectionHeaderDimension;
}

- (void)setSectionFooterHeight:(CGFloat)sectionFooterHeight {
    _sectionFooterDimension = sectionFooterHeight;
}

- (void)setSectionHeaderHeight:(CGFloat)sectionHeaderHeight {
    _sectionHeaderDimension = sectionHeaderHeight;
}

@end
