//
//  CustomMineSectionView.m
//  wallet
//
//  Created by 曾云 on 2019/8/17.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomMineSectionView.h"

@interface CustomMineSectionView ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CustomMineSectionView

- (void)setSectionModel:(CustomMineSectionModel *)sectionModel {
    _sectionModel = sectionModel;
    if (_sectionModel) {
        self.title.text = _sectionModel.title;
        self.imageView.image = [UIImage imageNamed:_sectionModel.imgName];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
