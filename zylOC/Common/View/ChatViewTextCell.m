//
//  ChatViewTextCell.m
//  zylOC
//
//  Created by 张钰营 on 2018/7/20.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ChatViewTextCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ChatViewTextCell ()
@property (nonatomic, strong) UIImageView *ivHead;
@property (nonatomic, strong) UILabel *lblDetail;
@end

@implementation ChatViewTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (UIImageView *)ivHead {
    if (!_ivHead) {
        _ivHead = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    }
    return _ivHead;
}

- (UILabel *)lblDetail {
    if (!_lblDetail) {
        _lblDetail = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, WIDTH - 40, 20)];
        _lblDetail.numberOfLines = 0;
    }
    return _lblDetail;
}

- (void)initView {
    self.backgroundColor = [UIColor yellowColor];
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.bounds.size.width - 10, self.bounds.size.height - 10)];
    [self addSubview:centerView];
    centerView.backgroundColor = [UIColor whiteColor];
    
    [centerView addSubview:self.ivHead];
    [centerView addSubview:self.lblDetail];
}

- (void)setImageStr:(NSString *)imageStr {
    [_ivHead setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"zy_girl"]];
}

- (void)setDetailStr:(NSString *)detailStr {
    _lblDetail.text = detailStr;
    CGSize labelsize = [ZyUtils zy_GetContentSize:detailStr font:17 size:CGSizeMake(WIDTH - 50, 17)];
    [_lblDetail setFrame:CGRectMake(30, 0, labelsize.width, labelsize.height)];
}

@end
