//
//  YCImageView.m
//  scrollView
//
//  Created by administrator on 16/7/1.
//  Copyright © 2016年 star. All rights reserved.
//

#import "YCImageView.h"
#import "UIImageView+WebCache.h"

@interface YCImageView ()

- (void)startLoadingAnimation;
- (void)stopLoadingAnimation;

@end

@implementation YCImageView{
    UIImageView * _botImageView;
    UIActivityIndicatorView * _loadingView;
}


- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _loadingView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.frame.size.width - 20)/2,
                                                                                 (self.frame.size.height -20)/2,
                                                                                 20, 20)];
    
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
        
        [self addSubview:_imageView];
        [self addSubview:_loadingView];

    }
    
    return self;
}


- (void)startRequestWithURL:(id)url{
    
    [self startLoadingAnimation];
    
    NSURL * requestUrl;
    
    if ([url isKindOfClass:[NSString class]]) {
        requestUrl = [NSURL URLWithString:url];
    }
    else if ([url isKindOfClass:[NSURL class]]){
        requestUrl = url;
    }
    
    [_imageView sd_setImageWithURL:requestUrl placeholderImage:_failImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self stopLoadingAnimation];
    }];
}

-(void)stopLoadingAnimation{
    [_loadingView stopAnimating];
}

-(void)startLoadingAnimation{
    [_loadingView startAnimating];
}


- (void)resetStatus
{
    [_imageView setImage:nil];
    
}

-(void)setShowImage:(UIImage *)showImage{
    _showImage = showImage;
    _imageView.image = _showImage;
}

-(void)setFailImage:(UIImage *)failImage{
    _failImage = failImage;
}

@end
