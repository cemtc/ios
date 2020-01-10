//
//  QYInviteCodeController.m
//  wallet
//
//  Created by talking　 on 2019/6/24.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "QYInviteCodeController.h"
#import "CFQLabelBgView.h"
#import "UIView+Layer.h"
#import "UIView+Tap.h"

@interface QYInviteCodeController ()
@property (nonatomic, strong) CFQLabelBgView * copLabel;
@property (nonatomic, strong) UILabel *codeStringL;

@property (nonatomic, strong) UIImageView *qrImageView;


@property (nonatomic, strong) CFQLabelBgView * leftLabel;
@property (nonatomic, strong) CFQLabelBgView * rightLabel;

@end

@implementation QYInviteCodeController
- (UIImageView *)qrImageView {
    if (!_qrImageView) {
        _qrImageView = [[UIImageView alloc]init];
    }
    return _qrImageView;
}

- (UILabel *)codeStringL {
    if (!_codeStringL) {
        _codeStringL = [[UILabel alloc]init];
        _codeStringL.font = SKFont(40);
        _codeStringL.textColor = SKColor(14, 20, 36, 1.0);
    }
    return _codeStringL;
}
- (CFQLabelBgView *)copLabel {
    if (!_copLabel) {
        _copLabel = [[CFQLabelBgView alloc]init];
        _copLabel.layerCornerRadius = 3;
        _copLabel.titleColor = SKWhiteColor;
        _copLabel.font = SKFont(22);
        _copLabel.bgColor = SKColor(198, 167, 113, 1.0);
        _copLabel.textAlignment = NSTextAlignmentCenter;
        _copLabel.title = @"Copy";
    }
    return _copLabel;
}
- (CFQLabelBgView *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[CFQLabelBgView alloc]init];
        _leftLabel.layerCornerRadius = 3;
        _leftLabel.titleColor = SKWhiteColor;
        _leftLabel.font = SKFont(12);
        _leftLabel.bgColor = SKColor(198, 167, 113, 1.0);
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.title = @"分享下载链接";
    }
    return _leftLabel;
}
- (CFQLabelBgView *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[CFQLabelBgView alloc]init];
        _rightLabel.layerCornerRadius = 3;
        _rightLabel.titleColor = SKWhiteColor;
        _rightLabel.font = SKFont(12);
        _rightLabel.bgColor = SKColor(198, 167, 113, 1.0);
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.title = @"分享邀请海报";
    }
    return _rightLabel;
}


//////如果不要导航把这个打开
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView setAnimationsEnabled:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self setUpItems];
    
    // 设置子视图
    [self setUpViews];
}
// 设置导航栏
- (void)setUpItems {
    
    self.navigationItem.title = @"我的邀请码";
}

// 设置子视图
- (void)setUpViews {
    
    self.view.backgroundColor = SKBlackColor;
    
    UIImageView *bgView = [[UIImageView alloc]initWithImage:SKImageNamed(@"background_invitation")];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"邀请码";
    title.textColor = SKWhiteColor;
    title.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:title];
    
    
    CGFloat _originHeight = 0;
    if (SKIsIphoneX) {
        _originHeight = 64;
    }else {
        _originHeight = 44;
    }

    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(_originHeight);
    }];
    
    
    //创建返回的button
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"reurnGenal"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"reurnGenal"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(backItemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 0);
    
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(title.mas_centerY);
        make.left.mas_equalTo(25);
    }];
    
    
    UIImageView *contentImageView = [[UIImageView alloc]initWithImage:SKImageNamed(@"invitation_background")];
    [self.view addSubview:contentImageView];
    [contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    
    
    UILabel *contentTitle = [[UILabel alloc]init];
    contentTitle.text = @"我的邀请码";
    contentTitle.font = [UIFont systemFontOfSize:19];
    contentTitle.textColor = SKColor(14, 20, 36, 1.0);
    [self.view addSubview:contentTitle];
    [contentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(contentImageView.mas_top).offset(30);
    }];
    
    
    [self.view addSubview:self.copLabel];
    [self.copLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(36);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.view.mas_centerY).offset(-40);
    }];
    
    SKDefineWeakSelf;
    [self.copLabel setTapActionWithBlock:^{
        [weakSelf copLabelCilck];
    }];
    
    
    [self.view addSubview:self.codeStringL];
    [self.codeStringL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.copLabel.mas_top).offset(-40);
    }];
    
    self.codeStringL.text = [NSString stringWithFormat:@"%@",[SKUserInfoManager sharedManager].currentUserInfo.myCode];
    
    
    
    //bottom label
    UILabel *bottomLabel = [[UILabel alloc]init];
    bottomLabel.text = @"长按保存图片";
    bottomLabel.font = SKFont(13);
    [self.view addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(contentImageView.mas_bottom).offset(-20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    //line
    UILabel *leftLineLabel = [[UILabel alloc]init];
    leftLineLabel.backgroundColor = [UIColor colorWithHexString:@"#979797"];
    [self.view addSubview:leftLineLabel];
    [leftLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomLabel.mas_centerY);
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(bottomLabel.mas_left).offset(-20);
        make.width.mas_equalTo(50);
    }];
    UILabel *rightLineLabel = [[UILabel alloc]init];
    rightLineLabel.backgroundColor = [UIColor colorWithHexString:@"#979797"];
    [self.view addSubview:rightLineLabel];
    [rightLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomLabel.mas_centerY);
        make.height.mas_equalTo(1);
        make.left.mas_equalTo(bottomLabel.mas_right).offset(20);
        make.width.mas_equalTo(50);
    }];
    
    
    //二维码
    [self.view addSubview:self.qrImageView];
    [self.qrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(125);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(bottomLabel.mas_top).offset(-40);
    }];
    
    CFQtestSwift *a = [[CFQtestSwift alloc]init];
    //内容 就是 aaa
    self.qrImageView.image = [a erweimaWithAddress:[NSString stringWithFormat:@"%@",[SKUserInfoManager sharedManager].currentUserInfo.myCode]];
    
    NSLog(@"%@",[SKUserInfoManager sharedManager].currentUserInfo.token);
    NSLog(@"%@",[SKUserInfoManager sharedManager].currentUserInfo.customerId);
    NSLog(@"%@",[SKUserInfoManager sharedManager].currentUserInfo.mobile);
    NSLog(@"%@",[SKUserInfoManager sharedManager].currentUserInfo.indexString);

    NSLog(@"%@",[SKUserInfoManager sharedManager].currentUserInfo.myCode);

    
    //长按截图
    // 长按
    //图片允许交互,别忘记设置,否则手势没有反应
    [self.view setUserInteractionEnabled:YES];
    
    //初始化一个长按手势
    UILongPressGestureRecognizer *longPressGest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressView:)];
    
    //长按等待时间
    longPressGest.minimumPressDuration = 1;
    
    //长按时候,手指头可以移动的距离
    longPressGest.allowableMovement = 30;
    [self.view addGestureRecognizer:longPressGest];
    
    
    
    
    [self.view addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(leftLineLabel.mas_left).mas_equalTo(25);
        make.bottom.mas_equalTo(leftLineLabel.mas_top).offset(-10);
    }];
    
    
    [self.view addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.leftLabel.mas_centerY);
        make.centerX.mas_equalTo(rightLineLabel.mas_right).mas_equalTo(-25);

    }];

    [self.leftLabel setTapActionWithBlock:^{

        [UIPasteboard generalPasteboard].string = @"https://w-token.online/downloads/wToken.html";
        [MBProgressHUD showMessage:@"Copy success"];
        
    }];
    [self.rightLabel setTapActionWithBlock:^{
        UIImageWriteToSavedPhotosAlbum([SKUtils convertViewToImage:weakSelf.view], weakSelf, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];

}
-(void)longPressView:(UILongPressGestureRecognizer *)longPressGest{
    
    NSLog(@"%ld",longPressGest.state);
    if (longPressGest.state==UIGestureRecognizerStateBegan) {
        
        NSLog(@"长按手势开启");
        //参数1:图片对象
        //参数2:成功方法绑定的target
        //参数3:成功后调用方法
        //参数4:需要传递信息(成功后调用方法的参数)
        UIImageWriteToSavedPhotosAlbum([SKUtils convertViewToImage:self.view], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        
    } else {
        NSLog(@"长按手势结束");
    }
    
}
- (void)copLabelCilck{
    
    [UIPasteboard generalPasteboard].string = self.codeStringL.text;
    [MBProgressHUD showMessage:@"Copy"];
}
- (void)backItemButtonClick:(UIButton *)button {
    [self pop];
}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [MBProgressHUD showMessage:msg toView:nil];
}


@end
