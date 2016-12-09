//
//  NetWork.m
//  wanteng
//
//  Created by mrz on 2016/12/6.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork

//block 取返回值，我把你要的方法篮子给你 你给我把数据装进（方法篮子）里面 ，我返回去给我爹(需要用数据的对象)用
+(void)byGet:(NSString*)url dic:(NSDictionary*)dic Succed:(Success)succed failure:(Failure)failure{
    [self Manager:url Method:@"Get" parameterDic:dic requestSucced:^(id responseObject){
        succed(responseObject);
    }requestFailure:^(NSError *error){
        failure(error);
    }];
}

+(void)byPost:(NSString*)url dic:(NSDictionary*)dic Succed:(Success)succed failure:(Failure)failure{
    [self Manager:url Method:@"Post" parameterDic:dic requestSucced:^(id responseObject) {
        succed(responseObject);
    } requestFailure:^(NSError *error) {
        failure(error);
    }];
}

+(void)byGet:(NSString *)url dic:(NSDictionary *)dic withBlock:(void (^)(NSArray *needArray,NSError *error))block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    manager.responseSerializer  = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
    [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress){
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *json =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]; //解析json数据
        if (block) {
            block(json,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败:%@", error.description);
        if (block) {
            block([NSArray array],error);
        }
        
    }];

}
-(void)byGet:(NSString *)url dic:(NSDictionary *)dic withBlock:(void (^)(NSArray *needArray,NSError *error))block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    manager.responseSerializer  = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
    [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress){
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *json =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]; //解析json数据
        if (block) {
            block(json,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败:%@", error.description);
        if (block) {
            block([NSArray array],error);
        }
        
    }];
}


+(void)Manager:(NSString*)url Method:(NSString*)Method parameterDic:(NSDictionary*)parameterDic requestSucced:(Success)Succed requestFailure:(Failure)Failured{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    manager.responseSerializer  = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/json", @"text/javascript",@"text/html", nil];
    
    if([Method isEqualToString:@"Get"]){
        //    [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //如果传送的参数里面有中文的话，需要编码成utf8
        [manager GET:url parameters:parameterDic progress:^(NSProgress * _Nonnull downloadProgress){
            
            NSLog(@"进度:%lld", downloadProgress.totalUnitCount);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"请求成功:%@", responseObject);
            id json =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]; //解析json数据
            Succed(json);
            
            //        NSLog(@"网络请求成功JSON:%@", _recipes);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"请求失败:%@", error.description);
            Failured(error);
            
        }];

    }else{
        //注意！如果传送的参数里面有中文的话，需要编码成utf8
        [manager POST:url parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
            
            NSLog(@"进度:%lld", uploadProgress.totalUnitCount);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            id json =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]; //解析json数据
            Succed(json);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"请求失败:%@", error.description);
            Failured(error);

        }];
    }
    
    
}

@end
