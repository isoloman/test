//
//  UIView+YCExtension.h
//  scrollView
//
//  Created by administrator on 16/7/1.
//  Copyright © 2016年 star. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YCExtension)

@property (nonatomic,assign) CGFloat yc_x;
@property (nonatomic,assign) CGFloat yc_y;

@property (nonatomic,assign) CGFloat yc_top;
@property (nonatomic,assign) CGFloat yc_left;

@property (nonatomic,assign) CGFloat yc_bottom;
@property (nonatomic,assign) CGFloat yc_right;

@property (nonatomic,assign) CGFloat yc_centerX;
@property (nonatomic,assign) CGFloat yc_centerY;

@property (nonatomic,assign) CGFloat yc_width;
@property (nonatomic,assign) CGFloat yc_height;

@property (nonatomic,assign) CGPoint yc_origin;
@property (nonatomic,assign) CGSize  yc_size;

- (void) moveBy   : (CGPoint) delta;
- (void) scaleBy  : (CGFloat) scaleFactor;
- (void) fitInSize: (CGSize) aSize;

@end
