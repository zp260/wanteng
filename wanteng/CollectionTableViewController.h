//
//  CollectionTableViewController.h
//  wanteng
//
//  Created by mrz on 2016/12/27.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionCoreDataController.h"
#import "NewsListCell.h"
#import "SDwebImage.h"
#import "LoadingImageview.h"
#import "TransDate.h"
#import "ContentViewController.h"

@interface CollectionTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource>
{
    
}

@property (nonatomic,retain) UIImage * _Nonnull lodingIMG;

@end
