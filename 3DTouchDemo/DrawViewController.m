//
//  DrawViewController.m
//  Running
//
//  Created by shangkunwu on 15/11/3.
//  Copyright © 2015年 j1. All rights reserved.
//

#import "DrawViewController.h"

@interface DrawViewController ()
{
    CGPoint _touchPoint;
}
@property (nonatomic , strong) UIImageView *backView;

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Touch画板";
    self.backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight - 64)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backView];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dissmissView:)];
    self.navigationItem.leftBarButtonItem = backItem;

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _touchPoint = [touch locationInView:self.backView];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.backView];
    
    UIGraphicsBeginImageContext(self.backView.frame.size);
    [self.backView.image drawInRect:CGRectMake(0.0, 0.0, self.backView.frame.size.width, self.backView.frame.size.height)];
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    float lineWidthc = 10.0;
    if ([touch respondsToSelector:@selector(force)]) {
        NSLog(@"force:%f", touch.force);
        lineWidthc = lineWidthc * touch.force;
    }
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), lineWidthc);
    
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 1.0, 0.0, 1.0);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _touchPoint.x, _touchPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.backView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _touchPoint = currentPoint;
   
}

-(void)dissmissView:(UITapGestureRecognizer *)tap
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
