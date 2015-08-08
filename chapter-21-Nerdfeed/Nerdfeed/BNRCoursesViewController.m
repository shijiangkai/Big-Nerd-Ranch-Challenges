//
//  BNRCoursesViewController.m
//  Nerdfeed
//
//  Created by 史江凯 on 15/5/1.
//  Copyright (c) 2015年 Big Nerd Ranch. All rights reserved.
//

#import "BNRCoursesViewController.h"
#import "BNRWebViewController.h"
#import "BNRCoursesCell.h"

@interface BNRCoursesViewController () <NSURLSessionDataDelegate>
@property (nonatomic) NSURLSession *session;
@property (nonatomic, copy) NSArray *courses;
@end

@implementation BNRCoursesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Load the nib file
    UINib *nib=[UINib nibWithNibName:@"BNRCoursesCell" bundle:nil];
    
    //Register nib
    [self.tableView registerNib:nib forCellReuseIdentifier:@"BNRCoursesCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courses.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BNRCoursesCell *cell=[tableView dequeueReusableCellWithIdentifier:@"BNRCoursesCell" forIndexPath:indexPath];
    
    NSDictionary *course=self.courses[indexPath.row];
    NSDictionary *details=[course[@"upcoming"] objectAtIndex:0];
    
    cell.titleLabel.text=course[@"title"];
    if (details) {
        cell.dateLabel.text= details[@"start_date"];
        cell.instructorLabel.text=details[@"instructors"];
    }else{
        cell.dateLabel.text= @"TBA";
        cell.instructorLabel.text=@"TBA";
    }
    return cell;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self= [super initWithStyle:style];
    if (self) {
        self.navigationController.title = @"BNR Courses";
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//        _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        [self fetchFeed];
    }
    return self;
}
- (void)fetchFeed
{
//    NSString *requestString = @"http://bookapi.bignerdranch.com/courses.json";
    NSString *requestString = @"https://bookapi.bignerdranch.com/private/courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req
                                      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                          NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                          self.courses = jsonObject[@"courses"];
                                          NSLog(@"%@", self.courses);
                                          
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [self.tableView reloadData];
                                          });
                                          
                                      }];
    [dataTask resume];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *course = self.courses[indexPath.row];
    NSURL *URL = [NSURL URLWithString:course[@"url"]];
    
    self.webViewController.title = course[@"title"];
    self.webViewController.URL = URL;
    [self.navigationController pushViewController:self.webViewController animated:YES];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSURLCredential *cred = [NSURLCredential credentialWithUser:@"BigNerdRanch"
                                                       password:@"AchieveNerdvana"
                                                    persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential,cred);
}


@end
