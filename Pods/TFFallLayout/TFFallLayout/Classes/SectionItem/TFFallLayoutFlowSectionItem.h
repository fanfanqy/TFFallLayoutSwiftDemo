//
//  TFFallLayoutFlowSectionItem.h
//  TFFallLayout
//
//  Created by 黄楠 on 2021/3/4.
//

#import "TFFallLayoutSectionBaseItem.h"



@interface TFFallLayoutFlowSectionItem : TFFallLayoutSectionBaseItem

///元素主轴方向上的尺寸，default 30
@property (nonatomic, assign) CGFloat itemDimension;
/// 列间距，default 15
@property (nonatomic, assign) CGFloat columnSpacing;
/// 元素间距，水平轴为水平间距，垂直轴为垂直间距，default 15
@property (nonatomic, assign) CGFloat itemSpacing;

@end


