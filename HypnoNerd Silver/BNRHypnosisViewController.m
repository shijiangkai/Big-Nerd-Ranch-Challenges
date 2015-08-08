//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by 史江凯 on 15/4/19.
//  Copyright (c) 2015年 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@implementation BNRHypnosisViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"BNRHypnosisViewController loaded its view.");
}
- (void) loadView
{
//  CGRect frame = [UIScreen mainScreen].bounds;
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] init];
    self.view = backgroundView;
}

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if ( self ) {
        self.tabBarItem.title = @"Hypnotize";
        UIImage *image = [UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image =image;
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:(NSArray *)@[@"Red",@"Green", @"Blue"]];
        segmentedControl.frame = CGRectMake(35, 215, 250, 50);
        segmentedControl.selectedSegmentIndex = 0;
        [segmentedControl addTarget:self
                             action:@selector(changeColor:)
                   forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:segmentedControl];
        }
    return self;
}
- (void)changeColor:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    if(segmentedControl.selectedSegmentIndex == 0){
        ((BNRHypnosisView *)self.view).circleColor = [UIColor redColor];
    }
    if(segmentedControl.selectedSegmentIndex == 1){
        ((BNRHypnosisView *)self.view).circleColor = [UIColor greenColor];
    }
    if(segmentedControl.selectedSegmentIndex == 2){
        ((BNRHypnosisView *)self.view).circleColor = [UIColor blueColor];
    }
}
@end
