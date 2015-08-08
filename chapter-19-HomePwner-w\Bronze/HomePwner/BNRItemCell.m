//
//  BNRItemCell.m
//  HomePwner
//
//  Created by 史江凯 on 15/4/29.
//  Copyright (c) 2015年 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemCell.h"

@implementation BNRItemCell

- (IBAction)showImage:(id)sender
{
    if (self.actionBlock) {
        self.actionBlock();
    }
}
@end
