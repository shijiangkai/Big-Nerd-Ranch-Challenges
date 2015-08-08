//
//  BNRPopoverBackgroundView.m
//  HomePwner
//
//  Created by 史江凯 on 15/4/28.
//  Copyright (c) 2015年 Big Nerd Ranch. All rights reserved.
//

//#import "BNRPopoverBackgroundView.h"
//
//@implementation BNRPopoverBackgroundView
//
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}
//
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//}
//*/
//
//@end

#import "BNRPopoverBackgroundView.h"

@implementation BNRPopoverBackgroundView

@synthesize arrowDirection  = _arrowDirection;
@synthesize arrowOffset     = _arrowOffset;

+ (CGFloat)arrowBase
{
    return 0;
}

+ (CGFloat)arrowHeight
{
    return 0;
}

+ (UIEdgeInsets)contentViewInsets
{
    return UIEdgeInsetsMake(3.0,3.0,3.0,3.0);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}
@end