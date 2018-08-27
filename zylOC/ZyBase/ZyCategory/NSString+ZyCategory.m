//
//  NSString+ZyCategory.m
//  zylOC
//
//  Created by yy z on 2018/3/12.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "NSString+ZyCategory.h"
#import <CommonCrypto/CommonDigest.h>//加密相关引入

@implementation NSString (ZyCategory)

+ (NSString *)zy_ChineseToUTF8:(NSString *)str{
    if (@available(iOS 7.0, *)) {
        NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
        NSString *encodedUrl = [str stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
        return encodedUrl;
    } else{
        NSMutableString *muStr = (NSMutableString *)str;
        for(int i=0; i< [str length];i++){
            int a = [str characterAtIndex:i];
            if( a > 0x4e00 && a < 0x9fff)
            {
                NSString *chineseStr = [str substringWithRange:NSMakeRange(i, 1)];
                //                这个函数已经失去意义了
                NSString *utfStr = [chineseStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                muStr = (NSMutableString *)[muStr stringByReplacingOccurrencesOfString:chineseStr withString:utfStr];
            }
        }
        return (NSString *)muStr;
    }
}

//MARK:是否包含汉字
+ (BOOL)zy_ContainChinese:(NSString *)str{
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

+ (int)zy_CheckIsHaveNumAndLetter:(NSString*)str{
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:str
                                                                       options:NSMatchingReportProgress
                                                                         range:NSMakeRange(0, str.length)];
    
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    
    if (tNumMatchCount == str.length) {
        //全部符合数字，表示沒有英文
        return 1;
    } else if (tLetterMatchCount == str.length) {
        //全部符合英文，表示沒有数字
        return 2;
    } else if (tNumMatchCount + tLetterMatchCount == str.length) {
        //符合英文和符合数字条件的相加等于密码长度（有英文和数字）
        return 3;
    } else {
        return 4;
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误（有英文和数字，标点符号）
    }
}


//sha加密
+ (NSString *)zy_Sha1:(NSString *)input{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (int)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

//MD5加密
+ (NSString *)zy_Md5:(NSString *)input{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (int)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}


@end
