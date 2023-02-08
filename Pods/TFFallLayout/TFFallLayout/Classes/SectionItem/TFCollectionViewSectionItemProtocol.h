//
//  TFCollectionViewSectionItemProtocol.h
//
//  Created by ZhangJun on 2018/10/25.
//  Copyright © 2018 JingLing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFCollectionReusableViewItemProtocol.h"



@protocol TFCollectionViewSectionItemProtocol <NSObject>

@property (nonatomic, strong) NSMutableArray<id<TFCollectionReusableViewItemProtocol>> *sectionItems;
@property (nonatomic, strong) id<TFCollectionReusableViewItemProtocol> headerItem;
@property (nonatomic, strong) id<TFCollectionReusableViewItemProtocol> footerItem;
@property (nonatomic, strong) id<TFCollectionReusableViewItemProtocol> backgroundItem;
@property (nonatomic, copy) NSString *sectionIdentifier;
@property (nonatomic, copy) NSNumber *minimumLineSpacing;
@property (nonatomic, copy) NSNumber *minimumInteritemSpacing;
@property (nonatomic, copy) NSValue *insetForSection;

@end


