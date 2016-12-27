//
//  CollectionCoreDataController.h
//  
//
//  Created by mrz on 2016/12/23.
//
//

#import <Foundation/Foundation.h>
#import "CoreDataAPI.h"
#import "Collection+CoreDataClass.h"

@class Collection;
@interface CollectionCoreDataController : NSObject
/**
 *  上传数据库模型名称
 */
@property (nonatomic,copy,readonly) NSString *coreDataModelName;
/**
 *  上传数据库实体名称
 */
@property (nonatomic,copy,readonly) NSString *coreDataEntityName;
/**
 *  上传数据库存储路径
 */
@property (nonatomic,copy,readonly) NSString *coreDataSqlPath;
+ (instancetype)sharedInstance;
/**
 *  插入上传记录
 *
 *  @param model   数据模型
 *  @param success 成功回调
 *  @param fail    失败回调
 */
- (void)insertModel:(Collection *)model success:(void(^)(void))success fail:(void(^)(NSError *error))fail;

/**
 *  更新上传记录
 *
 *  @param model   数据模型
 *  @param success 成功回调
 *  @param fail    失败回调
 */
- (void)updateModel:(Collection *)model success:(void(^)(void))success fail:(void(^)(NSError *error))fail;

/**
 *  删除一条上传记录
 *
 *  @param model   数据模型
 *  @param success 成功回调
 *  @param fail    失败回调
 */
- (void)deleteModel:(Collection *)model success:(void(^)(void))success fail:(void(^)(NSError *error))fail;

/**
 *  删除所有上传记录
 *
 *  @param success 成功回调
 *  @param fail    失败回调
 */
- (void)deleteAllModel:(void(^)(void))success fail:(void(^)(NSError *error))fail;

/**
 *  查询数据库所有数据
 *
 *  @param success 成功回调（finishArray：已完成（DownLoadModel对象数组） unfinishedArray：未完成（DownLoadModel对象数组））
 *  @param fail    失败回调
 */
- (void)readAllModel:(void(^)(NSArray *finishArray))success fail:(void(^)(NSError *error))fail;
@end
