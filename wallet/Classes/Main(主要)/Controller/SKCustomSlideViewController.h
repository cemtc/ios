//
//  SKCustomSlideViewController.h
//  Business
//
//  Created by talking　 on 2018/8/15.
//  Copyright © 2018年 talking　. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SKCustomSlideViewController;
@protocol SKCustomSlideViewControllerDelegate <NSObject>

@optional
/** 滚动偏移量*/
- (void)customSlideViewController:(SKCustomSlideViewController *)slideViewController slideOffset:(CGPoint)slideOffset;
- (void)customSlideViewController:(SKCustomSlideViewController *)slideViewController slideIndex:(NSInteger)slideIndex;
@end



@protocol SKCustomSlideViewControllerDataSource <NSObject>
/** 子控制器*/
- (UIViewController *)slideViewController:(SKCustomSlideViewController *)slideViewController viewControllerAtIndex:(NSInteger)index;
/** 子控制器数量*/
- (NSInteger)numberOfChildViewControllersInSlideViewController:(SKCustomSlideViewController *)slideViewController;
@end


@interface SKCustomSlideViewController : UIViewController

@property (nonatomic, weak) id <SKCustomSlideViewControllerDelegate> delgate;
@property (nonatomic, weak) id <SKCustomSlideViewControllerDataSource> dataSource;
@property (nonatomic, assign) NSInteger seletedIndex;
- (void)reloadData;

@end
