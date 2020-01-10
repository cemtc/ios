//
//  MWShowPickerView.m
//  mishuwork
//
//  Created by iMac on 2018/10/18.
//  Copyright © 2018 iMac. All rights reserved.
//

#import "MWShowPickerView.h"

#define  kShowPickerViewTag 10023826

@interface MWShowPickerView()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView * backgroundView;

@property (nonatomic, strong) UIView * contentView;

@property (nonatomic, strong) UILabel * titleLB;

@property (nonatomic, strong) UIButton * agreeBtn;

@property (nonatomic, strong) UIPickerView * pickerView;

@property (nonatomic, copy)   NSArray * dataArr;

@property (nonatomic, assign)  NSInteger index;

@property (nonatomic, copy)    void(^callback)(NSString *string);

@end
@implementation MWShowPickerView

- (instancetype)initWithFrame:(CGRect)frame dataArr:(NSArray *)dataArr select:(NSString *)select{
	if(self = [super initWithFrame:frame]){
		self.backgroundView = [UIView new];
		self.contentView    = [UIView new];
		self.pickerView     = [UIPickerView new];
		self.titleLB        = [UILabel new];
		self.agreeBtn       = [UIButton new];
		
		self.dataArr = dataArr;
		self.index = [dataArr indexOfObject:select] ;
		self.index = self.index == NSNotFound ? 0 : self.index;
		
		_pickerView.dataSource = self;
		_pickerView.delegate = self;
		[self.agreeBtn setTitleColor:SKColor(252, 50, 50, 1) forState:UIControlStateNormal];
		[self.agreeBtn setTitle:@"确定" forState:UIControlStateNormal];
		self.agreeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
		self.titleLB.font = [UIFont systemFontOfSize:15];
		self.titleLB.text = @"选择原因";
		self.backgroundView .backgroundColor = SKColor(0, 0, 0, 0);
		self.contentView.backgroundColor = [UIColor whiteColor];
		[self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)]];

		[self addSubview:self.backgroundView];
		[self addSubview:self.contentView];
		[self.contentView addSubview:self.pickerView];
		[self.contentView addSubview:self.titleLB];
		[self.contentView addSubview:self.agreeBtn];
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self resetPickerSelectRow];
		});
		@weakify(self);
		[[[self.agreeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] throttle:0.2] subscribeNext:^(__kindof UIControl * _Nullable x) {
			@strongify(self);
			if (self.callback) {
				self.callback(self.dataArr[self.index]);
			}
			[self dissmiss];
		}];
		[self setupLayout];
		
	}
	return self;
}
-(void)resetPickerSelectRow
{
	[self.pickerView selectRow:_index inComponent:0 animated:YES];
}
- (void)setupLayout{
	[self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.top.bottom.equalTo(self);
	}];
	[self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.equalTo(self);
		make.bottom.equalTo(self.mas_bottom);
	}];
	[self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(self.contentView.mas_centerX);
		make.centerY.equalTo(self.agreeBtn.mas_centerY);
	}];
	[self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.equalTo(self.contentView.mas_right).offset(-10);
		make.top.equalTo(self.contentView.mas_top).offset(15);
		make.width.mas_equalTo(45.f);
	}];
	[self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.agreeBtn.mas_bottom).offset(15);
		make.left.bottom.right.equalTo(self.contentView);
		make.height.equalTo(@216);
	}];
	[_pickerView layoutIfNeeded];
	[self.backgroundView layoutIfNeeded];
}
#pragma mark -- UIPickerViewDataSource, UIPickerViewDelegate
// 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
// 每列有多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return self.dataArr.count;
}
// 返回每一行的内容
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
	UILabel *label;
	if (view) {
		label = (UILabel *)view;
	}else{
		label = [[UILabel alloc] init];
		label.font = [UIFont systemFontOfSize:15];
		label.textAlignment = NSTextAlignmentCenter;
		label.textColor = SKColor(52, 52, 52, 1);
	}
	label.text = self.dataArr[row];
	return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	_index = row;
}
- (void)cancelAction
{
	[self dissmiss];
}
#pragma mark -- dissmiss
- (void)dissmiss{
	[UIView animateWithDuration:0.3 animations:^{
		self.backgroundView.backgroundColor = SKColor(0, 0, 0, 0.f);
		self.contentView.transform = CGAffineTransformMakeTranslation(0,self.backgroundView.frame.size.height);
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
	}];
}

+ (instancetype)showWithDataArr:(NSArray *)dataArr title:(NSString *)title select:(NSString *)select callback:(void(^)(NSString *string))callback{
	MWShowPickerView * view = [[[UIApplication sharedApplication].delegate window] viewWithTag:kShowPickerViewTag];
	if (!view) {
		view = [[MWShowPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds dataArr:dataArr select:select];
		view.tag = kShowPickerViewTag;
		[[[UIApplication sharedApplication].delegate window] addSubview:view];
	}
	view.callback = callback;
	[view.contentView layoutIfNeeded];
	view.contentView.transform = CGAffineTransformMakeTranslation(0,view.contentView.frame.size.height);
	view.contentView.hidden = NO;
	if (title.length > 0) {
		view.titleLB.text = title;
	}
	[UIView animateWithDuration:0.3 animations:^{
		view.contentView.alpha = 1.f;
		view.backgroundView.backgroundColor = SKColor(0, 0, 0, 0.5);
		view.contentView.transform = CGAffineTransformIdentity;
	}];
	return view;
}
+ (instancetype)showWithDataArr:(NSArray *)dataArr select:(NSString *)select callback:(void(^)(NSString *string))callback
{
	return [self showWithDataArr:dataArr title:@"" select:select callback:callback];
}
@end
