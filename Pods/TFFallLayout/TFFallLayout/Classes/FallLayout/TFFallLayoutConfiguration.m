//
//  TFFallLayoutConfiguration.m
//  TFUIKit
//
//  Created by 黄楠 on 2019/12/25.
//

#import "TFFallLayoutConfiguration.h"

@implementation TFFallLayoutConfiguration

- (instancetype)init {
    self = [super init];
    if (self) {
        _linkage = nil;
        _scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    TFFallLayoutConfiguration *con = [[[self class] allocWithZone:zone] init];
    con.linkage = self.linkage;
    con.scrollDirection = self.scrollDirection;
    return con;
}

@end
