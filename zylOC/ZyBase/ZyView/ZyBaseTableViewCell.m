//
//  ZyBaseTableViewCell.m
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyBaseTableViewCell.h"

@implementation ZyBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.ivHead];
        [self addSubview:self.lblTitle];
        [self addSubview:self.lblDetail];
    }
    return self;
}

- (UIImageView *)ivHead{
    if (_ivHead == nil) {
        _ivHead = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    }
    return _ivHead;
}

- (UILabel *)lblTitle{
    if (_lblTitle == nil) {
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 80, 12)];
    }
    return _lblTitle;
}

- (UILabel *)lblDetail{
    if (_lblDetail == nil) {
        _lblDetail = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 80, 12)];
    }
    return _lblDetail;
}
















@end
