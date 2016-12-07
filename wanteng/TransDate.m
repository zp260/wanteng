//
//  TransDate.m
//  wanteng
//
//  Created by mrz on 2016/12/5.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "TransDate.h"

@implementation TransDate

//strTime  =  时间戳 ，此处接受为13位的时间戳
//return 转换好的时间格式 
+(NSString *)TimeStamp:(NSString *)strTime

{
    
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //因为时差问题要加8小时 == 28800 sec,此处接受为13位的时间戳
    NSTimeInterval time=[[strTime substringToIndex:10] doubleValue]+28800;
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //用[NSDate date]可以获取系统当前时间
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    
    //输出格式为：2010-10-27 10:22:13
    
    NSLog(@"%@",currentDateStr);
    
    //alloc后对不使用的对象别忘了release
    
    return currentDateStr;
    
}

@end
