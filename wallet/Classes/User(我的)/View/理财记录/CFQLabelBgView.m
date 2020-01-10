//
//  CFQLabelBgView.m
//  mishuwork
//
//  Created by iMac on 2019/3/21.
//  Copyright © 2019 iMac. All rights reserved.
//

#import "CFQLabelBgView.h"

@interface CFQLabelBgView ()
@property (nonatomic, strong) UILabel * statusLB;//状态

@end

@implementation CFQLabelBgView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		[self customUI];
	}
	return self;
}
- (void)customUI {
	
	//状态
	[self.statusLB mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.mas_left).offset(5);
		make.right.mas_equalTo(self.mas_right).offset(-5);
		make.top.mas_equalTo(self.mas_top).offset(1);
		make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
	}];
	
}
- (UILabel *)statusLB {
	if (!_statusLB) {
		_statusLB = [[UILabel alloc]init];
		[self addSubview:_statusLB];
	}
	return _statusLB;
}

-(void)setTitle:(NSString *)title {
	_title = title;
	self.statusLB.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
	_titleColor = titleColor;
	self.statusLB.textColor = titleColor;
}

- (void)setBgColor:(UIColor *)bgColor {
	_bgColor = bgColor;
	self.backgroundColor = bgColor;
}
- (void)setFont:(UIFont *)font {
	_font = font;
	self.statusLB.font = font;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
	_textAlignment = textAlignment;
	self.statusLB.textAlignment = textAlignment;
}
@end
