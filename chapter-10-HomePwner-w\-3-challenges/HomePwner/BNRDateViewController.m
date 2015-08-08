//
//  BNRDateViewController.m
//  HomePwner
//
//  Created by 史江凯 on 15/4/23.
//  Copyright (c) 2015年 Big Nerd Ranch. All rights reserved.
//

#import "BNRDateViewController.h"
#import "BNRItem.h"
@interface BNRDateViewController ()
@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;
@end

@implementation BNRDateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Select Date";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.datePicker.date =  self.item.dateCreated;
}

- (void) viewWillDisappear:(BOOL)animated
{
    //set the date of the item to the data of the datepicker
    _item.dateCreated = _datePicker.date;
}




@end
