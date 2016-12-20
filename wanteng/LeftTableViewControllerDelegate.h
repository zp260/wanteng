//
//  LeftTableViewControllerDelegate.h
//  wanteng
//
//  Created by mrz on 2016/12/19.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Column.h"
// 左边控制器 定义的代理/协议 它通过调用自己的成员属性(即代理)的该方法,将数据传递出去(给它的代理去使用) (其实 是主控制器想要数据,所以主控制器在实例化左边控制器的时候,要设置左边控制器对应的代理 为 主控制器 自身)
@protocol LeftTableViewControllerDelegate <NSObject>

-(void)leftTableViewRowClicked:(Column*)columnSelected;

@end

@interface LeftTableViewControllerDelegate : NSObject


@end
