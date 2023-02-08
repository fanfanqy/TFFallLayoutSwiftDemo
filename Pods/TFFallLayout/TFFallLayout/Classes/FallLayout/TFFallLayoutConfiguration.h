//
//  TFFallLayoutConfiguration.h
//  TFUIKit
//
//  Created by 黄楠 on 2019/12/25.
//

#import <Foundation/Foundation.h>
#import "TFFallLayoutRender.h"
#import "TFFallLayoutHeader.h"
#import "TFFallLayoutFooter.h"
#import "TFFallLayoutBackground.h"
#import "TFFallLayoutLinkageObject.h"



@interface TFFallLayoutConfiguration : NSObject <NSCopying>

///是否需要保留联动视图
@property (nonatomic, strong, nullable) TFFallLayoutLinkageObject *linkage;

///collectionView滚动方向
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

@end


