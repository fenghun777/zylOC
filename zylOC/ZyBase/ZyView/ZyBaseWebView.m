//
//  ZyBaseWebView.m
//  jkbs_base
//
//  Created by iosdev1 on 2017/2/21.
//  Copyright © 2017年 iosdev1. All rights reserved.
//

#import "ZyBaseWebView.h"

@interface ZyBaseWebView ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic, strong) NSString *firstUrl;
@property (strong, nonatomic) UIProgressView *progressView;
@end

@implementation ZyBaseWebView

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration{
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    if (@available(iOS 9.0, *)) {
        [self setAllowsLinkPreview:YES];
    } else {
        // Fallback on earlier versions
    }
    [self setAllowsBackForwardNavigationGestures:YES];
    
    [self initWKWebView];
    
//        [self initProgressView];
    
    // 添加KVO监听
    //    [self addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    //
//        [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    //    把他关掉，进度条会停止
//    [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)initWKWebView
{
    //    self.serverTrust
    //    self.hasOnlySecureContent = true;
    self.navigationDelegate = self;
    self.UIDelegate = self;
}

- (void)initProgressView
{
    CGFloat kScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 1, kScreenWidth, 80)];
//    progressView.tintColor = COLOR_BACKGROUND;
    progressView.trackTintColor = [UIColor whiteColor];
    //    progressView.trackImage = [UIImage imageNamed:@"Ico_Share_QQ"];
    //    progressView.progressImage = [UIImage imageNamed:@"Ico_Share_PYQ"];
    
    [self addSubview:progressView];
    self.progressView = progressView;
}

#pragma mark - KVO
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            [self.progressView setProgress:1.0 animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:YES];
            });
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

#pragma mark WKNavigationDelegate
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSURL *URL = navigationAction.request.URL;
    NSString *url = [URL absoluteString];
    url = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    echo(@"热乎乎的网址：%@",url);
    if ([url containsString:@"&params="]) {
        [self paramsWithUrl:url];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }else if ([url containsString:@"//share"]&&![url containsString:@"&params="]) {
        NSString *controller = [url stringByReplacingCharactersInRange:NSMakeRange(0, 7) withString:@""];
        
        NSArray *path = [controller componentsSeparatedByString:@"/"];
        if (path.count == 0) {
            return;
        }
        
        if ([controller hasPrefix:@"url/"]) {
            return;
        }
        
        [self fxJs:path];
        
    }else if ([url containsString:@"&callback="]) {
        [self callbackWithUrl:url];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }else{
//        url = [ZyUtils chineseToUTF8:url];//把字符串中的中文转化成utf8
    }
 
  //打电话
    if ([url hasPrefix:@"tel:"]) {
        NSString *phoneNum = [url substringFromIndex:4];
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNum];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    //    发短信
    if ([url hasPrefix:@"sms:"]) {
        NSString *phoneNum = [url substringFromIndex:4];
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"sms://%@",phoneNum];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
    return;
}

- (void) fxJs:(NSArray *)path{

}

-(NSString *)decodeString:(NSString*)encodedString

{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
    return;
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    [ showMessage:@"页面开始加载时调用"];
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
//    [ showMessage:@"接收到服务器跳转请求之后调用"];
}

// 当main frame开始加载数据失败时，会回调
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
//    [ showMessage:@"页面加载失败"];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
//    [ showMessage:@"当内容开始返回时调用"];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    if (webView.title.length > 0) {
        if (self.getWebTitleBlock) {
            self.getWebTitleBlock(webView.title);
            echo(@"===webView.title:%@",webView.title);
        }
    }

    //获取页面高度，并重置webview的frame
    [self evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
//        double height = [result doubleValue];
        CGRect frame =webView.frame;
                frame.size.height = 300;        
//                webView.frame = CGRectMake(10, 80, WIDTH - 20, HEIGHT - 190);
        
        if (self.getWebSizeBlock) {
            self.getWebSizeBlock(CGRectMake(10, 80, WIDTH - 20, HEIGHT - 190));
        }
        
    }];
}

// 当main frame最后下载数据失败时，会回调
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
//    [ showMessage:@"下载数据失败"];
}

// 这与用于授权验证的API，与AFN、UIWebView的授权验证API是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    //  [ showMessage:@"授权验证的API"];
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        if ([challenge previousFailureCount] == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        } else {
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
    }
}

// 当web content处理完成时，会回调
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
//    [ showMessage:@"当web content处理完成时"];
}


#pragma mark WKUIDelegate
// 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    // 接口的作用是打开新窗口委托
//    [ZyUtils showMessage:@"打开新窗口"];
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)webViewDidClose:(WKWebView *)webView{
//    [ZyUtils showMessage:@"当web content处理完成时"];
}

/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    echo(@"函数名:%s", __FUNCTION__);
//        [ZyUI alertViewForWeb:message andCancel:^(id sender) {
//            completionHandler();
//        } andSure:^(id sender) {
          completionHandler();
//        }];
}

//HTML页面弹出Confirm时调用此方法
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    echo(@"函数名:%s", __FUNCTION__);
//    [ZyUI alertViewForWeb:message andCancel:^(id sender) {
//        completionHandler([NSString stringWithFormat:@"message:%@\n result:false\nframe:%@",message,frame]);
//    } andSure:^(id sender) {
//        completionHandler([NSString stringWithFormat:@"message:%@\n result:true\nframe:%@",message,frame]);
//    }];
    completionHandler([NSString stringWithFormat:@"message:%@\n result:true\nframe:%@",message,frame]);
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    echo(@"%s\n\n\n prompt:%@  defaultText:%@ frame:%@",__FUNCTION__,prompt,defaultText,frame);
    
//        [ZyUI alertViewForWeb:prompt andCancel:^(id sender) {
//            completionHandler([NSString stringWithFormat:@"prompt:%@\ndefaultText:%@\nframe:%@",prompt,defaultText,frame]);
//        } andSure:^(id sender) {
//            completionHandler([NSString stringWithFormat:@"prompt:%@\ndefaultText:%@\nframe:%@",prompt,defaultText,frame]);
//        }];
    completionHandler([NSString stringWithFormat:@"prompt:%@\ndefaultText:%@\nframe:%@",prompt,defaultText,frame]);
    
}

//当用户触摸元素时webView(_:shouldPreviewElement:)立即被调用。返回false将完全禁用该元素的预览，并且阻止其他方法的调用。返回true将提供一个自定义视图控制的机会
- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo NS_AVAILABLE_IOS(10_0){
    echo(@"函数名:%s", __FUNCTION__);
    return false;
}

//如果用户输入Peek，那么webView(_:previewingViewControllerForElement:defaultActions:)为其提供了一个定制视图控制器的机会。返回任何非空视图控制器都会导致视图控制器显示为Peek预览。defaultActions参数是一个活动数组，WebKit Webkit默认使用它作为previewActionItems。如果想要使用这些活动中的任何一个，你只需从视图控制器的previewActionItems执行结果中返回即可,更新后的WKWebView API支持对超链接的预览，为用户呈现自定义视图。通过这个API，你可以通过Peek和Pop手势来触发预览视图，避免跳转去Safari，除此之外，你还可以自定义预览行为
- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions NS_AVAILABLE_IOS(10_0){
    echo(@"函数名:%s", __FUNCTION__);
    UIViewController *controller = [[UIViewController alloc]init];
    
    return controller;
}

//如果用户用足够的力触摸来弹出视图控制器，webView(_:commitPreviewingViewController:)将被调用。此时，你可以选择在app中展示弹出的视图控制器。
- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController{
    echo(@"函数名:%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView runOpenPanelWithParameters:(WKOpenPanelParameters *)parameters initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSArray<NSURL *> * _Nullable URLs))completionHandler{
    echo(@"函数名:%s", __FUNCTION__);
    
}

#pragma mark WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
//    [ZyUtils showMessage:@"与js交互"];
    // 判断是否是调用原生的
    if ([@"NativeMethod" isEqualToString:message.name]) {
        // 判断message的内容，然后做相应的操作
        if ([@"close" isEqualToString:message.body]) {
            
        }
    }
}

- (void) zyLoadUrl:(NSString *) url{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters = [ZyUtils clientPrepareHttpParameters:[parameters mutableCopy]];
//    [parameters setObject:[ZyUtils timeStamp] forKey:@"t"];
    
    NSMutableArray *pairs = [[NSMutableArray alloc]init];
    for(NSString* key in parameters){
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, parameters[key]]];
    }
    NSString *requestParameters = [pairs componentsJoinedByString:@"&"];
    if ([url rangeOfString:@"app_id"].location == NSNotFound) {
        if ([url rangeOfString:@"access-token"].location == NSNotFound) {
            url = [NSString stringWithFormat:@"%@%@%@", url, [url.description containsString:@"?"] ? @"&" : @"?", requestParameters];
        }
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self loadRequest:request];
    _firstUrl = [request.URL absoluteString];
}

- (void)zyLoadLocationUrl:(NSString *)url{
    NSString *path = [[NSBundle mainBundle] pathForResource:url ofType:@"html"];
    if(path){
        // iOS9. One year later things are OK.
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        if (@available(iOS 9.0, *)) {
            [self loadFileURL:fileURL allowingReadAccessToURL:fileURL];
        } else {
            NSURL *fileURL = [NSURL fileURLWithPath:path];
            NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
            [self loadRequest:request];
        }
    }
}

- (void) zyLoadNoneParaUrl:(NSString *) url{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self loadRequest:request];
    _firstUrl = [request.URL absoluteString];
}

- (void)paramsWithUrl:(NSString *)url{
//    NSArray *arrParams = [url componentsSeparatedByString:@"&params="];
//    NSString *params = arrParams[1];
//    NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//
//    NSString *funcStr = arrParams[0];
//    NSString *callBack = [funcStr componentsSeparatedByString:@"&callback="][1];
    
//    if ([url containsString:@"//go"]) {
//        //    判断跳转到原生还是网页
//
//    }else if ([url containsString:@"//updateHeader"]){
//        //   设置title
//        if (self.getWebTitleBlock) {
//            self.getWebTitleBlock(dic[@"title"]);
//        }
//    }
}

- (void)callbackWithUrl:(NSString *)url{
    NSArray *arrUrl = [url componentsSeparatedByString:@"callback="];
    if (arrUrl[1]) {
//        NSString *callbackStr = arrUrl[1];
        if ([url containsString:@"//getUserInfo"]) {
            //    获取登录用户信息
//            PostNotification(, );
        }else if ([url containsString:@"//getNetwork"]){
            //    获取网络状态
//            PostNotification(ZyNoticeGetNetwork, callbackStr);
        }else if ([url containsString:@"//getLocation"]){
            //    获取地理位置
//            PostNotification(, );
        }else if ([url containsString:@"//chooseImage"]){
            //    拍照或从手机相册中选图
//            PostNotification(, );
        }else if ([url containsString:@"//setTitle"]){
            //    修改药店名
//            PostNotification(, );
        }else if ([url containsString:@"//showSearch"]){
            //    修改药店名
//            PostNotification(, );
        }else if ([url containsString:@"//getWechatInfo"]){
            //    修改药店名
//            PostNotification(, );
        }
    }
}

- (void)urlNSLog:(NSURL *)url{
    echo(@"函数名:%s", __FUNCTION__);
    echo(@"协议:%@", [url scheme]); //协议 http
    echo(@"域名:%@", [url host]);     //域名 www.baidu.com
    echo(@"完整的url字符:%@", [url absoluteString]); //完整的url字符串 http://www.baidu.com:8080/search?id=1
    echo(@"相对路径: %@", [url relativePath]); //相对路径 search
    echo(@"端口  :%@", [url port]);  // 端口 8080
    echo(@"路径: %@", [url path]);  // 路径 search
    echo(@"析构路径，获得组成此路径的各个部分:%@", [url pathComponents]); // search
    echo(@"参数:%@", [url query]);  //参数 id=1
}


@end
