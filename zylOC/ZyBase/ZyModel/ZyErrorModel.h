//
//  ZyErrorModel.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyBaseModel.h"

@interface ZyErrorModel : ZyBaseModel
@property (copy, nonatomic) NSString *message;
@property (copy, nonatomic) NSString *code;
@end
