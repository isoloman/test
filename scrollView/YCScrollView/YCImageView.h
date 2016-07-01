//
//  YCImageView.h
//  scrollView
//
//  Created by administrator on 16/7/1.
//  Copyright © 2016年 star. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCImageView : UIControl

@property (nonatomic, strong)  UIImageView * imageView;

/**
 * 用于直接展示的图片
 */
@property (nonatomic, strong) UIImage * showImage;

/**
 * 设置加载失败图片
 */
@property (nonatomic, strong) UIImage * failImage;

/**
 * 加载网络图片
 */
- (void)startRequestWithURL:(id)url;

- (void)resetStatus; //优化重用性

@end
