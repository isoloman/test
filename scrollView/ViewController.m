//
//  ViewController.m
//  scrollView
//
//  Created by administrator on 16/7/1.
//  Copyright © 2016年 star. All rights reserved.
//

#import "ViewController.h"
#import "YCImageScrollView.h"

@interface ViewController ()<YCImageScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    YCImageScrollView * scrollView = [[YCImageScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    scrollView.YCDelegate = self;
    scrollView.autoDuration = 6.0;
    [self.view addSubview:scrollView];
    
    NSURL *imageURL1 = [NSURL URLWithString:@"http://www.uc129.com/uploads/allimg/150428/1-15042Q04030.jpg"];
    NSURL *imageURL2 = [NSURL URLWithString:@"http://www.people.com.cn/h/pic/20111031/99/15317457967897249011.jpg"];
    NSURL *imageURL3 = [NSURL URLWithString:@"http://school.indexedu.com/data/uploads/picture/westminster_1/20140117144515.jpg"];
    
    [scrollView loadImageURL:@[imageURL1, imageURL2, imageURL3]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
