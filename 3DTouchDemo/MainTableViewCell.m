//
//  MainTableViewCell.m
//  Running
//
//  Created by shangkunwu on 15/11/3.
//  Copyright © 2015年 j1. All rights reserved.
//

#import "MainTableViewCell.h"

@implementation MainTableViewCell

-(void)configWith:(NSString *)title{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, DeviceWidth, 40)];
    [self.titleLabel setText:title];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self.contentView addSubview:self.titleLabel];
}

-(void)layoutIfNeeded{
    self.titleLabel.frame = CGRectMake(5, 5, DeviceWidth, 40);
}

-(void)layoutSubviews
{
    //self.titleLabel.frame = CGRectMake(5, 5, DeviceWidth, 40);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
