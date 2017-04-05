//
//  NewsTopicLabel.m
//  NewsController
//
//  Created by Doman on 17/4/5.
//  Copyright © 2017年 doman. All rights reserved.
//

#import "NewsTopicLabel.h"

CGFloat const NewsTopicLabelRed = .4f;
CGFloat const NewsTopicLabelGreen = .6f;
CGFloat const NewsTopicLabelBlue = .7f;
CGFloat const NewsTopicLabelAlpha = 1.0f;


@implementation NewsTopicLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor colorWithRed:NewsTopicLabelRed green:NewsTopicLabelGreen blue:NewsTopicLabelBlue alpha:1.0];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    //      R G B
    // 默认：0.4 0.6 0.7
    // 红色：1   0   0
    
    CGFloat red = NewsTopicLabelRed + (1 - NewsTopicLabelRed) * scale;
    CGFloat green = NewsTopicLabelGreen + (0 - NewsTopicLabelGreen) * scale;
    CGFloat blue = NewsTopicLabelBlue + (0 - NewsTopicLabelBlue) * scale;
    self.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    // 大小缩放比例
    CGFloat transformScale = 1 + scale * 0.3; // [1, 1.3]
    self.transform = CGAffineTransformMakeScale(transformScale, transformScale);
}

@end
