//
//  QYAboutUsController.m
//  wallet
//
//  Created by talking　 on 2019/6/27.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYAboutUsController.h"

@interface QYAboutUsController ()

@property (nonatomic, strong)UIWebView *web;
@end

@implementation QYAboutUsController

- (UIWebView *)web{
    if (!_web) {
        _web = [[UIWebView alloc]init];
    }
    return _web;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = SKWhiteColor;

    [self.view addSubview:self.web];
    [self.web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];

    SKDefineWeakSelf;
    NSMutableDictionary *d = [NSMutableDictionary new];
    [d setValue:self.indexString forKey:@"systemType"];
    NSDictionary * input = d.copy;
    [CFQCommonServer cfqServerGetSystemHelpByTypeWithInput:input callback:^(id  _Nonnull response, BOOL success, NSString * _Nonnull message, NSString * _Nonnull code) {

        if (success) {
            NSDictionary *dict = (NSDictionary *)response;
            CFQCommonModel *model = [CFQCommonModel modelWithDictionary:dict];
            [weakSelf.web loadHTMLString:model.content baseURL:nil];
        }else {
        }
    }];

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
