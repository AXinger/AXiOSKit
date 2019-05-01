//
//  AXWKWebVC.m
//  AXiOSKit
//
//  Created by liuweixing on 16/10/13.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXWKWebVC.h"
@import WebKit;
#import "AXiOSKit.h"
#import "NSBundle+AXBundle.h"
#import "AXScriptMessageHandlerHelper.h"
#import <Masonry/Masonry.h>
#import "AXWebScriptMessageModel.h"

typedef NS_ENUM(NSInteger, WKWebLoadType){
    WKWebLoadTypeURLString,
    WKWebLoadTypeHTMLString,
    WKWebLoadTypeHTMLFilePath,
    WKWebLoadTypeURL,
};

@interface AXWKWebVC ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) UIProgressView *progressView;

/**
 网页加载的类型
 */
@property (nonatomic, assign) WKWebLoadType loadType;

/**
 *
 */
@property (nonatomic, strong) UIButton *cancelButton;

/**
 * 取消item
 */
@property (nonatomic, strong) UIBarButtonItem *cancelItem;

/**
 * 返回按钮 当打开新web时, 显示
 */
@property (nonatomic) UIBarButtonItem *backItem;

/**
 * 关闭按钮 当打开新web时, 显示
 */
@property (nonatomic, strong) UIBarButtonItem* closeItem;

/**
 *解决self.webView.configuration.userContentController强引用
 */
@property (nonatomic, strong) AXScriptMessageHandlerHelper *handlerHelper;

/**
 *多个js交互,根据name保存,回调
 */
@property (nonatomic, copy) NSMutableDictionary <NSString *,void(^)(id data, NSError* error)>* scriptMessageDict;

@property (nonatomic, copy) NSMutableDictionary <NSString *,AXWebScriptMessageModel *>* scriptMessageModelDict;


@end

@implementation AXWKWebVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self __initView];
    [self __initNavItme];
    [self __webViewloadURLType];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.progressView setProgress:0.0f animated:NO];
}


#pragma mark -  init
/**
 * view
 */
- (void)__initView{
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    
}

/**
 * UINavigationController itme
 */
- (void)__initNavItme{
    
    [self ax_haveNav:^(UINavigationController *nav) {
        
        UIBarButtonItem *roadLoad = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(roadDataWebAction)];
        self.navigationItem.rightBarButtonItem = roadLoad;
        
    } isPushNav:^(UINavigationController *nav) {
        
    } isPresentNav:^(UINavigationController *nav) {
        
    } noneNav:^{
        [self.webView.scrollView addSubview:self.cancelButton];
    }];
}


#pragma mark -  代理 WKNavigationDelegate
/**
 * 开始加载 类似UIWebView的 -webViewDidStartLoad:
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    AXLog(@"开始加载 title: %@",webView.title);
}

/**
 * 当内容开始返回时调用
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    AXLog(@"当内容开始返回时调用title: %@",webView.title);
}

/**
 * 页面加载完成之后调用
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation { // 类似
    
    AXLog(@"页面加载完成之后调用 webView.title: %@",webView.title);
    //更新左边itme
    [self func_canGoBackItems];
    
}

/**
 * 加载失败 类似 UIWebView 的- webView:didFailLoadWithError:
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    AXLog(@"加载失败 %@",error);
    //    [self fun_loadErrorback];
}

/**
 * 拦截HTTPStatusCode  决定是否允许或取消一个导航后其反应是已知的
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    NSInteger  statusCode = ((NSHTTPURLResponse *)navigationResponse.response).statusCode;
    AXLog(@"拦截HTTPStatusCode %ld",(long)statusCode);
    
    if (statusCode == 200) {
        decisionHandler (WKNavigationResponsePolicyAllow);
    }else {
        [self fun_loadErrorback];
        decisionHandler(WKNavigationResponsePolicyCancel);
    }
}

/**
 * 接收到服务器跳转请求之后调用 主服务器接受到重定向时调用
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
    AXLog(@"接收到服务器跳转请求之后调用 %@",navigation);
}

/**
 * 服务器开始请求的时候调用 是否允许这个导航" 决定是否允许或取消一个导航
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURL *URL = navigationAction.request.URL;
    
    AXLog(@"服务器开始请求的时候调用 %@  %@ %ld",URL.scheme,URL ,(long)navigationAction.navigationType);
    
    if ([URL.scheme isEqual:@"tel"]) {
        
        ax_OpenURL(URL);
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    if ([URL.scheme isEqual:@"sms"]) {
        //短信的处理
        ax_OpenURL(URL);
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    if ([URL.scheme isEqual:@"mailto"]) {
        //邮件的处理
        ax_OpenURL(URL);
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    
    if ([URL.absoluteString containsString:@"ituns.apple.com"]) {
        //打开appstore
        ax_OpenURL(URL);
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}


/**
 * 这与用于授权验证的API，与AFN、UIWebView的授权验证API是一样的 web视图需要响应身份验证时调用
 */
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition , NSURLCredential *))completionHandler {
    
    AXLog(@"授权验证的API");
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

#pragma mark -  代理 WKUIDelegate

/**
 * 接口的作用是打开新窗口委托  创建一个新的webView
 */
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    
    AXLog(@"接口的作用是打开新窗口委托 %d",navigationAction.targetFrame.isMainFrame);
    
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

/**
 * js 里面的alert实现，只有确定,没有取消,如果不实现，网页的alert函数无效  显示一个JavaScript警告面板
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    AXLog(@"runJavaScriptAlertPanelWithMessage %@",message);
    
    [self ax_showAlertByTitle:message confirm:^{
        completionHandler();
    }];
}

/**
 *  js 里面的alert实现 含有确定和取消，如果不实现，网页的alert函数无效  ,  显示一个JavaScript确认面板
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    AXLog(@"runJavaScriptConfirmPanelWithMessage %@",message);
    
    [self ax_showAlertByTitle:message message:nil confirm:^{
        completionHandler(YES);
    } cancel:^{
        completionHandler(NO);
    }];
    
}

/**
 * js 里面的alert实现 TextField文本输入，如果不实现，网页的alert函数无效, 显示一个JavaScript文本输入面板。
 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler {
    
    AXLog(@"runJavaScriptTextInputPanelWithPrompt %@ %@",prompt,defaultText);
    
    [self ax_showAlertTFByTitle:prompt message:defaultText confirm:^(NSString *text) {
        
        completionHandler(text);
        
    } cancel:nil];
}

/**
 * 网页加载内容进程终止
 */
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    AXLog(@"网页加载内容进程终止");
}

// js注入方法
//WKScriptMessageHandler
//依然是这个协议方法,获取注入方法名对象,获取js返回的状态值.
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    void(^handler)(id data, NSError* error)  = self.scriptMessageDict[message.name];
    if (handler) {
        handler(message.name,message.body);
        return;
    }
    
    AXWebScriptMessageModel *model = self.scriptMessageModelDict[message.name];
    if (model) {
        
        id<AXScriptMessageDelegate> delegate = model.obj;
        
        if (delegate && [delegate respondsToSelector:@selector(webVC:messageName:messageBody:)]) {
            [delegate webVC:self messageName:message.name messageBody:message.body];
        }
        return;
    }
}

/**
 js 回调oc
 
 @param name oc方法名
 @param handler 回调
 */
-(void)addScriptMessageWithName:(NSString *)name
                        handler:(void(^)(NSString* name, id body) )handler {
    
    if (self.scriptMessageDict[name] !=nil || self.scriptMessageModelDict[name] !=nil) {
        AXLog(@"addScriptMessageHandler重复注册");
        return;
    }
    if (handler) {
        self.scriptMessageDict[name] = handler;
        [self.webView.configuration.userContentController addScriptMessageHandler:self.handlerHelper name:name];
    }
}

- (void)addScriptDelegate:(id<AXScriptMessageDelegate>)delegate
                   forKey:(NSString *)name {
    
    if (self.scriptMessageDict[name] !=nil || self.scriptMessageModelDict[name] !=nil) {
        AXLog(@"addScriptMessageHandler重复注册");
        return;
    }

    if (delegate && name.length>0 ){
        
        AXWebScriptMessageModel *model = [[AXWebScriptMessageModel alloc]init];
        model.obj = delegate;
        
        self.scriptMessageModelDict[name] = model;
        
        [self.webView.configuration.userContentController addScriptMessageHandler:self.handlerHelper name:name];
    }
}

/**
 oc 调用js方法
 
 @param javaScriptString js方法名
 @param handler 回调
 */
- (void)evaluateJavaScript:(NSString *)javaScriptString
                   handler:(void(^)(id data, NSError* error))handler {
    
    [self.webView evaluateJavaScript:javaScriptString completionHandler:handler];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if (object != self.webView ) {
        
         [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }else{
        
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))]) {
            self.progressView.alpha = 1.0f;
            BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
            [self.progressView setProgress:self.webView.estimatedProgress animated:animated];
            
            if(self.webView.estimatedProgress >= 1.0f) {
                
                [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    self.progressView.alpha = 0.0f;
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                    
                }];
            }
        }else if ([keyPath isEqualToString:NSStringFromSelector(@selector(title))]){
            //使用KVO 显示title 更快一点
            if (self.title.length==0) {
                
                NSString *title = change[@"new"];
                if (title.length>0) {
                    self.title = title;
                }else{
                    self.title = AXKitLocalizedString(@"网页");
                }
            }
        }else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
       
    }
}


#pragma mark - func

-(void)loadWebView {
    [self __webViewloadURLType];
}

- (void)__webViewloadURLType{
    
    if (self.url.length == 0) {
        NSString *htmlString = [NSString stringWithFormat:@"<font size=\"30\">%@ 路径错误</font>",self.url];
        [self.webView loadHTMLString:htmlString baseURL:[NSBundle.mainBundle bundleURL]];
        return;
    }
    
    switch (self.loadType) {
        case WKWebLoadTypeURLString:{
            NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
            [self.webView loadRequest:request];
            break;
        }
            
        case WKWebLoadTypeHTMLString:{
            [self.webView loadHTMLString:self.loadHTMLString baseURL:[NSBundle.mainBundle bundleURL]];
            break;
        }
            
        case WKWebLoadTypeHTMLFilePath:{
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:self.url]];
            [self.webView loadRequest:request];
            break;
        }
        case WKWebLoadTypeURL:{
            NSURLRequest *request = [NSURLRequest requestWithURL:self.loadURL];
            [self.webView loadRequest:request];
            break;
        }
    }
}


/**
 * 页面加载完成 更新LeftBarButtonItems
 */
- (void)func_canGoBackItems{
    
    if (self.webView.canGoBack) {
        
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = 20;
        
        [self ax_haveNav:nil isPushNav:^(UINavigationController *nav) {
            
            self.navigationItem.leftBarButtonItems = @[self.backItem,spaceButtonItem,self.closeItem];
            
        } isPresentNav:^(UINavigationController *nav) {
            
            self.navigationItem.leftBarButtonItems = @[self.cancelItem,spaceButtonItem,self.closeItem];
            
        } noneNav:nil];
        
        // 这行代码可以是侧滑返回webView的上一级，而不是根控制器（*只针对侧滑有效）
        self.webView.allowsBackForwardNavigationGestures = YES;
    }else{
        
        // 这行代码可以是侧滑返回webView的上一级，而不是根控制器（*只针对侧滑有效）
        self.webView.allowsBackForwardNavigationGestures = NO;
        
        self.navigationItem.leftBarButtonItems = nil;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        
        [self ax_haveNav:nil isPushNav:^(UINavigationController *nav) {
            
            self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
            
        } isPresentNav:^(UINavigationController *nav) {
            
            self.navigationItem.leftBarButtonItem = self.cancelItem;
        } noneNav:nil];
    }
}

#pragma mark - action

/**
 * 取消item 事件
 */
- (void)backItemAction:(UIBarButtonItem *)item{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 * 关闭item 事件
 */
- (void)closeItemAction:(UIBarButtonItem *)item{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * 重新加载
 */
- (void)roadDataWebAction{
    [self.webView reload];
}

- (void)cancelButtonAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)rightBarButtonItemEvents:(UIBarButtonItem *)item{
    [self.webView reload];
}


//加载失败,返回
- (void)fun_loadErrorback{
    
    [self ax_showAlertByTitle:@"服务器异常,无法打开" confirm:^{
        
        if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

#pragma mark - set

- (void)setLoadURL:(NSURL *)loadURL {
    _loadURL = loadURL;
    self.url = loadURL.absoluteString;
    self.loadType =  WKWebLoadTypeURL;
}

- (void)setLoadURLString:(NSString *)loadURLString {
    _loadURLString = loadURLString;
    self.url = loadURLString;
    self.loadType = WKWebLoadTypeURLString;
}


- (void)setLoadHTMLString:(NSString *)loadHTMLString {
    _loadHTMLString = loadHTMLString;
    self.url = loadHTMLString;
    self.loadType = WKWebLoadTypeHTMLString;
}

- (void)setLoadHTMLFilePath:(NSString *)loadHTMLFilePath {
    _loadHTMLFilePath = loadHTMLFilePath;
    self.url = loadHTMLFilePath;
    self.loadType = WKWebLoadTypeHTMLFilePath;
}


#pragma mark - get

- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.allowsInlineMediaPlayback = YES;
        //播放背景音乐
        //            config.mediaPlaybackRequiresUserAction = YES;
        //        config.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypeAudio;
        
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        config.userContentController = userContentController;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) configuration:config];
        _webView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:nil];
        [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(title)) options:NSKeyValueObservingOptionNew context:nil];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
    }
    return _webView;
}


- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        
        __block CGRect tempFrame = CGRectZero;
        [self ax_haveNav:^(UINavigationController *nav) {
            tempFrame = CGRectMake(0,ax_navigation_and_status_height(), self.view.bounds.size.width, 3);
        } isPushNav:nil isPresentNav:nil noneNav:^{
            tempFrame = CGRectMake(0, 0, self.view.bounds.size.width, 3);
        }];
        _progressView.frame = tempFrame;
        // 设置进度条的色彩
        _progressView.trackTintColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}

- (UIBarButtonItem*)backItem{
    if (!_backItem) {
        UIImage* backItemImage = [[UIImage axBundle_imageNamed:@"ax_itemBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage* backItemHlImage = [[UIImage axBundle_imageNamed:@"ax_itemBack_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIButton* backButton = [[UIButton alloc] init];
        [backButton setTitle:AXKitLocalizedString(@"ax.back") forState:UIControlStateNormal];
        [backButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
        [backButton setTitleColor:[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [backButton setImage:backItemImage forState:UIControlStateNormal];
        [backButton setImage:backItemHlImage forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
        _backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
    }
    return _backItem;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]init];
        NSString*title = AXKitLocalizedString(@"ax.cancel");
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton setTitle:title forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:20];
        CGSize temp = [title ax_sizeWithaFont:_cancelButton.titleLabel.font];
        _cancelButton.frame = CGRectMake(20, 20, temp.width, temp.height);
        [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIBarButtonItem*)closeItem{
    if (!_closeItem) {
        _closeItem = [[UIBarButtonItem alloc] initWithTitle:AXKitLocalizedString(@"ax.close") style:UIBarButtonItemStylePlain target:self action:@selector(closeItemAction:)];
    }
    return _closeItem;
}

- (UIBarButtonItem *)cancelItem{
    if (!_cancelItem) {
        _cancelItem = [[UIBarButtonItem alloc]initWithCustomView:self.cancelButton];
    }
    return _cancelItem;
}

- (AXScriptMessageHandlerHelper *)handlerHelper {
    if (!_handlerHelper) {
        _handlerHelper = [AXScriptMessageHandlerHelper scriptMessageWithHandler:self];
    }
    return _handlerHelper;
}

- (NSMutableDictionary *)scriptMessageDict {
    if (!_scriptMessageDict) {
        _scriptMessageDict = [NSMutableDictionary dictionary];
    }
    return _scriptMessageDict;
}
- (NSMutableDictionary<NSString *,AXWebScriptMessageModel *> *)scriptMessageModelDict {
    if (!_scriptMessageModelDict) {
        _scriptMessageModelDict = [[NSMutableDictionary alloc]init];
    }
    return _scriptMessageModelDict;
}
#pragma mark - dealloc
- (void)dealloc{
    [self.webView.configuration.userContentController removeAllUserScripts];
    self.webView.scrollView.delegate = nil;
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(title))];
    axLong_dealloc;
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return UIInterfaceOrientationPortrait;
//}

@end


#pragma mark - 文档
/*
 
 typedef NS_ENUM(NSInteger, WKNavigationType) {
 WKNavigationTypeLinkActivated,//链接的href属性被用户激活。
 WKNavigationTypeFormSubmitted,//一个表单提交。
 WKNavigationTypeBackForward,//回到前面的条目列表请求。
 WKNavigationTypeReload,//网页加载。
 WKNavigationTypeFormResubmitted,//一个表单提交(例如通过前进,后退,或重新加载)。
 WKNavigationTypeOther = -1,//导航是发生一些其他原因。 } NS_ENUM_AVAILABLE(10_10, 8_0);
 
 
 typedef NS_ENUM(NSInteger, WKUserScriptInjectionTime) {
 WKUserScriptInjectionTimeAtDocumentStart,//注入后的脚本创建文档元素,但在其他任何内容已经被加载。
 WKUserScriptInjectionTimeAtDocumentEnd//注入脚本文档完成加载后,但在任何子资源可能完成加载。 } NS_ENUM_AVAILABLE(10_10, 8_0);
 
 typedef NS_ENUM(NSInteger, WKNavigationActionPolicy) {
 WKNavigationActionPolicyCancel,//取消导航
 WKNavigationActionPolicyAllow,//允许导航继续 } NS_ENUM_AVAILABLE(10_10, 8_0);
 
 
 
 // oc调用js方法
 NSString *jsStr = [NSString stringWithFormat:@"showAler('%@')",@"AB"];
 [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable data, NSError * _Nullable error) {
 NSLog(@"evaluateJavaScript>> %@  %@",data,error.localizedDescription);
 }];
 
 
 
 // 在JS中如果调用了bridge.send()，那么将触发OC端_bridge初始化方法中的回调。
 
 // 在JS中调用了bridge.callHandler('testJavascriptHandler')，它将触发OC端注册的同名方法
 
 在JS端：
 
 
 
 <script type="text/javascript">
 
 
 //这是必须要写的，用来初始化一些设置
 function setupWebViewJavascriptBridge(callback) {
 if (window.WebViewJavascriptBridge) { return callback(WebViewJavascriptBridge); }
 if (window.WVJBCallbacks) { return window.WVJBCallbacks.push(callback); }
 window.WVJBCallbacks = [callback];
 var WVJBIframe = document.createElement('iframe');
 WVJBIframe.style.display = 'none';
 WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
 document.documentElement.appendChild(WVJBIframe);
 setTimeout(function() { document.documentElement.removeChild(WVJBIframe) }, 0)
 }
 
 // xcode中的 oc代码
 //这也是固定的， OC 调JS ， 需要给OC调用的函数必须写在这个函数里面
 
 bridge.registerHandler('testJSFunction', function(data, responseCallback) {
 alert('JS方法被调用:'+data);
 responseCallback('js执行过了');
 })
 
 
 
 // h5 页面中的js代码  调oc 代码
 //这个 shareClick 就是 原生那边 注入的函数 ， 通过这个方法来调用原生 和传值
 //parmas 是JS 给OC的数据 ， response 是 OC函数被调用之后 再 告诉JS 我被调用了
 //比如微信分享，给Dic给原生 ， 原生分享成功后再把结果回调给JS 进行处理
 function shareClick() {
 
 var params = {'title':'测试分享的标题','content':'测试分享的内容','url':'http://www.baidu.com'};
 WebViewJavascriptBridge.callHandler('shareClick',params,function(response) {
 
 console.log(response);
 
 
 });
 }
 
 
 //
 // WebViewJavascriptBridge js 交互
 // */
//- (void)__initWebViewJavascriptBridge{
//
//    // 开启日志，方便调试
//    [WKWebViewJavascriptBridge enableLogging];
//    // 给哪个webview建立JS与OjbC的沟通桥梁
//    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
//    // 设置代理，如果不需要实现，可以不设置
//    // 如果控制器里需要监听WKWebView 的`navigationDelegate`方法，就需要添加下面这行。
//    [self.bridge setWebViewDelegate:self];
//
//    [self.bridge registerHandler:@"iosWeixinPay" handler:^(id data, WVJBResponseCallback responseCallback) {
//        //data  js 传来的参数
//        NSLog(@"data>> %@", data);
//
//        //        if (responseCallback) {
//        //            // 反馈给JS ,js 不需要反馈 就不需要写
//        //            responseCallback(@{@"userId": @"123456"});
//        //        }
//    }];
//
//    //    [self.bridge callHandler:@"function_name"data:@{} responseCallback:^(id responseData) {
//    //
//    //        NSLog(@"from js: %@", responseData);
//    //    }];
//
//}
