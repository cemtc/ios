//
//  SKCustomLoadingAnimationView.m
//  Business
//
//  Created by talking　 on 2018/8/14.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import "SKCustomLoadingAnimationView.h"

@interface SKCustomLoadingAnimationView ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation SKCustomLoadingAnimationView

-(instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = SKWhiteColor;
    }
    return self;
}

-(void)showInView:(UIView *)view {
    
    if (view == nil) {
        
        view = [UIApplication sharedApplication].keyWindow;
    }
    [view addSubview:self];
    
    self.frame = view.bounds;
    self.imageView.frame = CGRectMake(0, 0, 100, 100);
    //    self.imageView.center = self.center;
    self.imageView.centerX = self.centerX;
    self.imageView.centerY = self.centerY - 100;
    [self.imageView startAnimating];
    
}

- (void)dismiss {
    [_imageArray removeAllObjects];
    [_imageView stopAnimating];
    [_imageView removeFromSuperview];
    [self removeFromSuperview];
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray new];
    }
    return _imageArray;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *img = [[UIImageView alloc] init];
        [self addSubview:img];
        _imageView = img;
        
        for (NSInteger i = 0; i < 8; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refreshjoke_loading_%ld", i % 8]];
            [self.imageArray addObject:image];
        }
        self.imageView.animationDuration = 1.0;
        self.imageView.animationRepeatCount = 0;
        self.imageView.animationImages = self.imageArray;
    }
    return _imageView;
}


@end
