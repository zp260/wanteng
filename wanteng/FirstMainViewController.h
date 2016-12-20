//
//  FirstMainViewController.h
//  wanteng
//
//  Created by mrz on 2016/12/19.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftTableViewControllerDelegate.h"
// 对协议进行提前声明
@protocol LeftTableViewControllerDelegate;
@interface FirstMainViewController : UIViewController <LeftTableViewControllerDelegate>
// 左半边 (显示 的是栏目列表 )
@property (weak,nonatomic) IBOutlet UIView *leftView;
// 最上面,最大的全屏的是主视图
@property (weak, nonatomic) IBOutlet UIView *mainView;
// mainView的下半部分 是 正文的view,显示子栏目的view
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBtn;

// pan 拽 手势处理
- (IBAction)panGesture:(UIPanGestureRecognizer *)sender;

// mainView的上半部分 标题状态栏视图中的左,右按钮
- (IBAction)btnClick:(UIButton *)sender;
@end
