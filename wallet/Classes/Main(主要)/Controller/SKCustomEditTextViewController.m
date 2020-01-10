//
//  SKCustomEditTextViewController.m
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKCustomEditTextViewController.h"

@interface SKCustomEditTextViewController ()

@end

@implementation SKCustomEditTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
////
////  HLCustomEditTextViewController.m
////  welicome
////
////  Created by hualoha on 2017/10/2.
////  Copyright © 2017年 talking　. All rights reserved.
////
//
//#import "HLCustomEditTextViewController.h"
//
//
//#import "HLCustomPlaceHolderTextView.h"
//
//#import "HLCustomAlertView.h"
//
//
//#import "HLCustomInsetsLable.h"//内边距label 字体还有多少可输入
//
//#import "HLUserInfoPutRequest.h"//编辑个人信息
//
//#import "HLUserInfoModel.h"//个人信息
//#import "HLUserInfoManager.h"//个人信息管理
//#import "MJExtension.h"  //模型转化成字典 上传到网上
//
//
//
//@interface HLCustomEditTextViewController ()<HLCustomPlaceHolderTextViewDelegate>
//
////输入框
//@property (nonatomic, weak) HLCustomPlaceHolderTextView *placeHolderTextView;
//
//
//@property (nonatomic, weak) HLCustomInsetsLable *bottomLabel;
//
//
///** 用户基本信息*/
//@property (nonatomic, strong) HLUserInfoModel *userInfoModel;
//
//@end
//
//@implementation HLCustomEditTextViewController
//
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    if (self.placeHolderTextViewText.length) {
//
//        self.placeHolderTextView.text = self.placeHolderTextViewText;
//
//    }
//
//
//    if (self.placehoderText.length) {
//
//        self.placeHolderTextView.placehoder = self.placehoderText;
//
//    }
//
//    if (self.placeHeight) {
//
//
//        [self.placeHolderTextView setHeight:self.placeHeight];
//    }
//
//    if (self.placeY) {
//
//        [self.placeHolderTextView setY:self.placeY];
//    }
//
//
//    if (self.placeFontSize) {
//
//
//        self.placeHolderTextView.placeholderFont = HLFont(self.placeFontSize);
//
//    }
//
//
//    if (self.MaxInputLimitLength) {
//
//
//        if (self.placeHolderTextViewText.length) {
//
//            self.bottomLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.placeHolderTextViewText.length,self.MaxInputLimitLength];
//
//        }else {
//
//            self.bottomLabel.text = [NSString stringWithFormat:@"0/%ld",self.MaxInputLimitLength];
//
//        }
//
//
//    }
//
//
//
//
//    HLDefineWeakSelf;
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:NSLocalizedString(@"save", nil) tintColor:HLRedColor touchBlock:^{
//
//        [weakSelf saveInfoHandle];
//    }];
//
//
//
//
//}
//
//- (void)saveInfoHandle {
//
//
//    [self.placeHolderTextView resignFirstResponder];
//
//    if (self.placeHolderTextView.text.length == 0) {
//        HLCustomAlertView *alert = [[HLCustomAlertView alloc] initWithTitle:NSLocalizedString(@"hl_show_alert_content_not_empty", nil) cancel:nil sure:NSLocalizedString(@"hl_determine", nil)];
//        [alert showInView:self.view.window];
//        return ;
//    }
//
//    //可以在这做网络请求 把名字传给server   成功执行下面的  不成功 return
//
//    if ([self.navigationItem.title isEqualToString:NSLocalizedString(@"user_edit_nickname", nil)]) {
//
//        [self editNickNameHandle];
//    }
//
//
//
//}
//
//
////网络成功后调用这个函数  返回上一个界面
//- (void)popControllerHandle {
//
//    HLDefineWeakSelf;
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//
//        //    把文本值传给上个界面  上个界面操作刷新
//        if (weakSelf.NextViewControllerBlock) {
//            weakSelf.NextViewControllerBlock(weakSelf.placeHolderTextView.text);
//        }
//
//
//        [weakSelf pop];
//
//    });
//
//}
//
//
////向服务器请求编辑昵称
//- (void)editNickNameHandle {
//
//    HLUserInfoPutRequest *requset = [HLUserInfoPutRequest hl_request];
//    requset.hl_url = HLAPI_user_info_PUT_Url;
//    requset.hl_methodType = HLRequestMethodTypePUT;
//
//
//    self.userInfoModel = [[HLUserInfoManager sharedManager] currentUserInfo];
//
//    //把编辑的名字赋值给model
//    self.userInfoModel.nickname = self.placeHolderTextView.text;
//
//
//    //把模型转化成字典 上传到网上
//    NSMutableDictionary *diccc = self.userInfoModel.mj_keyValues; //复制一份字典
//    [diccc removeObjectForKey:@"XUserID"]; //把复制一份的字典删除不需要传的东西 然后传给服务器
//    [diccc removeObjectForKey:@"XToken"];
//
//
//    //传给服务器
//    requset.data = diccc;
//
//
//
//    HLDefineWeakSelf;
//    [requset hl_sendRequestWithCompletion:^(id response, BOOL success, NSString *message, NSString *code) {
//
//        if (success) {
//
//
//            // 重置用户信息 保存本地
//            [[HLUserInfoManager sharedManager] resetUserInfoWithUserInfo:weakSelf.userInfoModel];
//
//            [weakSelf popControllerHandle];
//
//            HLLog(@"我的新名字：%@",weakSelf.userInfoModel.nickname);
//
//
//
//            //            //单个人信息
//            NSDictionary *dict = (NSDictionary *)response;
//            HLLog(@"server返回的：%@ name:%@",dict,dict[@"nickname"]);
//
//            //            //    保存用户登录信息 个人基本信息
//            //
//            //            //全部的个人信息
//            //            NSMutableDictionary *userInfoDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
//            //            [userInfoDict addEntriesFromDictionary:useTokenDic];
//            //
//            //
//            //            //把全部的个人信息字典转成model
//            //            self.userInfoModel = [HLUserInfoModel modelWithDictionary:userInfoDict];
//            //
//            //
//            //            //拿到全部的信息model后 重置全部的信息
//            //            [[HLUserInfoManager sharedManager] resetUserInfoWithUserInfo:self.userInfoModel]; //重置本地更改的内容为最新
//            //
//            //            [weakSelf dismiss];
//
//
//
//        }
//
//    }];
//
//
//}
//
//
//#pragma mark - HLCustomPlaceHolderTextViewTextDidChange
//- (void)customPlaceHolderTextViewTextDidChange:(HLCustomPlaceHolderTextView *)textView {
//
//    NSString *text = textView.text;
//
//    if (text.length > self.MaxInputLimitLength) {
//
//        textView.text = [textView.text substringToIndex:self.MaxInputLimitLength];
//        self.bottomLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.MaxInputLimitLength,self.MaxInputLimitLength];
//
//
//    }else {
//
//        self.bottomLabel.text = [NSString stringWithFormat:@"%ld/%ld",text.length,self.MaxInputLimitLength];
//
//    }
//
//}
//
//- (HLCustomPlaceHolderTextView *)placeHolderTextView {
//
//    if (!_placeHolderTextView) {
//
//        HLCustomPlaceHolderTextView *palceHolderTextView = [[HLCustomPlaceHolderTextView alloc]init];
//        [self.view addSubview:palceHolderTextView];
//        _placeHolderTextView = palceHolderTextView;
//        palceHolderTextView.placeholderFont = HLFont(17);
//        palceHolderTextView.del = self;
//        palceHolderTextView.frame = CGRectMake(0, 10, HLScreenWidth, 100);
//
//    }
//    return _placeHolderTextView;
//}
//
//- (UILabel *)bottomLabel {
//
//    if (!_bottomLabel) {
//
//        HLCustomInsetsLable *label = [[HLCustomInsetsLable alloc]init];
//        [self.view addSubview:label];
//        _bottomLabel = label;
//
//        label.textAlignment = NSTextAlignmentRight;
//        label.font = HLFont(16);
//        label.frame = CGRectMake(0, self.placeHolderTextView.bottom, HLScreenWidth, 25);
//
//        label.textColor = [UIColor lightGrayColor];
//
//        label.backgroundColor = HLWhiteColor;
//
//        //        调整label 内边距
//        [label setInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
//
//    }
//    return _bottomLabel;
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
///*
// #pragma mark - Navigation
//
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
// }
// */
//
//@end

@end
