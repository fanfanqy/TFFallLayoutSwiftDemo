//
//  TFFallLayoutSectionBaseItem.h
//  TFFallLayout
//
//  Created by 黄楠 on 2021/3/4.
//

#import <Foundation/Foundation.h>
#import "TFCollectionViewSectionItem.h"
#import "TFFallLayoutStick.h"
#import "TFFallLayoutZIndex.h"
#import "TFFallLayoutCompositor.h"



///不要直接使用这个类，请使用 `TFFallLayoutSectionItem` 或者 `TFFallLayoutFlowSectionItem`
@interface TFFallLayoutSectionBaseItem : TFCollectionViewSectionItem

@property (nonatomic, assign) CGFloat sectionHeaderDimension; //default 0
@property (nonatomic, assign) CGFloat sectionFooterDimension; //default 0
@property (nonatomic, assign) UIEdgeInsets sectionPadding; //default UIEdgeInsetsZero
@property (nonatomic, assign) UIEdgeInsets sectionMargin; //default UIEdgeInsetsZero
@property (nonatomic, strong) TFFallLayoutStick *stick;
@property (nonatomic, assign) TFFallLayoutZIndex headerZIndex;


- (id<TFFallLayoutCompositor>)compositor;
- (TFFallLayoutHeader *)header;
- (TFFallLayoutFooter *)footer;
- (TFFallLayoutBackground *)background;

@end


@interface TFFallLayoutSectionBaseItem (Deprecated)
@property (nonatomic, assign) CGFloat sectionHeaderHeight  __attribute__((deprecated("use sectionHeaderDimension instead."))); //default 0
@property (nonatomic, assign) CGFloat sectionFooterHeight  __attribute__((deprecated("use sectionFooterDimension instead."))); //default 0
@end


