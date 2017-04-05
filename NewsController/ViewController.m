//
//  ViewController.m
//  NewsController
//
//  Created by Doman on 17/4/5.
//  Copyright © 2017年 doman. All rights reserved.
//

#import "ViewController.h"
#import "NewsTopicViewController.h"
#import "NewsTopicLabel.h"
#import "UIView+XMExtension.h"

@interface ViewController ()<UIScrollViewDelegate>

/** 顶部的所有标签 */
@property (nonatomic, weak) UIScrollView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新闻";
    
    [self setUp];
    
    
    [self setUpChildrensControllers];
    
    [self setSubViews];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setUp
{
    self.view.backgroundColor = [UIColor whiteColor];

    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)setUpChildrensControllers
{
    
    NewsTopicViewController *all = [[NewsTopicViewController alloc] init];
    all.title = @"全部";
    all.str = @"1";
    [self addChildViewController:all];
    
    NewsTopicViewController *video = [[NewsTopicViewController alloc] init];
    video.str = @"2";
    video.title = @"视频";
    [self addChildViewController:video];
    
    NewsTopicViewController *voice = [[NewsTopicViewController alloc] init];
    voice.title = @"声音";
    video.str = @"3";
    [self addChildViewController:voice];
    
    NewsTopicViewController *picture = [[NewsTopicViewController alloc] init];
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    NewsTopicViewController *word = [[NewsTopicViewController alloc] init];
    word.title = @"段子";
    [self addChildViewController:word];
    
    
    NewsTopicViewController *military = [[NewsTopicViewController alloc] init];
    military.title = @"军事";
    [self addChildViewController:military];
    
    NewsTopicViewController *science = [[NewsTopicViewController alloc] init];
    science.title = @"科技";
    [self addChildViewController:science];
}

- (void)setSubViews
{
    [self setUptitlesView];
    
    [self setUpcontentView];
}

- (void)setUptitlesView
{
    
    // 标签栏整体
    UIScrollView *titlesView = [[UIScrollView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 44;
    titlesView.y = 64;
    titlesView.showsHorizontalScrollIndicator = NO;
    titlesView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 定义临时变量
    CGFloat labelW = 100;
    CGFloat labelY = 0;
    CGFloat labelH = self.titlesView.frame.size.height;

    // 添加label
    NSInteger count = self.childViewControllers.count;
    
    for (int i = 0; i < count; i++) {
        
        NewsTopicLabel *topicLabel = [[NewsTopicLabel alloc] init];
        topicLabel.text = self.childViewControllers[i].title;
        topicLabel.frame = CGRectMake(i * labelW, labelY, labelW, labelH);
        [topicLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        topicLabel.tag = i;
        [self.titlesView addSubview:topicLabel];
        
        if (i == 0) { // 第一个label
            topicLabel.scale = 1.0;
        }

    }
    
    self.titlesView.contentSize = CGSizeMake(count * labelW, 0);

    
}


- (void)setUpcontentView
{
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;

    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

//监听顶部label点击
- (void)labelClick:(UITapGestureRecognizer *)tap
{
    // 取出被点击label的索引
    NSInteger index = tap.view.tag;
    
    // 让底部的内容scrollView滚动到对应位置
    CGPoint offset = self.contentView.contentOffset;
    offset.x = index * self.contentView.frame.size.width;
    [self.contentView setContentOffset:offset animated:YES];
}

#pragma mark -- UIScrollViewDelegate
//scrollView结束了滚动动画以后就会调用这个方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;

    NewsTopicLabel * newTopicLabel = self.titlesView.subviews[index];
    CGPoint titleOffset = self.titlesView.contentOffset;
    titleOffset.x = newTopicLabel.center.x - width * 0.5;
    // 左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    // 右边超出处理
    CGFloat maxTitleOffsetX = self.titlesView.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    
    [self.titlesView setContentOffset:titleOffset animated:YES];

    // 让其他label回到最初的状态
    for (NewsTopicLabel *otherLabel in self.titlesView.subviews) {
        if (otherLabel != newTopicLabel) otherLabel.scale = 0.0;
    }
    
    UIViewController *willShowVc = self.childViewControllers[index];
    willShowVc.view.frame = CGRectMake(offsetX, 0, width, height);
    
    // 添加控制器的view到contentScrollView中;
    [scrollView addSubview:willShowVc.view];
}


//手指松开scrollView后，scrollView停止减速完毕就会调用这个
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

//只要scrollView在滚动，就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (scale < 0 || scale > self.titlesView.subviews.count - 1) return;
    
    // 获得需要操作的左边label
    NSInteger leftIndex = scale;
    NewsTopicLabel *leftLabel = self.titlesView.subviews[leftIndex];
    
    // 获得需要操作的右边label
    NSInteger rightIndex = leftIndex + 1;
    NewsTopicLabel *rightLabel = (rightIndex == self.titlesView.subviews.count) ? nil : self.titlesView.subviews[rightIndex];
    
    // 右边比例
    CGFloat rightScale = scale - leftIndex;
    // 左边比例
    CGFloat leftScale = 1 - rightScale;
    
    // 设置label的比例
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
