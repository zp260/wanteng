//
//  SecondContentViewController.h
//  wanteng
//
//  Created by mrz on 2016/12/7.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWork.h"
#import "ImgSrcFix.h"
#import "MBProgressHUD.h"
@interface SecondContentViewController : UIViewController<UITabBarDelegate,UIGestureRecognizerDelegate,MBProgressHUDDelegate>
{
    NSArray *orgArray; //存贮组织机构数据
    MBProgressHUD *HUD;
}
@property(nonatomic) NSInteger  id; //上级传送过来的父栏目id
@property (nonatomic) NSInteger orgID;  //组织机构的栏目id
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRight;

@property (weak, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeft;
@property (strong, nonatomic) IBOutlet UITabBarItem *leaderItem;
@property (strong, nonatomic) IBOutlet UITabBarItem *administrativeItem;
@property (strong, nonatomic) IBOutlet UITabBarItem *orgItem;


@end
