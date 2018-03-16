//
//  HomePageView.m
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "HomePageView.h"

@implementation HomePageView

- (void)initView{
    [super initView];
    [self initData];
}

- (void)initData{
    [self.mainData addObjectsFromArray:@[@1, @1, @1, @1, @1, @1]];
    [self reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    Zy_AllFunction
//    Zy_Default
    [ZyRouter route_pushController:@"Zy_Default"];
}









@end
