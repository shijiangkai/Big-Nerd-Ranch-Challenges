//
//  BNRCoursesCell.h
//  Nerdfeed
//
//  Created by 史江凯 on 15/5/1.
//  Copyright (c) 2015年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRCoursesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *instructorLabel;

@end
