//
//  JZKHeaderView.m
//  封装一个好的头视图吧
//
//  Created by 张全成 on 16/1/20.
//  Copyright © 2016年 贾振凯. All rights reserved.
//

#import "JZKHeaderView.h"
#import <UIImageView+WebCache.h>
#import "UIView+Common.h"

#define TitleLabelH 30

@interface JZKHeaderView ()<UIScrollViewDelegate>

//用于存放 imageViews 的数组
@property (nonatomic, strong) NSMutableArray *imageViews;
//创建滚动视图，让图片在这上面滚动
@property (nonatomic, strong) UIScrollView *scrollView;
//小圆点
@property (nonatomic, strong) UIPageControl *pageControl;
//图片的标题
@property (nonatomic, strong) UILabel *titleLabel;
//添加一个定时器，让图片能自己滚动
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) CGFloat HeadViewH;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation JZKHeaderView

//封装好的东西要留下借口  别人用的时候直接通过这个接口实现效果，至于怎么实现的不用管，保证了代码的安全性，增加了代码的健壮性
- (instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.HeadViewH = frame.size.height;
        //初始化数组
        _imageViews = [[NSMutableArray alloc]init];
        [self customViews];
    }
    return self;
}

- (void)customViews {
    
    //创建滚动视图，让图片在这上面滚动
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.frame = CGRectMake(0, 0, width(self), self.HeadViewH);

    
    //永远显示的是中间的 ImageView
//    _scrollView.contentOffset = CGPointMake(width(_scrollView), height(_scrollView));
    [self addSubview:_scrollView];
    
    
    //开始创建小圆点啦
    CGFloat leftPadding = 20;
    CGFloat rightPadding = 20;
    CGFloat pageWidth = 60;
    
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:211 / 255.0 green:211 / 255.0 blue:211 / 255.0 alpha:1.0];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.frame = CGRectMake((width(self)-pageWidth)*0.5, maxY(_scrollView)-TitleLabelH, pageWidth, TitleLabelH);
    //给小圆点添加点击事件  当点击的时候会跳到相应的图片
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_pageControl];
    
    //添加图片的标题
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
    }];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:42];
    _contentLabel.textColor = [UIColor whiteColor];
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(8);
    }];
    
    _bottomLabel = [[UILabel alloc]init];
    _bottomLabel.font = [UIFont systemFontOfSize:12];
    _bottomLabel.textColor = [UIColor whiteColor];
    [self addSubview:_bottomLabel];
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(8);
    }];

}

#pragma mark 小圆点的点击事件
- (void)changePage:(UIPageControl *)pageControl {
    
    NSInteger currentPage = pageControl.currentPage;
    if (currentPage == [_imageViews[2] tag] || currentPage == _imageArr.count - 1) {
        //向左滑
        CGPoint offSet = CGPointMake(width(_scrollView)*2, 0);
        [_scrollView setContentOffset:offSet animated:YES];
    }else if (currentPage == [_imageViews[0] tag] || currentPage == 0) {
        //向右滑
        [_scrollView setContentOffset:CGPointZero animated:YES];
    }
}

- (void)setTitleArr:(NSMutableArray *)titleArr {

    _titleArr = titleArr;
    _titleLabel.text =  _titleArr[0];
}

- (void)setContentArr:(NSMutableArray *)contentArr {
    _contentArr = contentArr;
    _contentLabel.text = _contentArr[0];
}

- (void)setBottomArr:(NSMutableArray *)bottomArr {
    _bottomArr = bottomArr;
    _bottomLabel.text = _bottomArr[0];
}

//重写 imageArr 的 setter 方法，给 imageArr 赋值
- (void)setImageArr:(NSMutableArray *)imageArr {

    _imageArr = imageArr;
    self.pageControl.numberOfPages = imageArr.count;
    if (_imageArr.count > 0) {
        //添加定时器
        if (self.timer == nil) {
            [self addTimer];
        }
        
        self.scrollView.contentSize = CGSizeMake(width(self)*3, self.HeadViewH);
        self.pageControl.currentPage = 0;
        [self.scrollView setContentOffset:CGPointMake(width(_scrollView), 0) animated:NO];
        
        //下拉刷新的时候删除 imageViews 数组中所有的元素然后再重新添加
        for (UIImageView *imageView in _imageViews) {
            [imageView removeFromSuperview];
        }
        [_imageViews removeAllObjects];
        [self createImageViews];
    }

}

// 添加定时器
- (void)addTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    // 把定时器注册在 NSRunLoopCommonModes模式下,在滚动视图滚动时也可以监听这个timer
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

// 删除定时器
- (void)removeTimer {
    [self.timer invalidate];
    self.timer=nil;
}

//定时器实现的方法  目的是让图片自己滚动到下一张
- (void)nextPage {
    CGPoint offSet = CGPointMake(width(_scrollView) * 2, 0);
    [_scrollView setContentOffset:offSet animated:YES];
    [self cycleReuse];
}

//创建3个循环复用的 imageView 用于贴图片
- (void)createImageViews {
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame= CGRectMake(i * width(_scrollView), 0, width(_scrollView), self.HeadViewH);
        imageView.tag = (i - 1 +_imageArr.count) % _imageArr.count;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [imageView addGestureRecognizer:tgr];
        
        //把图片贴上去
        [self setImageToView:imageView];
        [_scrollView addSubview:imageView];
        [_imageViews addObject:imageView];
    }
}
//点击图片 捕捉到点击的是第几张图片，通过 block 方法进行值得传输
- (void)tapGestureAction:(UITapGestureRecognizer *)tgr {
    if (_headViewBlock) {
        _headViewBlock(tgr.view.tag);
    }
}

//把图片贴上
- (void)setImageToView:(UIImageView *)imageView {

    [imageView sd_setImageWithURL:[NSURL URLWithString:_imageArr[imageView.tag]] placeholderImage:nil];
}


- (void)cycleReuse {
    int flag = 0;
    // 获取滚动视图偏移量
    CGFloat offSetX = _scrollView.contentOffset.x;
    if (offSetX == 2 * width(_scrollView)) {
        // 向左滑
        flag = 1;
    } else if(offSetX == 0) {
        // 向右滑
        flag = -1;
    } else {
        return;
    }
    for (UIImageView *imageView in _imageViews) {
        // 重新计算tag值
        imageView.tag = (imageView.tag + flag + _imageArr.count) % _imageArr.count;
        [self setImageToView:imageView];
    }
    // 无动画的设置_scrollView的偏移量
    [_scrollView setContentOffset:CGPointMake(width(_scrollView), 0) animated:NO];
    _pageControl.currentPage = [_imageViews[1] tag];
    _titleLabel.text = _titleArr[_pageControl.currentPage];
    _contentLabel.text = _contentArr[_pageControl.currentPage];
    _bottomLabel.text = _bottomArr[_pageControl.currentPage];
}

#pragma mark - UIScrollViewDelegate

//滚动视图减速结束的时候调用的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self cycleReuse];
}

// 开始拖拽是关闭定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

// 结束拖拽时开启定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}

//结束滚动动画的时候调用的方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self cycleReuse];
}


@end
