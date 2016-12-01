//
//  FirstViewController.h
//  wanteng
//
//  Created by mrz on 2016/11/30.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingImageview.h"
@interface FirstViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scroolView;
@property (strong, nonatomic) IBOutlet UIScrollView *foucsScroll;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *searchBt;

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
@property (nonatomic) NSInteger ScroolCount;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSMutableArray *ScroolImageArray;
@property (nonatomic,retain) UIImage *lodingIMG;
@end

