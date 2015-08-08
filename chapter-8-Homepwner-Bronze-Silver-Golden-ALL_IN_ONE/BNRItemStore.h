//
//  BNRItemStore.h
//  chapter-8-Homepwner
//
//  Created by 史江凯 on 15/4/21.
//  Copyright (c) 2015年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;
@interface BNRItemStore : NSObject
@property (nonatomic, readonly) NSArray *allItems;
+ (instancetype) sharedStore;
- (BNRItem *)createItem;
@end
