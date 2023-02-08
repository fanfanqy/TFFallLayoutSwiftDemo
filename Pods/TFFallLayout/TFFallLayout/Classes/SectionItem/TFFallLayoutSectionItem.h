//
//  TFFallLayoutSectionItem.h
//
//  Created by zerozheng on 2018/11/28.
//  Copyright © 2018 JingLing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFFallLayoutSectionBaseItem.h"

@interface TFFallLayoutSectionItem : TFFallLayoutSectionBaseItem

@property (nonatomic, strong) TFFallLayoutRender *render;
@property (nonatomic, assign) NSInteger columnCount; //default 1
@property (nonatomic, assign) CGFloat columnSpacing; //default 0
@property (nonatomic, assign) CGFloat itemSpacing; //default 0

@end
