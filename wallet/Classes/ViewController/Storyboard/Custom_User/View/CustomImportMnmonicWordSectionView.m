//
//  CustomImportMnmonicWordSectionView.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomImportMnmonicWordSectionView.h"

@interface CustomImportMnmonicWordSectionView ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation CustomImportMnmonicWordSectionView
- (IBAction)importClick:(UIButton *)sender {
    NSLog(@"导入");
    if (self.buttonClickBlock) {
        self.buttonClickBlock();
    }
}

- (void)awakeFromNib  {
    [super awakeFromNib];
    self.textView.placeholder = @"Enter mnemonics separated by spaces";
    [[self.textView rac_textSignal]subscribeNext:^(NSString * _Nullable x) {
        if (self.textViewBlock) {
            self.textViewBlock(x);
        }
    }];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0,0);
    gradient.endPoint = CGPointMake(1,0);
    gradient.frame = self.button.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"#0692C2"].CGColor,(id)[UIColor colorWithHexString:@"#1186CE"].CGColor,nil];
    [self.button.layer insertSublayer:gradient atIndex:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
