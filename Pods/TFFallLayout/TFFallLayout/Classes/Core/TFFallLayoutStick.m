//
//  TFFallLayoutStick.m
//  TFUIKit
//
//  Created by 黄楠 on 2019/12/23.
//

#import "TFFallLayoutStick.h"

@implementation TFFallLayoutStick {
    CGFloat _offset;
}

- (instancetype)initWithOffset:(CGFloat)offset {
    self = [super init];
    if (self) {
        _offset = offset;
    }
    return self;
}

@end
