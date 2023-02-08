//
//  TFCollectionViewCell.h
//
//  Created by ZhangJun on 2018/10/25.
//  Copyright © 2018 JingLing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFCollectionReusableViewItem.h"



@class TFCollectionViewCell;
@protocol TFCollectionViewCellDelegate <NSObject>

@optional
- (void)collectionViewCell:(TFCollectionViewCell *_Nullable)cell didTappedView:(UIView *_Nullable)view viewIdentifier:(NSString *_Nullable)identifier cellObject:(id<TFCollectionReusableViewItemProtocol>_Nonnull)object;

@end


@interface TFCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) id<TFCollectionReusableViewItemProtocol> _Nonnull object;

+ (CGSize)collectionView:(UICollectionView *_Nullable)collectionView sizeForItem:(id<TFCollectionReusableViewItemProtocol>_Nonnull)object;

@end


