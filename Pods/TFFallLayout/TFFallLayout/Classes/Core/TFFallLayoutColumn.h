//
//  TFFallLayoutColumn.h
//  TFUIKit
//
//  Created by 黄楠 on 2019/12/23.
//

#import <UIKit/UIKit.h>



@interface TFFallLayoutColumn : NSObject

@property (nonatomic, strong, readonly) NSArray<UICollectionViewLayoutAttributes *> *items;

- (CGFloat)width;
- (CGFloat)height;

- (void)push:(UICollectionViewLayoutAttributes *)item;

@end


