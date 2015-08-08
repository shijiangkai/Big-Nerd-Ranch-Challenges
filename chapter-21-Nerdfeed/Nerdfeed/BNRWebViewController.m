//
//  BNRWebViewController.m
//  Nerdfeed
//
//  Created by 史江凯 on 15/5/1.
//  Copyright (c) 2015年 Big Nerd Ranch. All rights reserved.
//

//#import "BNRWebViewController.h"
//
//@implementation BNRWebViewController
//- (void)loadView
//{
//    UIWebView *webView = [[UIWebView alloc] init];
//    webView.scalesPageToFit = YES;
//    
////    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:webView.frame];
////    toolbar.items = @[@"sjkdfj"];
////    [webView addSubview:toolbar];
//    
//    self.view = webView;
//}
//
//- (void)setURL:(NSURL *)URL
//{
//    _URL = URL;
//    if (_URL) {
//        NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
//        [(UIWebView *)self.view  loadRequest:req];
//    }
//}
//@end
//#import "BNRWebViewController.h"
//
//@interface BNRWebViewController () <UIWebViewDelegate>
//
//@property (nonatomic, strong) UIToolbar *toolbar;
//@property (nonatomic, strong) UIBarButtonItem *backButton;
//@property (nonatomic, strong) UIBarButtonItem *forwardButton;
//
//@end
//
//@implementation BNRWebViewController
//
//-(void)loadView
//{
//    UIWebView *webView = [[UIWebView alloc] init];
//    webView.scalesPageToFit = YES;
//    webView.delegate = self;
//    self.view = webView;
//}
//
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    CGRect rect = self.navigationController.navigationBar.frame;
//    rect.origin.y += rect.size.height;
//    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:rect];
//    
//    self.backButton =
//    [[UIBarButtonItem alloc] initWithTitle:@"Go Back"
//                                     style:UIBarButtonItemStylePlain
//                                    target:self.view
//                                    action:@selector(goBack)];
//    
//    self.forwardButton =
//    [[UIBarButtonItem alloc] initWithTitle:@"Go Forward"
//                                     style:UIBarButtonItemStylePlain
//                                    target:self.view
//                                    action:@selector(goForward)];
//    [self enableButtons];
//    toolbar.items = @[self.backButton, self.forwardButton];
//    self.toolbar = toolbar;
//    [self.view addSubview:toolbar];
//}
//
//-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//                                        duration:(NSTimeInterval)duration
//{
//    CGRect rect = self.navigationController.navigationBar.frame;
//    rect.origin.y += rect.size.height;
//    self.toolbar.frame = rect;
//}
//
//-(void)enableButtons
//{
//    UIWebView *webView = (UIWebView *)self.view;
//    self.backButton.enabled = webView.canGoBack;
//    self.forwardButton.enabled = webView.canGoForward;
//}
//
//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [self enableButtons];
//}
//
//-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    [self enableButtons];
//}
//
//-(void)setURL:(NSURL *)URL
//{
//    _URL = URL;
//    if (_URL) {
//        NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
//        [(UIWebView *)self.view loadRequest:req];
//    }
//}
//
//@end
#import "BNRWebViewController.h"

@interface BNRWebViewController() <UIWebViewDelegate>

@property (nonatomic, strong)UIToolbar *toolBar;
@property (nonatomic, strong)UIBarButtonItem *backButton;
@property (nonatomic, strong)UIBarButtonItem *forwardButton;

@end

@implementation BNRWebViewController

- (void)loadView
{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    self.view = webView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.backButton = [[UIBarButtonItem alloc]initWithTitle:@"goBack"
                                                      style:UIBarButtonItemStylePlain
                                                     target:self.view
                                                     action:@selector(goBack)];
    
    self.forwardButton = [[UIBarButtonItem alloc] initWithTitle:@"goForward"
                                                          style:UIBarButtonItemStylePlain
                                                         target:self.view
                                                         action:@selector(goForward)];
    
    self.navigationItem.rightBarButtonItems = @[self.forwardButton, self.backButton];
    
    [self updateWebViewButtons];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation) toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    CGRect rect = self.navigationController.navigationBar.frame;
    rect.origin.y += rect.size.height;
    self.toolBar.frame = rect;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self updateWebViewButtons];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self updateWebViewButtons];
}
- (void)updateWebViewButtons
{
    UIWebView *webView = (UIWebView *)self.view;
    self.backButton.enabled = webView.canGoBack;
    self.forwardButton.enabled = webView.canGoForward;
}

- (void)setURL:(NSURL *)URL
{
    _URL = URL;
    if (_URL){
        NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
        [(UIWebView*)self.view loadRequest:req];
    }
}

@end

