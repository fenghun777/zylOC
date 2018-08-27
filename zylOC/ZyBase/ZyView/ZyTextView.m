//
//  ZyTextView.m
//  zylOC
//
//  Created by 张钰营 on 2018/5/21.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyTextView.h"

@interface ZyTextView ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *tvInfo;
@property (nonatomic, strong) NSString *placeStr;
@end

@implementation ZyTextView


- (instancetype)init{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (UITextView *)tvInfo{
    if (!_tvInfo) {
        _tvInfo = [UITextView new];
        _tvInfo.delegate = self;
    }
    return _tvInfo;
}

- (void)initView{
    self.tvInfo = [[UITextView alloc] init];
    [self addSubview:_tvInfo];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_tvInfo setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
}

- (void)setPlace:(NSString *)place color:(UIColor*)color{
    [self setPlaceStr:place];
    [self setAboutPlace];
}

- (void)setAboutPlace{
    [_tvInfo setText:_placeStr];
    _tvInfo.textColor = COLOR_TEXT_FOUR;
}

// MARK: UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    return true;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{

    return true;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSString *infoStr = textView.text;
    if ([infoStr isEqualToString:@""]||infoStr == nil) {
        
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    return true;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    
    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0){
    
    return true;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0){
    
    return true;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithURL:inRange:forInteractionType: instead"){
    
    return true;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_DEPRECATED_IOS(7_0, 10_0, "Use textView:shouldInteractWithTextAttachment:inRange:forInteractionType: instead"){
    
    return true;
}







@end
