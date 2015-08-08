//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by John Gallagher on 1/9/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"

@interface BNRDrawView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *moveRecognizer;

@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;
@property (nonatomic, weak) BNRLine *selectedLine;

@property (strong, nonatomic) IBOutlet UIView *colorView;
@property (strong,nonatomic) UIColor *selectedColor;
@end

@implementation BNRDrawView

- (instancetype)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];

    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        doubleTapRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTapRecognizer];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tapRecognizer.delaysTouchesBegan = YES;
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapRecognizer];
        
        UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];
        
        self.moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO;
        [self addGestureRecognizer:self.moveRecognizer];
        
        UISwipeGestureRecognizer *threeFingerSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(displayPanel:)];
        [threeFingerSwipe setDirection:UISwipeGestureRecognizerDirectionUp];
        [threeFingerSwipe setNumberOfTouchesRequired:3];
        [threeFingerSwipe setDelaysTouchesBegan:YES];
        [self addGestureRecognizer:threeFingerSwipe];
    }
    
    self.selectedColor = [UIColor blackColor];
    
    
    return self;
}

- (void)strokeLine:(BNRLine *)line withWidth:(float)width
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = width; // <------------ which will be passed in here.
//    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

- (void)drawRect:(CGRect)rect
{
    // Draw finished lines in black
    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines) {
        [line.color set];
        [self strokeLine:line withWidth:line.width ];
    }

    [[UIColor redColor] set];
    for (NSValue *key in self.linesInProgress) {
        BNRLine *line = self.linesInProgress[key];
        [self strokeLine:line withWidth:line.width];
    }
    if (self.selectedLine) {
        [[UIColor greenColor] set];
        [self strokeLine:self.selectedLine withWidth:self.selectedLine.width];
    }
}

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];

        BNRLine *line = [[BNRLine alloc] init];
        line.begin = location;
        line.end = location;

        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
        [self.colorView removeFromSuperview];
    }
    

    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));

    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        
        CGPoint velocity = [self.moveRecognizer velocityInView:self]; //<---------------- grab the velocity
        line.width = (abs(velocity.x) + abs(velocity.y)) / 25.0;        //<------------------ and assign a width
        NSLog(@"%f",line.width);
        line.end = [t locationInView:self];
    }

    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    for(UITouch *t in touches){
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];
        line.color = self.selectedColor;
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
        
       
    }
    
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches
               withEvent:(UIEvent *)event
{
    // Let's put in a log statement to see the order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));

    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:key];
    }

    [self setNeedsDisplay];
}
- (void) doubleTap:(UITapGestureRecognizer *)gr
{
    NSLog(@"Recognized Double Tap");
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];

    [self setNeedsDisplay];
}
- (void)tap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized tap");
    CGPoint point = [gr locationInView:self];
    self.selectedLine = [self lineAtPoint:point];
    
    if (self.selectedLine){
        [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
        
    } else {
         [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }

    [self setNeedsDisplay];
}
- (BNRLine *)lineAtPoint:(CGPoint)p
{
    for (BNRLine *l in self.finishedLines){
        CGPoint start = l.begin;
        CGPoint end = l.end;
        for (float t= 0.0; t<=1.0; t+=0.05) {
            float x = start.x + t * (end.x - start.x );
            float y = start.y + t * (end.y - start.y);
            if (hypot(x - p.x , y - p.y ) < 20.0) {
                return l;
            }
        }
    }
    return nil;
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (void) deleteLine:(id)sender
{
    [self.finishedLines removeObject:self.selectedLine];
    [self setNeedsDisplay];
}
- (void) longPress:(UIGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [gr locationInView:self];
        self.selectedLine  = [self lineAtPoint:point];
        if (self.selectedLine) {
            [self.linesInProgress removeAllObjects];
        }
    } else if (gr.state == UIGestureRecognizerStateEnded) {
        self.selectedLine = nil;
    }
    [self setNeedsDisplay];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == self.moveRecognizer) {
        return YES;
    }
    return NO;
}
- (void) moveLine:(UIPanGestureRecognizer *)gr
{
    if (!self.selectedLine) {
        return;
    }
        if (gr.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gr translationInView:self];
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
        self.selectedLine.begin = begin;
        self.selectedLine.end = end;
        [self setNeedsDisplay];
        [gr setTranslation:CGPointZero inView:self];
    }
//第二种解决Silver Challenge的方法，在moveLine里判断，如果移动这个动作状态判定为开始，selectedLine改为动作所在位置，Menu改为不可见
    if ([gr state] == UIGestureRecognizerStateBegan) {
        self.selectedLine = [self lineAtPoint:[gr locationInView:self]];
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
}

//解决Silver Challenge，如果Menu可见，就把他设成不可见，把选中的线设nil
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    if ([[UIMenuController sharedMenuController] isMenuVisible])
//    {
//        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
//        self.selectedLine = nil;
//    }
//    
//    return YES;
//}
-(void)displayPanel:(UIGestureRecognizer *)gr
{
    NSLog(@"swiped up");
    CGRect frame = CGRectMake(0, self.window.frame.size.height-550, self.window.frame.size.width, 50);
    NSLog(@"%@",NSStringFromCGRect(frame));
    [[NSBundle mainBundle] loadNibNamed:@"ColorSelectView" owner:self options:nil];
    UIView *colorSelect = self.colorView;
    self.colorView.frame = frame;
    self.colorView.backgroundColor = [UIColor grayColor];
    [self.window addSubview:colorSelect];
    [self.window setNeedsDisplay];
}
- (IBAction)colorSelected:(UIButton *)sender {
    self.selectedColor = sender.backgroundColor;
    [self.colorView removeFromSuperview];
    
}
@end
