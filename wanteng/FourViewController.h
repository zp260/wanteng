//
//  FourViewController.h
//  wanteng
//
//  Created by mrz on 2016/12/9.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsListCell.h"

@interface FourViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UIView *tableHeaderView;

@property (strong,nonatomic) NSArray *recipes;


@end
