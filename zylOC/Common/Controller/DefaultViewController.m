//
//  DefaultViewController.m
//  zylOC
//
//  Created by yy z on 2018/3/14.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "DefaultViewController.h"
#import "ZyScrollView.h"
#import "ZyTextView.h"
#import "ZyBigImagesView.h"
#import "ZyFluidLayoutLabel.h"
#import "NSString+ZyCategory.h"


#import "ZyCalendar.h"
#import "ZyTextFieldView.h"

@interface DefaultViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *placeHolderLabel;
@property(nonatomic,strong)UILabel *residueLabel;// 输入文本时剩余字数
@end

@implementation DefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:@"这是一个百度链接!!!!!"];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"baidu://"
                             range:[[attributedString string] rangeOfString:@"百度链接"]];
    
    UITextView *text = [[UITextView  alloc]init];
    text.attributedText = attributedString;
    text.frame = CGRectMake(100, 100, 300, 100);
    text.editable = NO;
    text.delegate = self;
    [self.view addSubview:text];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, attributedString.length)];
    text.attributedText = attributedString;
    text.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                NSUnderlineColorAttributeName: [UIColor clearColor],
                                NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"baidu"]) {
        NSLog(@"进来了");
    }
    return YES;
}


- (void)controllerInit{

    
    
    
    
    
//    ZyTextFieldView *ztfd = [[ZyTextFieldView alloc] initWithFrame:CGRectMake(10, 100, 200, 200)];
//    [self.view addSubview:ztfd];
//    [ztfd initView];
}

- (void)func6{
    NSString *string1 = @"123asdf";
    NSString *string2 = @"张钰营";
    NSString *string3 = @"123张asdf";
    NSString *string4 = @"asdf";
    
    echo(@"%@", [NSString zy_ChineseToUTF8:string3]);
    
    if ([NSString zy_ContainChinese:string2]) {
        echo(@"数字");
    }
    
    if ([NSString zy_ContainChinese:string1]) {
        echo(@"字母");
    }
    
    if ([NSString zy_ContainChinese:string4]) {
        echo(@"汉字");
    }
}

- (void)func4{
    __weak typeof(self) weakself = self;
    
    UILabel *label1 = [UILabel zy_InitWithTitle:@"label1" font:FONT(14) color:COLOR_TEXT_TITLE];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    label1.backgroundColor = [UIColor yellowColor];
    
    UILabel *label2 = [UILabel zy_InitWithTitle:@"label2" font:FONT(14) color:COLOR_TEXT_TITLE];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view).offset(80);
        make.left.equalTo(self.view).offset(10).priorityMedium();
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    label2.backgroundColor = [UIColor redColor];
    
    UILabel *label3 = [UILabel zy_InitWithTitle:@"label3" font:FONT(14) color:COLOR_TEXT_TITLE];
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(280);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    
    UILabel *label4 = [UILabel zy_InitWithTitle:@"label4" font:FONT(14) color:COLOR_TEXT_TITLE];
    [self.view addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(380);
        make.left.equalTo(self.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    
}

- (void)func3{
    
    NSArray *arrData = @[@"11状态", @"22程序取消激活状态",
                         @"33程序取消激活状态", @"44",
                         @"55程序取消", @"666激活状态",
                         @"777程序取消激活", @"888模式",
                         @"9程序", @"10程序取消激活",
                         @"11模式", @"12程序"];
    
    CGFloat widthF = WIDTH - 24;
    ZyFluidLayoutLabel *flabel = [[ZyFluidLayoutLabel alloc] init];
    [self.view addSubview:flabel];
    [flabel initData:arrData andVertical:10 andLevel:18 font:14 labelHeight:17 viewWidth:widthF];
    [flabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(15);
        make.left.equalTo(self.view).offset(15);
        make.size.mas_equalTo(CGSizeMake(widthF, flabel.viewHeight));
    }];
    flabel.backgroundColor = [UIColor whiteColor];
}

- (void)func2{
    ZyTextView *tvInfo = [[ZyTextView alloc] init];
    [self.view addSubview:tvInfo];
    [tvInfo setFrame:CGRectMake(10, 80, 200, 140)];
    [tvInfo setPlace:@"place" color:COLOR_TEXT_TITLE];
}



- (void)func1{
    NSLog(@"%@", [NSLocale availableLocaleIdentifiers]);
    
    UIView *dateView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:dateView];
    dateView.backgroundColor = [UIColor yellowColor];
    NSLog(@"%@", [NSLocale availableLocaleIdentifiers]);
    // 初始化UIDatePicker，旋转滚动选择日期类
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 350, 320, 216)];

    // 设置时区
    [datePicker setTimeZone:[NSTimeZone localTimeZone]];
    

    // 设置UIDatePicker的显示模式
    [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
//    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
//    datePicker.locale = locale;
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_GB"]];
    datePicker.minimumDate = [NSDate date]; // 最小时间
    
    
    // 设置当前显示时间
    [datePicker setDate:[NSDate date] animated:YES];
    // 设置显示最大时间（此处为当前时间）
    [datePicker setMaximumDate:[NSDate date]];
    // 当值发生改变的时候调用的方法
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [dateView addSubview:datePicker];
//
//    UIDatePickerModeTime,           // Displays hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. 6 | 53 | PM)
//    UIDatePickerModeDate,           // Displays month, day, and year depending on the locale setting (e.g. November | 15 | 2007)
//    UIDatePickerModeDateAndTime,    // Displays date, hour, minute, and optionally AM/PM designation depending on the locale setting (e.g. Wed Nov 15 | 6 | 53 | PM)
//    UIDatePickerModeCountDownTimer,
}

- (void)datePickerValueChanged:(id)sender{
    echo(@"%@", sender);
    echo(@"%@", sender);
}












- (void)func100{
//    默认帮你把timer加入Runloop
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    
//    放入子线程
    dispatch_queue_t global_queue = dispatch_get_global_queue(0, 0);
    dispatch_async(global_queue, ^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
        
        
//        NSDefaultRunLoopMode ： 占位符，在默认和UItracking下
//        NSRunLoopCommonModes ：runloop默认的模式，有事件就处理
        //        UITrackingRunLoopMode :(优先切换)这个模式就是当UI时间交互的时候runloop切换到的模式
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    });
}

- (void)timerRun{
    NSLog(@"===睡两秒");
//    阻塞主线程
    [NSThread sleepForTimeInterval:2.0];
    
    static int num = 0;
    NSLog(@"%@------%d", [NSThread currentThread], num++);
    
}


























@end
