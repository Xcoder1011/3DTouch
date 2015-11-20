//
//  FloatingViewController.m
//  Running
//
//  Created by shangkunwu on 15/11/2.
//  Copyright © 2015年 j1. All rights reserved.
//

#import "FloatingViewController.h"

@interface FloatingViewController () <UIPreviewActionItem,UIWebViewDelegate>

@property (nonatomic ,strong) UIWebView *webView;

@end

@implementation FloatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64)];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    
    [self isAvailable3DTouch];

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dissmissView:)];
    self.navigationItem.leftBarButtonItem = backItem;
    [self.view addSubview:self.webView];
   
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
        [self.view makeToastActivity];


}
- (void)webViewDidFinishLoad:(UIWebView *)webView{

    [self.view hideToastActivity];

}

-(void)isAvailable3DTouch
{
    //判断当前使用设备是否支持 3D touch
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.view];
        NSLog(@"3D Touch 开启!");
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmissView:)];
//        [self.view addGestureRecognizer:tap];
        
        
    }
    else
    {
        NSLog(@"3D Touch 没有开启!");
    }
    
}

-(NSArray <id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"持续用力按进入详情" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        [self showViewController:previewViewController sender:self];
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"健一网" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了健一网");
        [self showViewController:previewViewController sender:self];
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"去双十一会场" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        NSLog(@"点击了去双十一会场");
        [self showViewController:previewViewController sender:self];
    }];
    
   
    NSArray *actionArray  = @[action1,action2,action3];
    return actionArray;

}



-(void)dissmissView:(UITapGestureRecognizer *)tap
{
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
