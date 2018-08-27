//
//  ChatViewController.m
//  zylOC
//
//  Created by 张钰营 on 2018/7/20.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatView.h"
#import "ZyInputToolView.h"

//<ZyInputToolViewDelegate>
@interface ChatViewController ()
@property (nonatomic, strong) ChatView *chatView;//聊天内容展示
@property (nonatomic, strong) ZyInputToolView *inputToolView;//聊天的输入框
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
//    [center addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (ChatView *)chatView {
    if (!_chatView) {
        _chatView = [[ChatView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - NAVBAR_HEIGHT - 55) style:UITableViewStyleGrouped];
        [_chatView setBackgroundColor:[UIColor greenColor]];
    }
    return _chatView;
}

- (ZyInputToolView *)inputToolView {
    if (!_inputToolView) {
        _inputToolView = [[ZyInputToolView alloc] initWithFrame:CGRectMake(0, HEIGHT - NAVBAR_HEIGHT - 50, WIDTH, 50)];
        _inputToolView.inputToolViewDelegate = self;
    }
    return _inputToolView;
}

- (void)controllerInit{
    [self.view addSubview:self.chatView];
    [self.view addSubview:self.inputToolView];
    
//    TIMConversation * c2c_conversation = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:@"zyy8"];
//    echo(@"%@", c2c_conversation);
//
//    NSString *identifier = [[TIMManager sharedInstance] getLoginUser];
//
//    NSArray *arrCon = [[TIMManager sharedInstance] getConversationList];
//    echo(@"%@", [arrCon description]);
    

    
    
}

////MARK: ZyInputToolViewDelegate 点击发送
//- (void)inputToolViewDelegateFunforEditedEnd:(NSString *)inputStr{
//    [_inputToolView endEditing:true];
//    TIMConversation * c2c_conversation = [[TIMManager sharedInstance] getConversation:TIM_C2C receiver:@"zyy8"];
//    TIMTextElem * text_elem = [[TIMTextElem alloc] init];
//    [text_elem setText:inputStr];
//    TIMMessage * msg = [[TIMMessage alloc] init];
//    [msg addElem:text_elem];
//    [c2c_conversation sendMessage:msg succ:^{
//        echo(@"发送成功");
//    } fail:^(int code, NSString *msg) {
//        echo(@"发送失败");
//    }];
//}
//
////  键盘弹出触发该方法
//- (void)keyboardDidShow:(NSNotification *)obj {
//    NSLog(@"键盘弹出");
//    __weak typeof(self) weakself = self;
//    //键盘最后的frame
//    CGRect keyboardFrame = [obj.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat height = keyboardFrame.size.height;
//    //需要移动的距离
//    if (height > 0) {
//        //移动
//        [UIView animateWithDuration:0.3 animations:^{
//            [weakself.chatView setFrame:CGRectMake(0, 0, WIDTH, HEIGHT - NAVBAR_HEIGHT - height - 45)];
//            [weakself.inputToolView setFrame:CGRectMake(0, HEIGHT - NAVBAR_HEIGHT - 50 - height, WIDTH, 50)];
//        }];
//    }
//}
////  键盘隐藏触发该方法
//- (void)keyboardDidHide:(NSNotification *)obj {
//    NSLog(@"键盘隐藏");
//    __weak typeof(self) weakself = self;
//    [UIView animateWithDuration:0.3 animations:^{
//        [weakself.chatView setFrame:CGRectMake(0, 0, WIDTH, HEIGHT - NAVBAR_HEIGHT - 55)];
//        [weakself.inputToolView setFrame:CGRectMake(0, HEIGHT - NAVBAR_HEIGHT - 50, WIDTH, 50)];
//    }];
//}
//
////销毁界面 同时销毁通知
//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
//}
//
@end
