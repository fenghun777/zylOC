//
//  ZyBaseCollectionViewCell.m
//  zylOC
//
//  Created by yy z on 2018/3/12.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyBaseCollectionViewCell.h"

@implementation ZyBaseCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    self.backgroundColor = [UIColor whiteColor];
    
}





@end
