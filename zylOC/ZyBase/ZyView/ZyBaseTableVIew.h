//
//  ZyBaseTableVIew.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZyBaseTableVIew : UITableView<UITableViewDelegate,UITableViewDataSource>
- (void)initView;
@property (nonatomic, strong) NSArray *mainData;
@end
