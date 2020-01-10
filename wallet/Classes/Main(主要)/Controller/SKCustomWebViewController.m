//
//  SKCustomWebViewController.m
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKCustomWebViewController.h"
#import <WebKit/WebKit.h>

@interface SKCustomWebViewController ()<WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, copy) NSString *url;

@end

@implementation SKCustomWebViewController


- (instancetype)initWithUrl:(NSString *)url {
    if (self = [super init]) {
        self.url = url;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.navigationItem.title isEqualToString:@"发现"]) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showLoadingAnimation];
    [self leftBarButtomItemWithNormalName:@"icon_return_black" highName:@"icon_return_black" selector:@selector(BackClick) target:self];
    if ([self.navigationItem.title isEqualToString:@"用户协议"]) {
        [self leftBarButtomItemWithNormalName:@"icon_return_black" highName:@"icon_return_black" selector:@selector(back) target:self];
    }
    
//    if ([self.navigationItem.title isEqualToString:NSLocalizedString(@"directions", nil)]) {
//
//        NSString *htmlPath = self.url;
//        NSURL *url = [NSURL fileURLWithPath:htmlPath];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [self.webView loadRequest:request];
//
//    }else {

    if ([self.url containsString:@".txt"]) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        NSURLResponse *response = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
        [self.webView loadData:data MIMEType:response.MIMEType characterEncodingName:@"GBK" baseURL:nil];
    }else{
//        NSURL *URL = [NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURL *URL = [NSURL URLWithString:self.url];
        [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];
    }
    
        
//        NSURL *URL = [NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];

//    }
    
    
}
-(void)BackClick{
 [self.navigationController popViewControllerAnimated:YES];
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SKScreenWidth, SKScreenHeight - 64)];
        [self.view addSubview:wkWebView];
        _webView = wkWebView;
        wkWebView.UIDelegate = self;
        wkWebView.navigationDelegate = self;
        wkWebView.opaque = NO;
        wkWebView.backgroundColor = self.view.backgroundColor;
    }
    return _webView;
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
        [self hideLoadingAnimation];
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    // 允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    // 允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)pop {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        } else  {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
