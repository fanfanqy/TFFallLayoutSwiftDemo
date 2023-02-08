//
//  TFFallLayoutColumn.m
//  TFUIKit
//
//  Created by 黄楠 on 2019/12/23.
//

#import "TFFallLayoutColumn.h"

@implementation TFFallLayoutColumn {
    NSMutableArray<UICollectionViewLayoutAttributes *> *_items;
    CGRect _unionRect;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _items = [NSMutableArray array];
        _unionRect = CGRectZero;
    }
    return self;
}

- (CGFloat)width {
    return _unionRect.size.width;
}

- (CGFloat)height {
    return _unionRect.size.height;
}

- (void)push:(UICollectionViewLayoutAttributes *)item {
    if (item == nil) return;
    [_items addObject:item];
    if (_items.count == 1) {
        _unionRect = item.frame;
    }else{
        _unionRect = CGRectUnion(_unionRect, item.frame);
    }
}

@end
