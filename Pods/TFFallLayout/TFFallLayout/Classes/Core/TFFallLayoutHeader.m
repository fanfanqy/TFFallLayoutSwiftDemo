//
//  TFFallLayoutHeader.m
//  TFUIKit
//
//  Created by 黄楠 on 2019/12/23.
//

#import "TFFallLayoutHeader.h"

@implementation TFFallLayoutHeader {
    CGFloat _dimension;
    TFFallLayoutStick *_stick;
    TFFallLayoutZIndex _zIndex;
}

- (instancetype)initWithDimension:(CGFloat)dimension stick:(TFFallLayoutStick *)stick zIndex:(TFFallLayoutZIndex)zIndex {
    self = [super init];
    if (self) {
        _dimension = dimension;
        _stick = stick;
        _zIndex = zIndex;
    }
    return self;
}

- (instancetype)initWithDimension:(CGFloat)dimension {
    return [self initWithDimension:dimension stick:nil zIndex:TFFallLayoutZIndexTopOfItem];
}

+ (instancetype)headerWithDimension:(CGFloat)dimension {
    return [[self alloc] initWithDimension:dimension];
}

@end
