//
//  ZyBaseCollectionView.m
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyBaseCollectionView.h"

#define CELLID @"cellId"
#define HEADVIEWID @"headViewId"
#define FOOTVIEWID @"footViewId"

@implementation ZyBaseCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self initView];
    }
    return self;
}

- (NSMutableArray *)mainData{
    if (_mainData == nil) {
        _mainData = [[NSMutableArray alloc] init];
    }
    return _mainData;
}

- (void)initView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionViewLayout = flowLayout;
    
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = [UIColor darkGrayColor];

    [self registerClass:[ZyBaseCollectionViewCell class] forCellWithReuseIdentifier:CELLID];
    [self registerClass:[ZyBaseCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADVIEWID];
    [self registerClass:[ZyBaseCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOTVIEWID];
    
}

// MARK:    UICollectionViewDelegate的代理方法
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    echo(@"管理cell的高亮:shouldHighlightItemAtIndexPath");
    return true;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    echo(@"管理cell的高亮:didHighlightItemAtIndexPath");
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    echo(@"管理cell的高亮:didUnhighlightItemAtIndexPath");
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    echo(@"取消选择:shouldDeselectItemAtIndexPath");
    return true;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    echo(@"管理cell的选择:shouldSelectItemAtIndexPath");
    return true;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    echo(@"点击了item:didSelectItemAtIndexPath");
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    echo(@"已经取消选择:didDeselectItemAtIndexPath");
}

//由于重用机制，消失在屏幕外的SupplementaryView 会重新出现在屏幕上的使用;
//使用字典以 indexPath 为键，以对应的 SupplementaryView 为值来维护屏幕上可见的 SupplementaryView的信息。
//在这里执行观察操作，如果该 indexPath 在字典里不存在则新建，若存在则更新该键的值。
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    echo(@"重用机制=第%ld行,第%ld项", (long)indexPath.section, (long)indexPath.item);
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    echo(@"解除监听操作:didEndDisplayingSupplementaryView");
}

//     These methods provide support for copy/paste actions on cells.
//     All three should be implemented if any are.
//MARK:    显示编辑菜单（如复制，粘贴等）
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    echo(@"显示编辑菜单（如复制，粘贴等:shouldShowMenuForItemAtIndexPath,详情参考SwiftLearnAll");
    return true;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    echo(@"菜单中哪些编辑操作可以显示:canPerformAction,详情参考SwiftLearnAll");
    return true;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    echo(@"对于显示的编辑操作怎么执行:performAction,详情参考SwiftLearnAll");
}


//MARK:    使用交互过渡改变当前布局
- (UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout{
    echo(@"使用交互过渡改变当前布局:transitionLayoutForOldLayout");
    UICollectionViewTransitionLayout * transitionlayout = [[UICollectionViewTransitionLayout alloc] initWithCurrentLayout:fromLayout nextLayout:toLayout];
    return transitionlayout;
}

- (NSIndexPath *)collectionView:(UICollectionView *)collectionView targetIndexPathForMoveFromItemAtIndexPath:(NSIndexPath *)originalIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath{
    echo(@"未知的作用:targetIndexPathForMoveFromItemAtIndexPath");
    NSIndexPath *index = [NSIndexPath indexPathForItem:originalIndexPath.item inSection:originalIndexPath.section];
    return index;
}

- (CGPoint)collectionView:(UICollectionView *)collectionView targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset{
    echo(@"未知的作用:targetContentOffsetForProposedContentOffset");
    CGPoint point = CGPointMake(proposedContentOffset.x, proposedContentOffset.y);
    return point;
}

//MARK: UICollectionViewDataSource代理方法的实现
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.mainData.count;
}

//MARK:    返回指定索引路径的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZyBaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor zy_RandomColorSixteen];
    return cell;
}

//MARK:  section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
//MARK:    设置header和footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZyBaseCollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADVIEWID forIndexPath:indexPath];
        headView.backgroundColor = [UIColor lightGrayColor];
        return headView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        ZyBaseCollectionReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOTVIEWID forIndexPath:indexPath];
        footView.backgroundColor = [UIColor orangeColor];
        return footView;
    }else{
        echo(@"headView,footView==未知错误！");
        return nil;
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    echo(@"未知：canMoveItemAtIndexPath");
    return true;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    echo(@"未知：moveItemAtIndexPath");
}

- (NSArray<NSString *> *)indexTitlesForCollectionView:(UICollectionView *)collectionView{
    echo(@"未知：indexTitlesForCollectionView");
    return @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"#"];
}

- (NSIndexPath *)collectionView:(UICollectionView *)collectionView indexPathForIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    echo(@"未知：indexPathForIndexTitle \n %@, %ld",title, (long)index);
    return [NSIndexPath indexPathForItem:0 inSection:1];
}

//    UICollectionViewDelegateFlowLayout代理方法的实现
//MARK: cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (WIDTH - 60)/3;
    return CGSizeMake(width, width * 5/4);
}

//MARK:  每个section的margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //        UIEdgeInsetsMake(item距离上面的headView的距离, item距离左边的距离, item距离footView的距离, item距离右边的距离)
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

// MARK:   每个section中不同行的行间距（item与item的上下距离）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 20;
}

//MARK:     item与item之间的距离（不是item与周边的距离）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//MARK: footView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(WIDTH - 20, 0.1);
}

//MARK:    HeaderView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(WIDTH - 20, 0.1);
}








@end
