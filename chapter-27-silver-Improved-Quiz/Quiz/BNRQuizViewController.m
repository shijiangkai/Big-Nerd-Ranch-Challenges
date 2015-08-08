//
//  BNRQuizViewController.m
//  Quiz
//
//  Created by John Gallagher on 1/6/14.
//  Copyright (c) 2014 John Gallagher. All rights reserved.
//

#import "BNRQuizViewController.h"

@interface BNRQuizViewController ()

@property (nonatomic, assign) int currentQuestionIndex;
@property (nonatomic, copy) NSArray *answers;
@property (nonatomic, copy) NSArray *questions;

@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;

@end

@implementation BNRQuizViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    // Call the init method implemented by the superclass
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Create two arrays filled with questions and answers
        // and make the pointers point to them

        self.questions = @[@"From what is cognac made?",
                           @"What is 7+7?",
                           @"What is the capital of Vermont?"];

        self.answers = @[@"Grapes",
                         @"14",
                         @"Montpelier"];
    }

    // Return the address of the new object
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)showQuestionButtonPressed:(UIButton *)sender
{
    // Step to the next question
    self.currentQuestionIndex++;

    // Am I pas the last question?
    if (self.currentQuestionIndex == [self.questions count]) {

        // Go back to the first question
        self.currentQuestionIndex = 0;
    }

    // Get the string at the index in the questions array
    NSString *question = self.questions[self.currentQuestionIndex];
    [self animateLabel:self.questionLabel withNewText:question];
    [self animateLabel:self.answerLabel withNewText:@"???"];
}

- (IBAction)showAnswerButtonPressed:(id)sender
{
    NSString *answer = self.answers[self.currentQuestionIndex];
    [self animateLabel:self.answerLabel withNewText:answer];
}

-(void)animateLabel:(UILabel *)label
        withNewText:(NSString *)text
{
    CGFloat windowWidth = [[UIScreen mainScreen] bounds].size.width;
    CGRect origFrame = label.frame;
    
    [UIView animateWithDuration:0.5 delay:0.0 options:0 animations:^{
        label.alpha = 0;
        CGRect newFrame = origFrame;
        newFrame.origin.x = windowWidth;
        label.frame = newFrame;
    } completion:^(BOOL finished) {
        label.text = text;
        CGRect newFrame = origFrame;
        newFrame.origin.x = -windowWidth;
        label.frame = newFrame;
        [UIView animateWithDuration:0.5 delay:0.0 options:0 animations:^{
            label.alpha = 1;
            label.frame = origFrame;
        } completion:NULL];
    }];
}

@end
