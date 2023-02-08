//
//  TFFallLayoutAdaptor.h
//
//  Created by zerozheng on 2018/11/27.
//  Copyright © 2018 JingLing. All rights reserved.
//

#import "TFCollectionViewBaseAdaptor.h"
#import "TFFallLayout.h"
@class TFFallLayoutSectionBaseItem;

@interface TFFallLayoutAdaptor : TFCollectionViewBaseAdaptor <TFFallLayoutDelegate>
@property (nonatomic, strong) NSArray<TFFallLayoutSectionBaseItem<TFCollectionViewSectionItemProtocol> *> *items;
@end
