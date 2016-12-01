//
//  LoadingImageview.h
//  XiRen
//
//  Created by PIPI on 15/9/11.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImage+GIF.h>

@interface LoadingImageview : UIImageView
{
    UIImage *loadingIMG;
}

@property (strong,nonatomic) UIImage *loadingIMG;

-(UIImage *)initloadingImg;
@end
