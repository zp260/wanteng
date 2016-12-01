//
//  LoadingImageview.m
//  XiRen
//
//  Created by PIPI on 15/9/11.
//  Copyright (c) 2015年 zhuping. All rights reserved.
//

#import "LoadingImageview.h"

@implementation LoadingImageview

@synthesize loadingIMG;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIImage *)initloadingImg
{
    NSString  *name = @"loading1.gif";
    
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
    
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    
    
    if(self.loadingIMG)
    {
        return self.loadingIMG;
    }
    else
    {
        self.loadingIMG = [UIImage sd_animatedGIFWithData:imageData];
        return self.loadingIMG;
    }
    
}

@end
