//
//  TFFallEmptyHeaderFooterItem.m
//
//  Created by zerozheng on 2019/2/18.
//  Copyright © 2018 JingLing. All rights reserved.
//

#import "TFFallEmptyHeaderFooterItem.h"
#import "TFFallEmptyHeaderFooterCell.h"

@implementation TFFallEmptyHeaderFooterItem

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cellClass = [TFFallEmptyHeaderFooterCell class];
        self.cellType = @"TFFallEmptyHeaderFooterCell";
        self.useNib = NO;
    }
    return self;
}

@end
