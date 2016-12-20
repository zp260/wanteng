//
//  Column.h
//  wanteng
//
//  Created by mrz on 2016/12/19.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Column : NSObject

//栏目名称
@property (nonatomic,copy) NSString *columnName;
//栏目图片名称
@property (nonatomic,copy) NSString *columnImgName;
//栏目对应的控制器的类名
@property (nonatomic,copy) NSString *columnClassName;

// 提供一个类方法,即构造函数,返回封装好数据的对象(返回id亦可)
+(Column*)columnNamed:(NSString*)columnName imgName:(NSString*)columnImgName className:(NSString*)columnClassName;

@end
