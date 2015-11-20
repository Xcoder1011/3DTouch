//
//  MainViewController.m
//  Running
//
//  Created by shangkunwu on 15/11/2.
//  Copyright © 2015年 j1. All rights reserved.
//

#import "MainViewController.h"
#import "FloatingViewController.h"
#import "MainTableViewCell.h"
#import "DrawViewController.h"


//注册预览功能的代理对象和源视图
//代理对象需要接受UIViewControllerPreviewingDelegate协议
@interface MainViewController () <UIViewControllerPreviewingDelegate>
{
    UILongPressGestureRecognizer *_longPress;
    CGFloat   _lastContentOffsetY;
}
@property (nonatomic ,strong) NSMutableArray *dataArray;

@property (nonatomic ,strong) UIView *headerView;

@end

@implementation MainViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"3D Touch test";
    
    self.tableView.estimatedRowHeight = 50;
        
    [self isAvailable3DTouch];
    
    [self createDatas];
    

}


-(void)isAvailable3DTouch
{
    //判断当前使用设备是否支持 3D touch
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) { //可以支持压力感应 :UIForceTouchCapabilityAvailable
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.view];
        NSLog(@"3D Touch 支持!");
        _longPress.enabled = YES;
    }
    else  //不能确定是否支持压力感应:UIForceTouchCapabilityUnknown
        //不能支持压力感应 : UIForceTouchCapabilityUnavailable
    {
        NSLog(@"3D Touch 不支持!");
        _longPress.enabled = NO;
    }

}

-(void)createDatas{
    
    self.dataArray = [NSMutableArray array];
    
    for (int i = 1; i < 30; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"轻按预览内容详情%d",i]];
    }
    [self.dataArray insertObject:[NSString stringWithFormat:@"点击进入3D Touch画板功能"] atIndex:3];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIViewControllerPreviewingDelegate || 3D Touch Delegate

/**
 *  轻按进入浮动页面
 */
- (nullable UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    if (indexPath) {
        
        NSString *url = @"http://wap.j1.com";
        FloatingViewController *floatCtrl = [[FloatingViewController alloc]init];
        floatCtrl.urlStr = url;
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        //预览窗口只截取详情视频 FloatingViewController 的部分frame
        floatCtrl.preferredContentSize = CGSizeMake(0.0, DeviceHeight/2);
        //除了这个单元格，需要模糊其它位置
        //CGRect sourceRect = CGRectMake(10, point.y - 10, self.view.frame.size.width - 20,20)
        [previewingContext setSourceRect:cell.frame];
        
        return floatCtrl;
    }
    
    return [UIViewController new];
    
}

/**
 重按进入文章详情页
 
 */
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self showViewController:viewControllerToCommit sender:self];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
     [cell.textLabel setText:(NSString *)self.dataArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        DrawViewController * ctrl = [[DrawViewController alloc]init];
        [self.navigationController pushViewController:ctrl animated:YES];
        return;
    }
    FloatingViewController *ctrl = [[FloatingViewController alloc]init];
    ctrl.urlStr = @"http://wap.j1.com";
    ctrl.title = @"健一商城";
    [self.navigationController pushViewController:ctrl animated:YES];

}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
