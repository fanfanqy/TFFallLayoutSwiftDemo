//
//  TFFallLayoutFooter.m
//  TFUIKit
//
//  Created by 黄楠 on 2019/12/23.
//

#import "TFFallLayoutFooter.h"

@implementation TFFallLayoutFooter {
    CGFloat _dimension;
}

- (instancetype)initWithDimension:(CGFloat)dimension {
    self = [super init];
    if (self) {
        _dimension = dimension;
    }
    return self;
}

+ (instancetype)footerWithDimension:(CGFloat)dimension {
    return [[self alloc] initWithDimension:dimension];
}

@end
