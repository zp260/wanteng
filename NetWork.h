//
//  NetWork.h
//  wanteng
//
//  Created by mrz on 2016/12/6.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking/AFNetworking.h"

typedef void(^Success)(id responseObject);
typedef void(^Failure)(NSError *error);

@interface NetWork : NSObject

@property (nonatomic,copy) Success requestSuccess; // 请求成功
@property (nonatomic,copy) Failure requestFailure; //请求失败

+(void)byGet:(NSString*)url dic:(NSDictionary*)dic Succed:(Success)succed failure:(Failure)failure; //get请求
+(void)byPost:(NSString*)url dic:(NSDictionary*)dic Succed:(Success)succed failure:(Failure)failure; //post请求
+(void)byGet:(NSString *)url dic:(NSDictionary *)dic withBlock:(void (^)(NSArray *needArray,NSError *error))block; //get并通知

-(void)byGet:(NSString *)url dic:(NSDictionary *)dic withBlock:(void (^)(NSArray *needArray,NSError *error))block;
@end
