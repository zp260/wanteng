//
//  TLWindow.h
//  LeftSwipDemo
//
//  Created by tianlei on 16/11/4.
//  Copyright © 2016年 tianlei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLWindow : UIWindow

@property (nonatomic, copy) void (^selectIndex)(NSInteger);

@property (nonatomic, strong) UIView *boredView;

@end
