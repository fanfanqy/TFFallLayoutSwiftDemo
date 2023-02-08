//
//  TFFallLayoutLinkageObject.m
//  TFUIKit
//
//  Created by 黄楠 on 2020/5/7.
//

#import "TFFallLayoutLinkageObject.h"

@implementation TFFallLayoutLinkageObject

- (instancetype)initWithLinkageViewPortSize:(CGSize)linkageViewPortSize {
    self = [super init];
    if (self) {
        _linkageViewPortSize = linkageViewPortSize;
    }
    return self;
}

@end
