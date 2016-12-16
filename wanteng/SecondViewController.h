//
//  SecondViewController.h
//  wanteng
//
//  Created by mrz on 2016/11/30.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking/AFNetworking.h"
#import "NetWork.h"
#import "SecondCollectionViewCell.h"
#import "SecondContentViewController.h"
#import "SecondCollectionReusableView.h"

@interface SecondViewController : UIViewController <UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSArray *contentArray;
    NSArray *classArray;
    NSMutableDictionary *SectionDic;
    NSArray *sectionTitleArray;
    NSInteger cellCounts; //记录cell的总数
}

@property (weak, nonatomic) IBOutlet UIScrollView *rootScroolView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;




@end

