//
//  CustmTabBarController.m
//  wanteng
//
//  Created by mrz on 2016/12/21.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "CustmTabBarController.h"

@interface CustmTabBarController ()

@end

@implementation CustmTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
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
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    CATransition* animation = [CATransition animation];
    [animation setDuration:0.5f];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [[self.view layer]addAnimation:animation forKey:@"switchView"];
}
@end
