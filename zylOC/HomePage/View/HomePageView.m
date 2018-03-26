//
//  HomePageView.m
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "HomePageView.h"
#import "HomePageHeaderView.h"

@implementation HomePageView

- (void)initView{
    [super initView];
    [self initData];
}

- (void)initData{
    [self registerClass:[HomePageHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headViewId"];
    [self registerClass:[ZyBaseCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footViewId"];
    
    [self.mainData addObjectsFromArray:@[@1, @1, @1, @1, @1, @1]];
    [self reloadData];
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
//MARK:    设置header和footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HomePageHeaderView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headViewId" forIndexPath:indexPath];
        headView.backgroundColor = [UIColor redColor];
        return headView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        ZyBaseCollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footViewId" forIndexPath:indexPath];
        footView.backgroundColor = [UIColor yellowColor];
        return footView;
    }else{
        echo(@"headView,footView==未知错误！");
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(WIDTH - 20, WIDTH - 20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(WIDTH - 40, WIDTH - 100);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    Zy_AllFunction
//    Zy_Default
    [ZyRouter route_pushController:@"Zy_Default"];
}









@end
