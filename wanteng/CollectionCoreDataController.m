//
//  CollectionCoreDataController.m
//  
//
//  Created by mrz on 2016/12/23.
//
//

#import "CollectionCoreDataController.h"
static NSString * const modelName = @"CollectionModel";
static NSString * const entityName = @"Colletion";
static NSString * const sqliteName = @"CollectionModel.sqlite";

@interface CollectionCoreDataController()
@property (nonatomic,strong) CoreDataAPI *CollectionData;
@end

@implementation CollectionCoreDataController
static CollectionCoreDataController *CollectionCoreData = nil;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CollectionCoreData = [[CollectionCoreDataController alloc] init];
    });
    
    return CollectionCoreData;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (CollectionCoreData == nil) {
            CollectionCoreData = [super allocWithZone:zone];
        }
    });
    
    return CollectionCoreData;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initCoreData];
    }
    return self;
}

- (void)initCoreData
{
    _coreDataEntityName = entityName;
    _coreDataModelName = modelName;
    
    // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite",_coreDataModelName];
   // _coreDataSqlPath = [[[FileManager shardInstance] getDocumentPath] stringByAppendingPathComponent:sqliteName];
    
    _coreDataSqlPath = dataPath;
    self.CollectionData = [[CoreDataAPI alloc] initWithCoreData:self.coreDataEntityName modelName:self.coreDataModelName sqlPath:self.coreDataSqlPath success:^{
        NSLog(@"initUploadCoreData success");
    } fail:^(NSError *error) {
        NSLog(@"initUploadCoreData fail");
    }];
    
}
#pragma mark - -- 插入记录
- (void)insertModel:(Collection *)model success:(void(^)(void))success fail:(void(^)(NSError *error))fail
{
    NSString *articleSource = model.articleSource;
    NSInteger articleId = model.articleId;
    NSString *articleDate = model.articleDate;
    NSDictionary *dict = NSDictionaryOfVariableBindings(articleSource,articleId,articleDate);
    
    [self.CollectionData insertNewEntity:dict success:^{
        if (success) {
            success();
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

#pragma mark - -- 更新记录
- (void)updateModel:(Collection *)model success:(void(^)(void))success fail:(void(^)(NSError *error))fail
{
    NSString *filterStr = [NSString stringWithFormat:@"articleId = %d AND articleSource = '%@' AND articleDate = '%@'",model.articleId,model.articleSource,model.articleDate];
    [self.CollectionData readEntity:nil ascending:YES filterStr:filterStr success:^(NSArray *results) {
        if (results.count>0) {
            NSManagedObject *obj = [results firstObject];
            //更新数据
            //[obj setValue:[NSNumber numberWithBool:model.finishStatus] forKey:@"finishStatus"];
            //通知更新
            [self.CollectionData updateEntity:^{
                if (success) {
                    success();
                }
            } fail:^(NSError *error) {
                if (fail) {
                    fail(error);
                }
            }];
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

#pragma mark - -- 删除一条记录
- (void)deleteModel:(Collection *)model success:(void(^)(void))success fail:(void(^)(NSError *error))fail
{
    NSString *filterStr = [NSString stringWithFormat:@"articleId = %d",model.articleId];
    [self.CollectionData readEntity:nil ascending:YES filterStr:filterStr success:^(NSArray *results) {
        if (results.count>0) {
            NSManagedObject *obj = [results firstObject];
            [self.CollectionData deleteEntity:obj success:^{
                if (success) {
                    success();
                }
            } fail:^(NSError *error) {
                if (fail) {
                    fail(error);
                }
            }];
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

#pragma mark - -- 删除所有记录
- (void)deleteAllModel:(void(^)(void))success fail:(void(^)(NSError *error))fail
{
    [self.CollectionData readEntity:nil ascending:YES filterStr:nil success:^(NSArray *results) {
        for (NSManagedObject *obj in results){
            [self.CollectionData deleteEntity:obj success:^{
                if (success) {
                    success();
                }
            } fail:^(NSError *error) {
                if (fail) {
                    fail(error);
                }
            }];
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

#pragma mark - -- 查询所有记录
- (void)readAllModel:(void(^)(NSArray *finishArray))success fail:(void(^)(NSError *error))fail
{
    [self.CollectionData readEntity:nil ascending:YES filterStr:nil success:^(NSArray *results) {
        NSMutableArray *finishArray = [NSMutableArray array];
        NSMutableArray *unfinishedArray = [NSMutableArray array];
        for (NSManagedObject *obj in results) {
            Collection *model = [[Collection alloc] init];
            // 获取数据库中各个键值的值
            model.articleId = (int16_t) [obj valueForKey:@"articleId"];
            model.articleSource =[obj valueForKey:@"articleSource"];
            model.articleDate = [obj valueForKey:@"articleDate"];
            if (model.articleId) {
                [finishArray addObject:model];
            } else {
                [unfinishedArray addObject:model];
            }
            
        }
        if (success) {
            success(finishArray);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}
@end
