//
//  TFFallLayoutRender.m
//  TFUIKit
//
//  Created by 黄楠 on 2019/12/23.
//

#import "TFFallLayoutRender.h"

@implementation TFFallLayoutRender {
    TFFallLayoutRenderAxis _axis;
    TFFallLayoutRenderDirection _direction;
}

- (instancetype)initWithAxis:(TFFallLayoutRenderAxis)axis direction:(TFFallLayoutRenderDirection)direction {
    self = [super init];
    if (self) {
        _axis = axis;
        _direction = direction;
    }
    return self;
}

@end
