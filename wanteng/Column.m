//
//  Column.m
//  wanteng
//
//  Created by mrz on 2016/12/19.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "Column.h"

@implementation Column
// 返回一个包含了 栏目对应控制器名字的 对象实例
+(Column*)columnNamed:(NSString*)columnName imgName:(NSString*)columnImgName className:(NSString*)columnClassName{
    Column *column = [[self alloc]init];
    column.columnName = columnName;
    column.columnImgName = columnImgName;
    column.columnClassName = columnClassName;
    return column;
}
@end
