//
//  SKCustomSegmentView.m
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKCustomSegmentView.h"
#import "UIView+Layer.h"

@interface SKCustomSegmentView ()

@end

@implementation SKCustomSegmentView{
    NSArray *_itemTitles;
    UIButton *_selectedBtn;
}
- (instancetype)initWithItemTitles:(NSArray *)itemTitles {
    if (self = [super init]) {
        _itemTitles = itemTitles;
        
        
        
        self.layerCornerRadius = 3.0;
        self.layerBorderColor = SKColor(198, 167, 113, 1.0);
        self.layerBorderWidth = 1.0;
        
        [self setUpViews];
    }
    return self;
}

- (void)clickDefault {
    if (_itemTitles.count == 0) {
        return ;
    }
    [self btnClick:(UIButton *)[self viewWithTag:1]];
}

- (void)setUpViews {
    
    if (_itemTitles.count > 0) {
        NSInteger i = 0;
        for (id obj in _itemTitles) {
            if ([obj isKindOfClass:[NSString class]]) {
                NSString *objStr = (NSString *)obj;
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [self addSubview:btn];
                btn.backgroundColor = SKClearColor;
                [btn setTitle:objStr forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//                [btn setTitleColor:SKColor(198, 167, 113, 1.0) forState:UIControlStateNormal];
                [btn setTitleColor:SKColor(88, 89, 98, 1.0) forState:UIControlStateNormal];

                btn.titleLabel.font = SKFont(16);
                i = i + 1;
                btn.tag = i;
                
                
                
                if (btn.tag == 2) {
                    btn.layerBorderWidth = 1.0;
                    btn.layerBorderColor = SKColor(198, 167, 113, 1.0);
                }
                
                
                
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.adjustsImageWhenDisabled = NO;
                btn.adjustsImageWhenHighlighted = NO;
            }
        }
    }
}

- (void)btnClick:(UIButton *)btn {
    
    
    _selectedBtn.backgroundColor = SKClearColor;
    btn.backgroundColor = SKColor(198, 167, 113, 1.0);
    
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    NSString *title = btn.currentTitle;
    if (self.SKCustomSegmentViewBtnClickHandle) {
        self.SKCustomSegmentViewBtnClickHandle(self, title, btn.tag - 1);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_itemTitles.count > 0) {
        CGFloat btnW = self.width / _itemTitles.count;
        for (int i = 0 ; i < _itemTitles.count; i++) {
            UIButton *btn = (UIButton *)[self viewWithTag:i + 1];
            btn.frame = CGRectMake(btnW * i, 0, btnW, self.height);
        }
    }
}




@end
