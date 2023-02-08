//
//  TFFallLayoutRender.h
//  TFUIKit
//
//  Created by 黄楠 on 2019/12/23.
//

#import <Foundation/Foundation.h>



/**
 1. 垂直滚动的collectionview, TFFallLayoutRenderAxis布局如下
 |----------------- |
 | ----   ----   ----   ----
 || 1  | | 2  | | 3 || | 4  | TFFallLayoutRenderAxisHorizontal
 | ----   ----   ----   ----
 |                  |
 |==================|
 |                  |
 |  ---  ---   ---  |
 | | 1 || 2 | | 3 | |
 |  ---  ---   ---  | TFFallLayoutRenderAxisVertical
 |  ---  ---   ---  |
 | | 4 || 5 | | 6 | |
 |  ---  ---   ---  |
 |                  |
 |        |         |
 |        |         |
 | scroll direction |
 |        |         |
 |        |         |
 |        v         |

 
 
 2. 水平滚动的collectionview, TFFallLayoutRenderAxis布局如下
 |--------------------------------------------------------
 | ----        ----   ----   ----
 || 1  |      | 1  | | 3  | | 5  | TFFallLayoutRenderAxisHorizontal
 | ----        ----   ----   ----
 | ----                               ------------>scroll direction
 || 2  |       ----   ----
 | ----       | 2  | | 4  |
 | ----        ----   ----
 || 3  |--------------------------------------------------
   ----
   ----
  | 4  |
   ----
 TFFallLayoutRenderAxisVertical
 
 */


typedef NS_ENUM(NSUInteger, TFFallLayoutRenderDirection) {
    TFFallLayoutRenderDirectionShortest = 0,
    TFFallLayoutRenderDirectionLeftToRight = 1,
    TFFallLayoutRenderDirectionRightToLeft = 2,
    TFFallLayoutRenderDirectionTopToBottom = TFFallLayoutRenderDirectionLeftToRight,
    TFFallLayoutRenderDirectionBottomToTop = TFFallLayoutRenderDirectionRightToLeft,
};

typedef NS_ENUM(NSUInteger, TFFallLayoutRenderAxis) {
    TFFallLayoutRenderAxisHorizontal,
    TFFallLayoutRenderAxisVertical,
};

@interface TFFallLayoutRender : NSObject

@property (nonatomic, assign, readonly) TFFallLayoutRenderAxis axis;
@property (nonatomic, assign, readonly) TFFallLayoutRenderDirection direction;

- (instancetype)initWithAxis:(TFFallLayoutRenderAxis)axis direction:(TFFallLayoutRenderDirection)direction;

@end


