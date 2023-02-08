//
//  TFFallLayoutSectionItem.m
//
//  Created by zerozheng on 2018/11/28.
//  Copyright © 2018 JingLing. All rights reserved.
//

#import "TFFallLayoutSectionItem.h"

@interface TFFallLayoutSectionItem ()

@end

@implementation TFFallLayoutSectionItem

- (instancetype)init {
    self = [super init];
    if (self) {
        _render = [[TFFallLayoutRender alloc] initWithAxis:TFFallLayoutRenderAxisVertical direction:TFFallLayoutRenderDirectionLeftToRight];
        _columnCount = 1;
        _columnSpacing = 0;
        _itemSpacing = 0;
    }
    return self;
}


- (id<TFFallLayoutCompositor>)compositor {
    TFFallLayoutCompositor *compositor = [[TFFallLayoutCompositor alloc] initWithRender:self.render columnCount:self.columnCount columnSpacing:self.columnSpacing itemSpacing:self.itemSpacing];
    return compositor;
}

@end
