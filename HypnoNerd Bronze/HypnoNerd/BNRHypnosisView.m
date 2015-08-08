//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by 史江凯 on 15/4/19.
//  Copyright (c) 2015年 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisView.h"
@interface  BNRHypnosisView()
@property (strong, nonatomic) UIColor *circleColor;
@end
@implementation BNRHypnosisView
-(void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    UIBezierPath *path =[[UIBezierPath alloc] init];
    for (float currentRadius = maxRadius; currentRadius >0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0 endAngle:M_PI * 2.0 clockwise:YES];
    }
    path.lineWidth = 10;
    [self.circleColor setStroke];
    [path stroke];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched",self);
    float red = (arc4random() % 100) /100.0;
    float green = arc4random() % 100 /100.0;
    float blue = arc4random() % 100 /100.0;
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    self.circleColor = randomColor;
}

@end
