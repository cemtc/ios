//
//  XYPayPwdInputView.m
//  xiangyue
//
//  Created by Shendou on 15/9/29.
//  Copyright (c) 2015年 shendou. All rights reserved.
//

#import "MSPayPwdInputView.h"
#define NUMBERS @"0123456789\n"
#define kPayPwdInputView 1010102229
@interface MSPayPwdInputView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLB;

@property (nonatomic, copy) void(^callback)(NSString *pwd);

@property (nonatomic, copy) void(^closeBlock)(void);

@property (weak, nonatomic) IBOutlet UILabel *moneyLB;

@end

@implementation MSPayPwdInputView

-(void)awakeFromNib
{
	[super awakeFromNib];
	self.backgroundColor = SKColor(0, 0, 0, 0.5);
	[self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
	_upConstraint.constant = (SKScreenHeight - 100 - 216)/2;
	_inputPayPwdTF.layer.borderWidth = 1.0;
	_inputPayPwdTF.layer.borderColor = SKColor(245, 245, 245, 1).CGColor;
	_alInView.layer.cornerRadius = 5.0;
	_alInView.layer.masksToBounds = YES;
	_inputPayPwdTF.secureTextEntry = YES;
	_inputPayPwdTF.hidden = YES;
	[_closeBtn addTarget:self action:@selector(tapAct) forControlEvents:UIControlEventTouchUpInside];
	_inputPayPwdTF.keyboardType = UIKeyboardTypeNumberPad;
	_inputPayPwdTF.delegate = self;
	[_inputPayPwdTF addTarget:self action:@selector(tfTextChange) forControlEvents:UIControlEventEditingChanged];
	_allBtnOnView.layer.cornerRadius = 2.5;
	_allBtnOnView.layer.borderWidth = 0.5;
	_allBtnOnView.layer.borderColor = [UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0].CGColor;
	_allBtnOnView.backgroundColor = [UIColor whiteColor];
	
	for (int i = 1; i <= 5; i++) {
		UIView * devide = [[UIView alloc]init];
		devide.backgroundColor = [UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1.0];
		devide.frame = CGRectMake(i*40.0, 0, 0.5, 40);
		[_allBtnOnView addSubview:devide];
	}
}

-(void)btnPress
{
	if (self.callback) {
		self.callback(_inputPayPwdTF.text);
	}
	[self removeFromSuperview];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
	 CGPoint point = [tap locationInView:self];
	if (CGRectContainsPoint(self.alInView.frame, point)) {
		return;
	}
	[self dismiss];
}

-(void)tapAct
{
	[self dismiss];
}
- (void)dismiss{
	if (self.closeBlock) {
		self.closeBlock();
	}
	[self removeFromSuperview];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	return [self filterNumTFWithRange:range string:string];
}

-(void)tfTextChange
{
	NSInteger length = _inputPayPwdTF.text.length;
	for (int i = 1 ; i <= 6; i++) {
		UIButton * btn = (UIButton *)[_allBtnOnView viewWithTag:i+10];
		if (i <= length) {
			[btn setTitle:@"●" forState:UIControlStateNormal];
		}else{
			[btn setTitle:@"" forState:UIControlStateNormal];
		}
	}
	if (length == 6) {
		[self btnPress];
	}
}

-(BOOL)filterNumTFWithRange:(NSRange)range string:(NSString *)string
{
	if ([string length]>0){
		
		if (_inputPayPwdTF.text.length >= 6) {
			return NO;
		}
		NSCharacterSet *cs;
		cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
		NSString * filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		BOOL basicTest = [string isEqualToString:filtered];
		if(!basicTest){
			return NO;
		}
		return YES;
	}else{
		return YES;
	}
}


+ (instancetype)showPwdInputWithTitle:(NSString *)title money:(CGFloat)money closeBlock:(void(^)(void))closeBlock callBack:(void(^)(NSString *pwd))callback
{
	MSPayPwdInputView * view = [[[UIApplication sharedApplication].delegate window] viewWithTag:kPayPwdInputView];
	if (view) {
		return view;
	}
	view = [[NSBundle mainBundle] loadNibNamed:@"MSPayPwdInputView" owner:nil options:nil].lastObject;
	view.tag = kPayPwdInputView;
	view.frame = [UIScreen mainScreen].bounds;
	view.callback = callback;
    NSString * moneyStr = [NSString stringWithFormat:@"¥%@",money];
    NSMutableAttributedString * att_str = [[NSMutableAttributedString alloc] initWithString:moneyStr];
    [att_str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.f] range:[moneyStr rangeOfString:@"¥"]];
    view.moneyLB.attributedText = [att_str copy];
    //caofuqing
    view.moneyLB.hidden = YES;
    //caofuqing end
	if (title.length != 0) {
		view.titleLB.text = title;
	}
	view.closeBlock = closeBlock;
	[view.inputPayPwdTF becomeFirstResponder];
	[[[UIApplication sharedApplication].delegate window] addSubview:view];
	return view;
}

- (void)dealloc
{
     NSLog(@"%s", __func__);
}

@end
