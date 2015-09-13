//
//  ViewController.m
//  AppStore首页下拉
//
//  Created by Collion on 15/8/14.
//  Copyright (c) 2015年 Collion. All rights reserved.
//

#import "ViewController.h"
#import "HJScrollView.h"

// 自定义的scrollview高度（150是头部视图高度）
const CGFloat kScrollHeigth = 150;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

/** 纪录最原始的偏移量 */
@property (nonatomic, assign) CGFloat orginalOffsetY;

@property (weak, nonatomic) IBOutlet HJScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollTopCons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpScrollView];
    
    // tableview相对于原点的偏移量 = 为视图高度+导航栏高度(64为导航控制器高度)
    self.orginalOffsetY = - (kScrollHeigth + 64);
    
    // 使用内边距将tableView默认top设置在HJScrollView下
    self.tableView.contentInset = UIEdgeInsetsMake(kScrollHeigth + 64, 0, 0, 0);
    
    // 取消ios7以后为scrollview添加的额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 取消显示右侧滚动条(可不加)
    self.tableView.showsVerticalScrollIndicator = NO;
    
    // 设置tableview的代理
    self.tableView.delegate = self;
    
    // 设置tableview数据源代理
    self.tableView.dataSource = self;
}

// 初始化scrollview数据
- (void)setUpScrollView
{
    NSArray *arrays = @[@"img_01", @"img_02", @"img_03", @"img_04", @"img_05"];
    self.scrollView.images = arrays;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行", indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前的偏移量
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    
    // 纪录当前偏移量之差
    CGFloat delta = currentOffsetY - self.orginalOffsetY;
    
    // 当手指向下滑动时，保持头部视图不变
    if (delta <= 0) {
        delta = 0;
    }
    
    // 当手纸向上滑动时，让视图的头部约束为负数，这样就可以将头部视图往上推
    self.scrollTopCons.constant = -delta;
}

@end
