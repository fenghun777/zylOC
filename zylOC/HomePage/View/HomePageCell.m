//
//  HomePageCell.m
//  zylOC
//
//  Created by 张钰营 on 2018/4/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "HomePageCell.h"

@implementation HomePageCell

- (void)initView{
    [super initView];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Connor"]];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
