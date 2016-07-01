//
//  YCImageScrollView.h
//  scrollView
//
//  Created by administrator on 16/7/1.
//  Copyright © 2016年 star. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCImageScrollView;

@protocol YCImageScrollViewDelegate  <NSObject>

@optional
- (void)didClickImageScrollViewAtIndex:(NSInteger)pageIndex;

@end

@interface YCImageScrollView : UIView

@property (nonatomic, strong) UIImage *failImage;
@property (nonatomic, assign) NSTimeInterval autoDuration;
@property (nonatomic, assign) id<YCImageScrollViewDelegate> YCDelegate;

//默认开启滚动视差效果
@property (nonatomic, assign) BOOL useParallaxEffect;

- (void)loadImageURL:(NSArray *)urls;

//重新设置信息
- (void)resetData;

@end
