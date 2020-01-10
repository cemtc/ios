//
//  CustomCreateIdentitySectionView.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomCreateIdentitySectionView.h"

@interface CustomCreateIdentitySectionView ()
@property (weak, nonatomic) IBOutlet UIButton *createButton;

@end

@implementation CustomCreateIdentitySectionView
- (IBAction)create:(UIButton *)sender {
    if (self.buttonClickBlock) {
        self.buttonClickBlock();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0,0);
    gradient.endPoint = CGPointMake(1,0);
    gradient.frame = self.createButton.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"#0692C2"].CGColor,(id)[UIColor colorWithHexString:@"#1186CE"].CGColor,nil];
    [self.createButton.layer insertSublayer:gradient atIndex:0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
