//
//  SecondCollectionReusableView.h
//  wanteng
//
//  Created by mrz on 2016/12/9.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;

@end
