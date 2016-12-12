//
//  FirstViewController.h
//  wanteng
//
//  Created by mrz on 2016/11/30.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingImageview.h"
#import "NewsListCell.h"
#import "AFNetworking/AFNetworking.h"
#import "ContentViewController.h"
#import "TransDate.h"
#import "SDwebImage.h"
#import "LoadingImageview.h"
#import "NetWork.h"
#import "SGLoadMoreView.h"

@interface FirstViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate>{
    int startPage; //开始的页面
    int siteID;    //网站的id
}

@property (weak, nonatomic) IBOutlet UIScrollView *foucsScroll;

//8个按钮
@property (weak, nonatomic) IBOutlet UIButton *newsButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIButton *yjManageButton;
@property (weak, nonatomic) IBOutlet UIButton *govFilesButton;
@property (weak, nonatomic) IBOutlet UIButton *sangongButton;
@property (weak, nonatomic) IBOutlet UIButton *jingjiButton;
@property (weak, nonatomic) IBOutlet UIButton *vipOrgButton;
@property (weak, nonatomic) IBOutlet UIButton *cityManageButton;
@property (weak, nonatomic) IBOutlet UIButton *unitManageButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;

//4个按钮
@property (weak, nonatomic) IBOutlet UIButton *historyButton;
@property (weak, nonatomic) IBOutlet UIButton *adminAreaButton;
@property (weak, nonatomic) IBOutlet UIButton *nationButton;
@property (weak, nonatomic) IBOutlet UIButton *areaButton;
@property (weak, nonatomic) IBOutlet UIImageView *backgroudIMG;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (strong,nonnull)  SGLoadMoreView *loadMoreView;

@property (strong,nonatomic) NSMutableArray *recipes;
@property (nonatomic) NSInteger ScroolCount;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSMutableArray *ScroolImageArray;
@property (nonatomic,retain) UIImage *lodingIMG;
@end

