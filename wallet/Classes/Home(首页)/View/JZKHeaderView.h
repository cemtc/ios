//
//  JZKHeaderView.h
//  封装一个好的头视图吧
//
//  Created by 张全成 on 16/1/20.
//  Copyright © 2016年 贾振凯. All rights reserved.
//

#import <UIKit/UIKit.h>

//定义一个结构体，用于传输按钮点击的index
typedef void(^HeadViewBlock)(NSInteger index);


@interface JZKHeaderView : UIView

//点击头视图的图片时调用的block
@property (nonatomic, copy) HeadViewBlock headViewBlock;
//传过来得图片
@property (nonatomic, strong) NSMutableArray *imageArr;
//传过来的标题
@property (nonatomic, strong) NSMutableArray *titleArr;


//content
@property (nonatomic, strong) NSMutableArray *contentArr;


//bottomArray
@property (nonatomic, strong) NSMutableArray *bottomArr;

@end
