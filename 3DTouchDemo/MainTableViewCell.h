//
//  MainTableViewCell.h
//  Running
//
//  Created by shangkunwu on 15/11/3.
//  Copyright © 2015年 j1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableViewCell : UITableViewCell
@property (nonatomic , strong) UILabel * titleLabel;

-(void)configWith:(NSString *)title;

@end
