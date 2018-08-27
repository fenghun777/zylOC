//
//  ChatView.m
//  zylOC
//
//  Created by 张钰营 on 2018/7/20.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ChatView.h"
#import "ChatViewTextCell.h"
#import "ChatViewModel.h"

@implementation ChatView

- (void)initView {
    [super initView];
    
    self.mainData = [[NSMutableArray alloc] init];
    ChatViewModel *chatViewModel1 = [[ChatViewModel alloc] init];
    chatViewModel1.imageUrl = @"";
    chatViewModel1.nickName = @"zyy5s";
    chatViewModel1.type = ChatViewCellTypeText;
    chatViewModel1.cellType = @"ChatViewTextCell";
    
    ChatViewModel *chatViewModel2 = [[ChatViewModel alloc] init];
    chatViewModel2.imageUrl = @"";
    chatViewModel2.nickName = @"zyy5s";
    chatViewModel2.type = ChatViewCellTypeText;
    chatViewModel2.cellType = @"ChatViewTextCell";
    
    ChatViewModel *chatViewModel3 = [[ChatViewModel alloc] init];
    chatViewModel3.imageUrl = @"";
    chatViewModel3.nickName = @"zyy5s";
    chatViewModel3.type = ChatViewCellTypeText;
    chatViewModel3.cellType = @"ChatViewTextCell";
    
    [self.mainData addObject:chatViewModel1];
    [self.mainData addObject:chatViewModel2];
    [self.mainData addObject:chatViewModel3];
    
    [self registerClass:[ChatViewTextCell class] forCellReuseIdentifier:@"ChatViewTextCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatViewModel *chatViewModel = self.mainData[indexPath.row];
    ChatViewCellType typeStr = chatViewModel.type;
    switch (typeStr) {
        case ChatViewCellTypeText:{
            ChatViewTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatViewTextCell"];
            [cell setImageStr:@""];
            [cell setDetailStr:@"detail"];
            return cell;
        }
            break;
        default:{
            ChatViewTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatViewTextCell"];
            return cell;
        }
            break;
    }
    return nil;
}

@end
