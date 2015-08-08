//
//  BNRAssetTypeViewController.h
//  HomePwner
//
//  Created by 史江凯 on 15/5/3.
//  Copyright (c) 2015年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRAssetTypeViewController : UITableViewController

@property (nonatomic, strong) BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

@end
