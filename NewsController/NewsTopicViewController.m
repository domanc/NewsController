//
//  NewsTopicViewController.m
//  NewsController
//
//  Created by Doman on 17/4/5.
//  Copyright © 2017年 doman. All rights reserved.
//

#import "NewsTopicViewController.h"

@interface NewsTopicViewController ()

@end

@implementation NewsTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch ([self.str integerValue]) {
        case 1:
            self.view.backgroundColor = [UIColor orangeColor];
            break;
        case 2:
            self.view.backgroundColor = [UIColor yellowColor];
            break;
        case 3:
            self.view.backgroundColor = [UIColor blueColor];
            break;
    
        default:
            self.view.backgroundColor = [UIColor purpleColor];
            break;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
