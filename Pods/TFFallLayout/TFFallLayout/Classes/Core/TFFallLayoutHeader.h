//
//  TFFallLayoutHeader.h
//  TFUIKit
//
//  Created by 黄楠 on 2019/12/23.
//

#import <Foundation/Foundation.h>
#import "TFFallLayoutZIndex.h"
#import "TFFallLayoutStick.h"



@interface TFFallLayoutHeader : NSObject

@property (nonatomic, assign, readonly) CGFloat dimension;
@property (nonatomic, strong, readonly, nullable) TFFallLayoutStick *stick;
@property (nonatomic, assign, readonly) TFFallLayoutZIndex zIndex;

- (instancetype)initWithDimension:(CGFloat)dimension stick:(nullable TFFallLayoutStick *)stick zIndex:(TFFallLayoutZIndex)zIndex;

- (instancetype)initWithDimension:(CGFloat)dimension;

+ (instancetype)headerWithDimension:(CGFloat)dimension;

@end


