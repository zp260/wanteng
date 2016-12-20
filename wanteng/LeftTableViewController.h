//
//  LeftTableViewController.h
//  wanteng
//
//  Created by mrz on 2016/12/19.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LeftTableViewControllerDelegate;

@interface LeftTableViewController : UITableViewController

// 代理 用weak,防止循环问题,可以是任意类型,但必须遵守协议
@property (nonatomic,weak) id<LeftTableViewControllerDelegate>delegate;

@end
