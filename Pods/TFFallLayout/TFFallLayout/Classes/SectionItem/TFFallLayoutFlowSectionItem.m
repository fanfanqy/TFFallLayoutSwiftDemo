//
//  TFFallLayoutFlowSectionItem.m
//  TFFallLayout
//
//  Created by 黄楠 on 2021/3/4.
//

#import "TFFallLayoutFlowSectionItem.h"

@implementation TFFallLayoutFlowSectionItem

- (instancetype)init {
    self = [super init];
    if (self) {
        _itemDimension = 30;
        _columnSpacing = 15;
        _itemSpacing = 15;
    }
    return self;
}


- (id<TFFallLayoutCompositor>)compositor {
    TFFallLayoutFlowCompositor *compositor = [[TFFallLayoutFlowCompositor alloc] initWithItemDimension:self.itemDimension columnSpacing:self.columnSpacing itemSpacing:self.itemSpacing];
    return compositor;
}

@end
