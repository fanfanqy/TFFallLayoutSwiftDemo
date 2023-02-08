//
//  TFFallEmptyHeaderFooterCell.m
//
//  Created by zerozheng on 2019/2/18.
//  Copyright © 2018 JingLing. All rights reserved.
//

#import "TFFallEmptyHeaderFooterCell.h"
#import "TFFallEmptyHeaderFooterItem.h"

@implementation TFFallEmptyHeaderFooterCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setObject:(id<TFCollectionReusableViewItemProtocol>)object {
    [super setObject:object];
    if ([object isKindOfClass:TFFallEmptyHeaderFooterItem.class]) {
        TFFallEmptyHeaderFooterItem *item = (TFFallEmptyHeaderFooterItem *)object;
        if (item.backgroundColor) {
            self.contentView.backgroundColor = item.backgroundColor;
        }else{
            self.contentView.backgroundColor = [UIColor clearColor];
        }
    }
}

@end
