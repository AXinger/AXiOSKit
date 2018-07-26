//
//  AXWebVC.m
//  AXiOSTools
//
//  Created by liuweixing on 16/8/15.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXWebVC.h"
//#import "NJKWebViewProgressView.h"
//#import "NJKWebViewProgress.h"
#import "AXToolsHeader.h"
@interface AXWebVC ()
//    <UIWebViewDelegate,NJKWebViewProgressDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;

//@property (nonatomic, strong) NJKWebViewProgressView *progressView;
//@property (nonatomic, strong) NJKWebViewProgress *progressProxy;

@end

@implementation AXWebVC
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    [self setupProgress];
//    [self setupBack];
//
//    [self.webView setMediaPlaybackRequiresUserAction:NO];
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//
//    
//    
//}
//- (void)setupProgress{
//    self.progressProxy = [[NJKWebViewProgress alloc] init];
//    self.webView.delegate = self.progressProxy;
//    self.progressProxy.webViewProxyDelegate = self;
//    self.progressProxy.progressDelegate = self;
//    
//    CGFloat progressBarHeight = 2.f;
//    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
//    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
//    self.progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
//    self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
//    
//    
//    
//    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
//    [self.webView loadRequest:req];
//
//}
//
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar addSubview:self.progressView];
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.progressView removeFromSuperview];
//}
//
//- (void)setupBack{
//    
//    if (!self.navigationController) {
//        
//        UIButton *button = [self setupBackBtn];
//        [self.webView.scrollView addSubview:button];
//        
//    }else if ([self.navigationController.viewControllers.firstObject isEqual: self]){
//        
//        UIButton *button = [self setupBackBtn];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
//    }
//    
//    if (self.navigationController) {
//        UIBarButtonItem *roadLoad = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(roadLoadClicked)];
//        self.navigationItem.rightBarButtonItem = roadLoad;
//    }
//}
//- (void)roadLoadClicked{
//    [self.webView reload];
//}
//- (UIButton *)setupBackBtn{
//    UIButton *button = [[UIButton alloc]init];
//    NSString*title = AXToolsLocalizedString(@"ax.cancel");
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button setTitle:title forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:20];
//    CGSize temp = [title ax_sizeWithaFont:button.titleLabel.font];
//    button.frame = CGRectMake(20, 20, temp.width, temp.height);
//    [button addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
//    
//    return button;
//    
//}
//
//#pragma mark - NJKWebViewProgressDelegate
//- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
//    [self.progressView setProgress:progress animated:YES];
//    
//}
//
//
//
//- (void)leftBarButtonItemEvnets:(UIBarButtonItem *)item{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//- (void)buttonEvents:(UIButton *)button{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
////    NSString *url = request.URL.absoluteString;
////
////    AXLog(@"url:  %@",url);
//    
//    
//    return YES;
//}

@end
