//
//  HJScrollView.m
//  AppStore下拉
//
//  Created by Collion on 15/8/14.
//  Copyright (c) 2015年 Collion. All rights reserved.
//

#import "HJScrollView.h"

@interface HJScrollView ()

@property (weak, nonatomic) UIScrollView *scrollView;

@end

@implementation HJScrollView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        
        self.scrollView = scrollView;
        
        [self addSubview:scrollView];
    }
    
    return self;
}

// 布局创建的scrollview
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat heigth = self.frame.size.height;
    self.scrollView.frame = CGRectMake(0, 0, width, heigth);
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat heigth = self.frame.size.height;
    NSUInteger count = images.count;
    for (int i = 0; i < images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width * i, 0, width, heigth)];
        imageView.image = [UIImage imageNamed:images[i]];
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(count * width, 0);
}

@end
