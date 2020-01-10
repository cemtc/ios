//
//  CustomGuideViewController.m
//  wallet
//
//  Created by 曾云 on 2019/8/25.
//  Copyright © 2019 talking　. All rights reserved.
//

#import "CustomGuideViewController.h"
#import "iCarousel.h"
#import "SKFileCacheManager.h"

#import "CustomLoginViewController.h"
#import "SKBaseNavigationController.h"

@interface CustomGuideViewController ()
@property (weak, nonatomic) IBOutlet iCarousel *iCarousel;

@end

@implementation CustomGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.barStyle = UIStatusBarStyleLightContent;
    self.iCarousel.type = iCarouselTypeLinear;
    self.iCarousel.decelerationRate = 0.6;
    self.iCarousel.bounces = NO;
    self.iCarousel.clipsToBounds = YES;
    
    [SKFileCacheManager saveUserData:@YES forKey:SKKEY_HAS_LAUNCHED_ONCE];
}


#pragma mark -iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 3;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIImageView *imageView = nil;
    if (!view)
    {
        imageView = [[UIImageView alloc]init];
        imageView.frame = carousel.bounds;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.userInteractionEnabled = YES;
    }
    else
    {
        imageView = (UIImageView*)view;
    }
    
    
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.tag = index;
    NSString *imageName = [NSString stringWithFormat:@"img_%d",index+1];
    imageView.image = [UIImage imageNamed:imageName];
    return imageView;
    
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    return SKScreenWidth;
}

#pragma mark -iCarouselDelegate

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform {
    return   CATransform3DTranslate(transform, offset , 0.0, 0.0);
}

- (void)carouselCurrentItemIndexUpdated:(iCarousel *)carousel{
    //    self.index = carousel.currentItemIndex;
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    //    self.index = carousel.currentItemIndex;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"公告View  didSelectItemAtIndex = %ld",(long)index);
    if (index == 2 || index == 0) {
        if ([CustomUserManager customSharedManager].userModel) {
            KEY_WINDOW.rootViewController = [[SKTabBarController alloc]init];
        } else {
            CustomLoginViewController *viewController = (CustomLoginViewController *)[[UIStoryboard storyboardWithName:@"User" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomLogin"];
             [KEY_WINDOW setRootViewController:[[SKBaseNavigationController alloc] initWithRootViewController:viewController]];
        }
    }
}



- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return NO;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value*1.15;
        }
            
        default:
        {
            return value;
        }
            
    }
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel{
    
}
- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate{
    
}
- (BOOL)carousel:(iCarousel *)carousel shouldSelectItemAtIndex:(NSInteger)index {
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
