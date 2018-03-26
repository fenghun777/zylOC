
//
//  HomePageHeaderView.m
//  zylOC
//
//  Created by yy z on 2018/3/23.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "HomePageHeaderView.h"
#import "ZyScrollView.h"

@implementation HomePageHeaderView



- (void)initView{
    ZyScrollView *sv = [[ZyScrollView alloc] initWithFrame:CGRectMake(10, 10, WIDTH - 20, WIDTH - 40)];
    [self addSubview:sv];
}

@end
