//
//  TFFallLayoutLinkageObject.h
//  TFUIKit
//
//  Created by 黄楠 on 2020/5/7.
//

#import <Foundation/Foundation.h>



@interface TFFallLayoutLinkageObject : NSObject

///联动窗口视图的大小
@property (nonatomic, assign, readonly) CGSize linkageViewPortSize;

- (instancetype)initWithLinkageViewPortSize:(CGSize)linkageViewPortSize;

@end


