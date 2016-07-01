//
//  UIView+YCExtension.m
//  scrollView
//
//  Created by administrator on 16/7/1.
//  Copyright © 2016年 star. All rights reserved.
//

#import "UIView+YCExtension.h"

@implementation UIView (YCExtension)

- (void) setYc_x:(CGFloat)yc_x{
    CGRect frame = self.frame;
    frame.origin.x = yc_x;
    self.frame = frame;
}

- (CGFloat) yc_x{
    return self.frame.origin.x;
}

- (void) setYc_y:(CGFloat)yc_y{
    CGRect frame = self.frame;
    frame.origin.y = yc_y;
    self.frame = frame;
}

- (CGFloat) yc_y{
    return self.frame.origin.y;
}

- (void) setYc_centerX:(CGFloat)yc_centerX{
    CGPoint center = self.center;
    center.x = yc_centerX;
    self.center = center;
}

- (CGFloat) yc_centerX{
    return self.center.x;
}

- (void) setYc_centerY:(CGFloat)yc_centerY{
    CGPoint center = self.center;
    center.y = yc_centerY;
    self.center = center;
}
- (CGFloat) yc_centerY{
    return self.center.y;
}

- (void) setYc_width:(CGFloat)yc_width{
    CGRect frame = self.frame;
    frame.size.width = yc_width;
    self.frame = frame;
}

- (CGFloat) yc_width{
    return self.frame.size.width;
}

- (void) setYc_height:(CGFloat)yc_height{
    CGRect frame = self.frame;
    frame.size.height = yc_height;
    self.frame = frame;
}

- (CGFloat) yc_height{
    return self.frame.size.height;
}


- (CGPoint) yc_origin
{
    return self.frame.origin;
}

- (void) setYc_origin:(CGPoint)yc_origin
{
    CGRect newframe = self.frame;
    newframe.origin = yc_origin;
    self.frame = newframe;
}


- (void) setYc_size:(CGSize)yc_size
{
    CGRect frame = self.frame;
    frame.size = yc_size;
    self.frame = frame;
}
- (CGSize) yc_size{
    return self.frame.size;
}

- (CGFloat) yc_top
{
    return self.frame.origin.y;
}

- (void) setYc_top:(CGFloat)yc_top
{
    CGRect newframe = self.frame;
    newframe.origin.y = yc_top;
    self.frame = newframe;
}

- (CGFloat) yc_left
{
    return self.frame.origin.x;
}

- (void) setYc_left:(CGFloat)yc_left
{
    CGRect newframe = self.frame;
    newframe.origin.x = yc_left;
    self.frame = newframe;
}

- (CGFloat) yc_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setYc_bottom:(CGFloat)yc_bottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = yc_bottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) yc_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setYc_right:(CGFloat)yc_right
{
    CGFloat delta = yc_right - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

// Move via offset
- (void) moveBy: (CGPoint) delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;	
}

@end
