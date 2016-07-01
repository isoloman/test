//
//  YCImageScrollView.m
//  scrollView
//
//  Created by administrator on 16/7/1.
//  Copyright © 2016年 star. All rights reserved.
//

#import "YCImageScrollView.h"
#import "NSArray+ExtraMethod.h"
#import "NSTimer+Addition.h"
#import "YCImageView.h"
#import "UIView+YCExtension.h"

@interface YCImageScrollView ()<UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, strong) NSArray * imagePaths;
@property (nonatomic, strong) NSTimer * animationTimer;
@property (nonatomic, strong) UIPageControl * pageControl;
@property (nonatomic, readonly) UIScrollView *scrollView;

@property (nonatomic, strong) YCImageView * leftImageView;
@property (nonatomic, strong) YCImageView * centerImageView;
@property (nonatomic, strong) YCImageView * rightImageView;

@end

@implementation YCImageScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_animationTimer resumeTimerAfterTimeInterval:_autoDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * _scrollView.yc_width)) {
        self.currentPageIndex = [self checkNextPageIndex:self.currentPageIndex + 1];
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self checkNextPageIndex:self.currentPageIndex - 1];
        [self configContentViews];
    }
    
    self.pageControl.currentPage = self.currentPageIndex;
    
    if (_useParallaxEffect) {
        
         CGFloat offx = scrollView.contentOffset.x-_scrollView.yc_width;
        
        _leftImageView.imageView.frame = CGRectMake(0.33* scrollView.contentOffset.x, 0, _scrollView.yc_width, _scrollView.yc_height);
        _centerImageView.imageView.frame = CGRectMake(0.33 * offx , 0, _scrollView.yc_width, _scrollView.yc_height);
        
       
        _rightImageView.imageView.frame = CGRectMake(0.33*offx - 0.33* _scrollView.yc_width , 0, _scrollView.yc_width, _scrollView.yc_height);

    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView setContentOffset:CGPointMake(_scrollView.yc_width, 0) animated:YES];
}


#pragma mark public method

- (void)loadImageURL:(NSArray *)urls
{
    _imagePaths = urls;
    
    if ([_imagePaths count] > 1)
    {
        _scrollView.scrollEnabled = YES;
        _pageControl.hidden = NO;
        _pageControl.numberOfPages = [_imagePaths count];
        
        _animationTimer = [NSTimer scheduledTimerWithTimeInterval:_autoDuration
                                                           target:self
                                                         selector:@selector(animationTimerDidFired:)
                                                         userInfo:nil
                                                          repeats:YES];
        [self performSelector:@selector(beginTime) withObject:nil afterDelay:_autoDuration];
        
    }
    else
    {
        _scrollView.scrollEnabled = NO;
        _pageControl.hidden = YES;
        _pageControl.numberOfPages = 0;
        [_animationTimer invalidate];
    }
    
    [self configContentViews];
}

- (void)resetData
{
    [_animationTimer invalidate];
    _animationTimer = nil;
    _currentPageIndex = 0;
}

#pragma mark - EventHandler

- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(_scrollView.contentOffset.x + _scrollView.yc_width, _scrollView.contentOffset.y);
    [_scrollView setContentOffset:newOffset animated:YES];
}

- (void)beginTime
{
    [_animationTimer resumeTimer];
}

#pragma mark self method

- (NSInteger)checkNextPageIndex:(NSInteger)nextPage
{
    if(nextPage == -1) {
        return [_imagePaths count] - 1;
    } else if (nextPage == [_imagePaths count]) {
        return 0;
    } else {
        return nextPage;
    }
}

//创建滚动视图内容
- (void)createContentViews
{
    _leftImageView   = [[YCImageView alloc] initWithFrame:self.bounds];
    _centerImageView = [[YCImageView alloc] initWithFrame:CGRectMake(_scrollView.yc_width, 0.0, _scrollView.yc_width, _scrollView.yc_height)];
    _rightImageView  = [[YCImageView alloc] initWithFrame:CGRectMake(2 * _scrollView.yc_width, 0.0, _scrollView.yc_width, _scrollView.yc_height)];
    
    [_centerImageView addTarget:self action:@selector(onClickImageView) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_centerImageView];
    [_scrollView addSubview:_rightImageView];
    [_scrollView bringSubviewToFront:_centerImageView];
}

//重置内容
- (void)configContentViews
{
    [_leftImageView resetStatus];
    [_rightImageView resetStatus];
    [_centerImageView resetStatus];
    
    [_leftImageView startRequestWithURL:[self.imagePaths objectSafetyAtIndex:[self checkNextPageIndex:_currentPageIndex-1]]];
    [_centerImageView startRequestWithURL:[self.imagePaths objectSafetyAtIndex:[self checkNextPageIndex:_currentPageIndex]]];
    [_rightImageView startRequestWithURL:[self.imagePaths objectSafetyAtIndex:[self checkNextPageIndex:_currentPageIndex+1]]];
    
    [_scrollView bringSubviewToFront:_centerImageView];
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

- (void)onClickImageView
{
    if ([self.YCDelegate respondsToSelector:@selector(didClickImageScrollViewAtIndex:)]) {
        [self.YCDelegate didClickImageScrollViewAtIndex:self.currentPageIndex];
    }
}

#pragma mark -  初始化
- (void)initialize{
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    _currentPageIndex  = 0;
    _useParallaxEffect = YES;
    _autoDuration      = 2.0;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.autoresizingMask = 0xFF;
    _scrollView.contentMode = UIViewContentModeCenter;
    _scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    
    _scrollView.delegate      = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = NO;
    
    _scrollView.showsVerticalScrollIndicator   = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _pageControl = [UIPageControl new];
    [_pageControl sizeToFit];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithWhite:220.0/255.0 alpha:1.0]];
    [_pageControl setCenter:CGPointMake(self.yc_centerX, self.yc_height - 15.0)];
    [_pageControl setHidden:YES];
    
    [self createContentViews];
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
}

-(void)setFailImage:(UIImage *)failImage{
    _failImage = failImage;
    
    _leftImageView.failImage   = _failImage;
    _centerImageView.failImage = _failImage;
    _rightImageView.failImage  = _failImage;
}


@end
