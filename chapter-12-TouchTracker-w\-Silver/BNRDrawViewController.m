//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by 史江凯 on 15/4/24.
//  Copyright (c) 2015年 Big Nerd Ranch. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

- (void)loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}
@end
