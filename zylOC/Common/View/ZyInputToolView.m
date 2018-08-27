//
//  ZyInputToolView.m
//  zylOC
//
//  Created by 张钰营 on 2018/7/23.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyInputToolView.h"


@interface ZyInputToolView ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *tvInput;
@end

@implementation ZyInputToolView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (UITextView *)tvInput {
    if (!_tvInput) {
        _tvInput = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, WIDTH - 10, 40)];
        [_tvInput setKeyboardType:UIKeyboardTypeDefault];
        [_tvInput setKeyboardAppearance:UIKeyboardAppearanceAlert];
        [_tvInput setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
        _tvInput.delegate = self;
        _tvInput.returnKeyType = UIReturnKeySend;
        _tvInput.font = FONT(15);
//        _tvInput.text = @"请输入相关内容";
//        _tvInput.backgroundColor = [UIColor whiteColor];
//        [_tvInput setEditable:true];
//        [_tvInput setSelectable:true];
//        [_tvInput resignFirstResponder];
//        [_tvInput setClearsOnInsertion:true];
        
    }
    return _tvInput;
}

- (void)initView {
    self.backgroundColor = [UIColor blueColor];
    [self addSubview:self.tvInput];
}

//MARK: UITextViewDelegate的方法
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return true;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return true;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSString *inputStr = textView.text;
    if (inputStr&&![inputStr isEqualToString:@""]&&[self.inputToolViewDelegate respondsToSelector:@selector(inputToolViewDelegateFunforEditedEnd:)]) {
        [self.inputToolViewDelegate inputToolViewDelegateFunforEditedEnd:inputStr];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    echo(@"======%@", text);
    if ([text isEqualToString:@"\n"]) {
        [self endEditing:true];
    }
    return true;
}

- (void)textViewDidChange:(UITextView *)textView {
    echo(@"======%@", textView.text);
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    echo(@"======%@", textView.text);
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0) {
    return true;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0) {
    return true;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithURL:inRange:forInteractionType: instead") {
    return true;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithTextAttachment:inRange:forInteractionType: instead") {
    return true;
}

@end
