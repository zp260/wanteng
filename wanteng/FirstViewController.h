//
//  FirstViewController.h
//  wanteng
//
//  Created by mrz on 2016/11/30.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scroolView;

//8个按钮
@property (strong, nonatomic) IBOutlet UIButton *newsButton;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) IBOutlet UIButton *yjManageButton;
@property (strong, nonatomic) IBOutlet UIButton *govFilesButton;
@property (strong, nonatomic) IBOutlet UIButton *sangongButton;
@property (strong, nonatomic) IBOutlet UIButton *jingjiButton;
@property (strong, nonatomic) IBOutlet UIButton *vipOrgButton;
@property (strong, nonatomic) IBOutlet UIButton *cityManageButton;
@property (strong, nonatomic) IBOutlet UIButton *unitManageButton;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;

//4个按钮
@property (strong, nonatomic) IBOutlet UIButton *historyButton;
@property (strong, nonatomic) IBOutlet UIButton *adminAreaButton;
@property (strong, nonatomic) IBOutlet UIButton *nationButton;
@property (strong, nonatomic) IBOutlet UIButton *areaButton;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSArray *recipes;
@end

