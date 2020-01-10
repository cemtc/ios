//
//  ImportMnemonicAndPrivite.m
//  wallet
//
//  Created by talking　 on 2019/6/25.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "ImportMnemonicAndPrivite.h"
#import "UITextField+HLLeftView.h"//快速创建textfile


#import "CFQLabelBgView.h"
#import "UIView+Layer.h"
#import "UIView+Tap.h"


@interface ImportMnemonicAndPrivite ()

@property (nonatomic, strong) UITextField *textfield;

@property (nonatomic, strong) CFQLabelBgView * sureLabel;

@property (nonatomic, strong) CFQLabelBgView * sureLabel1;

@end

@implementation ImportMnemonicAndPrivite

- (CFQLabelBgView *)sureLabel {
    if (!_sureLabel) {
        _sureLabel = [[CFQLabelBgView alloc]init];
        _sureLabel.layerCornerRadius = 3;
        _sureLabel.titleColor = SKWhiteColor;
        _sureLabel.font = SKFont(13);
        _sureLabel.bgColor = SKColor(85, 99, 162, 1.0);
        _sureLabel.textAlignment = NSTextAlignmentCenter;
        _sureLabel.title = @"导入私钥";
    }
    return _sureLabel;
}
- (CFQLabelBgView *)sureLabel1 {
    if (!_sureLabel1) {
        _sureLabel1 = [[CFQLabelBgView alloc]init];
        _sureLabel1.layerCornerRadius = 3;
        _sureLabel1.titleColor = SKWhiteColor;
        _sureLabel1.font = SKFont(13);
        _sureLabel1.bgColor = SKColor(216, 65, 68, 1.0);
        _sureLabel1.textAlignment = NSTextAlignmentCenter;
        _sureLabel1.title = @"重置";
    }
    return _sureLabel1;
}



//////如果不要导航把这个打开
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView setAnimationsEnabled:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = QYThemeColor;
    
    // 设置导航栏
    [self setUpItems];
    
    // 设置子视图
    [self setUpViews];

    
}

// 设置导航栏
- (void)setUpItems {
    
    self.navigationItem.title = @"导入私钥";
    
}

// 设置子视图
- (void)setUpViews {
    
    self.view.backgroundColor = SKBlackColor;
    
    UIImageView *bgView = [[UIImageView alloc]initWithImage:SKImageNamed(@"login backgrounds")];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

    UILabel *title = [[UILabel alloc]init];
    title.text = [NSString stringWithFormat:@"导入%@私钥",self.titleString];
    title.textColor = SKWhiteColor;
    title.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(60);
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
    
    
    
    UILabel *contitle = [[UILabel alloc]init];
    contitle.text = [NSString stringWithFormat:@"请输入%@私钥内容至输入框",self.titleString];
    contitle.textColor = SKWhiteColor;
    contitle.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:contitle];
    [contitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(title.mas_top).offset(100);
    }];

    
    self.textfield = [UITextField textFieldWithPlaceholder:@"" leftIconImage:nil height:SKAppAdapter(44) leftViewWith:35];
    [self.view addSubview:self.textfield];
    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contitle.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view.mas_left).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(100);
    }];
    self.textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textfield.backgroundColor = SKColor(56, 63, 102, 1.0);
    self.textfield.textColor = SKWhiteColor;
    self.textfield.font = SKFont(12);
    


    [self.view addSubview:self.sureLabel];
    [self.sureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(self.textfield.mas_bottom).offset(100);
        make.left.mas_equalTo(self.textfield.mas_left).offset(20);
    }];
    
    SKDefineWeakSelf;
    [self.sureLabel setTapActionWithBlock:^{
        [weakSelf sureLabelCilck];
    }];
    
    
    [self.view addSubview:self.sureLabel1];
    [self.sureLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(self.sureLabel.mas_centerY);
        make.right.mas_equalTo(self.textfield.mas_right).offset(-20);
    }];
    
    [self.sureLabel1 setTapActionWithBlock:^{

        weakSelf.textfield.text = @"";
    }];


}
//确认导入
- (void)sureLabelCilck{
    
    if (self.textfield.text.length <= 0) {

//        [MBProgressHUD showError:@"私钥不能为空" toView:nil];
        [MBProgressHUD showMessage:@"私钥不能为空"];
        return;
    }
    
    //传给上个界面
    if (self.NextViewControllerBlock) {
        self.NextViewControllerBlock(self.textfield.text,self.titleString);
    }
    
    [self pop];
    
}

- (void)backItemButtonClick:(UIButton *)button {
    [self pop];
}


@end
