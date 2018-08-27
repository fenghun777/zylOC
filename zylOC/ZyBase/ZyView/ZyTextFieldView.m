//
//  ZyTextFieldView.m
//  zylOC
//
//  Created by 张钰营 on 2018/6/20.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyTextFieldView.h"


@interface ZyTextFieldView ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UILabel *placeHolderLabel;
@end

@implementation ZyTextFieldView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)initView{
    
    self.layer.borderWidth = 0.0;//边宽
    self.layer.cornerRadius = 0.0;//设置圆角
    self.layer.borderColor =[[UIColor grayColor] CGColor];
    
    //先创建个方便多行输入的textView
    self.textView =[[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview :self.textView];
    self.textView.delegate = self;
    self.textView.layer.borderWidth = 0.0;//边宽
    self.textView.layer.cornerRadius = 0.0;//设置圆角
    self.textView.layer.borderColor =[[UIColor grayColor] CGColor];
    
    //再创建个可以放置默认字的lable
    self.placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,7,self.frame.size.width - 10,15)];
    [self.textView addSubview:self.placeHolderLabel];
    self.placeHolderLabel.numberOfLines = 0;
    self.placeHolderLabel.text = @"请输入";
    self.placeHolderLabel.backgroundColor =[UIColor clearColor];
    self.placeHolderLabel.textColor = [UIColor grayColor];
    self.placeHolderLabel.font = [UIFont systemFontOfSize:14];
}

- (void)setMaxLength:(NSInteger)maxLength{
    _maxLength = maxLength;
}

- (void)setFont:(CGFloat)font{
    _font = font;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
}

- (void)setPlaceStr:(NSString *)placeStr{
    _placeStr = placeStr;
}

//接下来通过textView的代理方法实现textfield的点击置空默认自负效果
- (void)textViewDidChange:(UITextView *)textView{
    if([textView.text length] == 0){
        self.placeHolderLabel.text = @"请输入";
    }else{
        self.placeHolderLabel.text = @"";//这里给空
    }
}

//设置超出最大字数 即不可输入 也是textview的代理方法
-(BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text{
    if ([text isEqualToString:@"\n"]) {     //这里"\n"对应的是键盘的 return 回收键盘之用
        [textView resignFirstResponder];
        return YES;
    }
    if ((range.location >= _maxLength)&&(_maxLength >= 1)){
        return NO;
    }else {
        return YES;
    }
}










@end
