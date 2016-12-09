//
//  ThirdViewController.h
//  wanteng
//
//  Created by mrz on 2016/12/7.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondCollectionViewCell.h"

@interface ThirdViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *weathImage;
@property (weak, nonatomic) IBOutlet UILabel *weathText;
@property (weak, nonatomic) IBOutlet UILabel *oCtext;   //风力
@property (weak, nonatomic) IBOutlet UILabel *windText; //风力
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;



@end
