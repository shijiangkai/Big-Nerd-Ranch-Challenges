//
//  BNRHypnosisView.h
//  Hypnosister
//
//  Created by 史江凯 on 15/4/19.
//  Copyright (c) 2015年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRHypnosisView : UIView

@property (strong, nonatomic) UIColor *circleColor;


void CGContextSetShadow (
    CGContextRef context,
    CGSize offset,
    CGFloat blur);
@end
