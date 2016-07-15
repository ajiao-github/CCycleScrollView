//
//  LVScrollView.m
//
//  Created by ajiao on 16/7/11.
//  Copyright © 2016年 All rights reserved.
//
/*
 *********************************************************************************
 *
 * 🌟🌟🌟 新建LVScrollView交流QQ群：277157761 🌟🌟🌟
 *
 * 在您使用此自动轮播库的过程中如果出现bug请及时以以下任意一种方式联系我们，我们会及时修复bug并
 * 帮您解决问题。
 * Email : 2528982823@qq.com
 * GitHub: https://github.com/ajiao-github
 *
 *********************************************************************************
 */

#import "LVScrollView.h"
#import "UIImageView+WebCache.h"

@interface LVScrollView () <UIScrollViewDelegate>
{
    NSInteger _totalPages;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, assign) BOOL isLocalImage;
@property (nonatomic, strong) UIImage *placeHoldImage;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval duration;

@end

@implementation LVScrollView

- (instancetype)initWithFrame:(CGRect)frame withAnimationDuration:(NSTimeInterval)animationDuration withLoacalImage:(BOOL)isLocalImg withImageArr:(NSArray *)imageArr andWithPlaceHoldImage:(UIImage *)placeHoldImage {

    if (self == [super initWithFrame:frame]) {
        
        self.isLocalImage = isLocalImg;
        self.placeHoldImage = placeHoldImage;
        self.currentIndex = 0;
        self.imageArr = imageArr;
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        self.scrollView.scrollEnabled = YES;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.contentSize  = CGSizeMake(CGRectGetWidth(frame)*3, CGRectGetHeight(frame));
        [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(frame), 0) animated:NO];
        [self addSubview:self.scrollView];
        
        self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), frame.size.height)];
        self.centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(frame), 0, CGRectGetWidth(frame), frame.size.height)];
        self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(frame)*2, 0, CGRectGetWidth(frame), frame.size.height)];
        [self.scrollView addSubview:self.leftImageView];
        [self.scrollView addSubview:self.centerImageView];
        [self.scrollView addSubview:self.rightImageView];
        
        [self initPageControl];
        
        [self reloadData];
        
        if (animationDuration > 0) {
            self.duration = animationDuration;
            [self startTimer];
        }
    }
    return self;
}

- (void)initPageControl {

    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.scrollView.frame)-30, CGRectGetWidth(self.scrollView.frame), 20)];
    self.pageControl.numberOfPages = self.imageArr.count;
    self.pageControl.currentPage = 0;
    self.pageControl.enabled = NO;
    [self addSubview:self.pageControl];
}

- (void)startTimer {

    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_duration target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)pauseTimer {

    if (self.timer.isValid) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)resumeTimer {
    
    if (self.timer.isValid) {
        [self.timer setFireDate:[NSDate date]];
    }
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if ([self.timer isValid]) {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
    }
}

- (void)stopTime {

    if (self.timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)timerAction {
    
    if (self.timer.isValid) {
        CGPoint newOffset = CGPointMake(2 * CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
        
        [self.scrollView setContentOffset:newOffset animated:YES];
    }
}

- (void)reloadData
{
    _totalPages = self.imageArr.count;
    if (_totalPages == 0) {
        return;
    }
    _pageControl.numberOfPages = _totalPages;
    
    _pageControl.currentPage = _currentIndex;
    
    [self getDisplayViewsWithCurrentPage:_currentIndex];

    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

//根据实际的page转化为有效地下一页
- (NSInteger)validNextPageWithCurrentPage:(NSInteger)index;
{
    if(index == -1)
    {
        //滑到负一页时应该显示最后一页
        index = _totalPages - 1;
    }
    
    if(index == _totalPages)
    {
        //滑到最后一页+1时，应该显示第一页
        index = 0;
    }
    
    return index;
}

//获取展现的个view
- (void)getDisplayViewsWithCurrentPage:(NSInteger)page {
    
    NSInteger pre = [self validNextPageWithCurrentPage:_currentIndex - 1];
    NSInteger last = [self validNextPageWithCurrentPage:_currentIndex + 1];
    
    if (self.isLocalImage) {
        
        self.centerImageView.image = [UIImage imageNamed:self.imageArr[page]];
        self.leftImageView.image = [UIImage imageNamed:self.imageArr[pre]];
        self.rightImageView.image = [UIImage imageNamed:self.imageArr[last]];
        
    } else {
        
        [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArr[page]] placeholderImage:self.placeHoldImage];
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArr[pre]]  placeholderImage:self.placeHoldImage];
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArr[last]] placeholderImage:self.placeHoldImage];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //暂停
    [self pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //继续
    [self resumeTimerAfterTimeInterval:_duration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollView.contentOffset.x=====%f",scrollView.contentOffset.x);

    if (_totalPages) {
        CGFloat x = scrollView.contentOffset.x;
        //往下翻一张
        if(x >= (2*self.frame.size.width)) {
            _currentIndex = [self validNextPageWithCurrentPage:_currentIndex+1];
            [self reloadData];
        }
        
        //往上翻
        if(x <= 0) {
            _currentIndex = [self validNextPageWithCurrentPage:_currentIndex-1];
            [self reloadData];
        }
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:NO];
}

//完了让它回到中间
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:NO];
}

@end
