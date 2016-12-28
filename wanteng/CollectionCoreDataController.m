//
//  CollectionCoreDataController.m
//  
//
//  Created by mrz on 2016/12/23.
//
//

#import "CollectionCoreDataController.h"
#import "Collection+CoreDataClass.h"

static NSString * const modelName  = @"CollectionModel";
static NSString * const entityName = @"Collection";
static NSString * const sqliteName = @"CollectionModel.sqlite";

@interface CollectionCoreDataController()

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
    
    self.coreDataApi = [[CoreDataAPI alloc] initWithCoreData:self.coreDataEntityName modelName:self.coreDataModelName sqlPath:self.coreDataSqlPath success:^{
        NSLog(@"initCoreData success");
    } fail:^(NSError *error) {
        NSLog(@"initCoreData fail");
    }];
    
}
#pragma mark - -- 插入记录
- (void)insertModel:(Article *)model success:(void(^)(void))success fail:(void(^)(NSError *error))fail
{
    NSLog(@"%@",model);
    NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInt:model.Id],@"articleId",model.Title,@"title",model.Source,@"source",model.Thumb,@"thumb",[NSNumber numberWithInt:model.Hits],@"hits",model.Date,@"articleDate", nil];

    //NSDictionary *dict = NSDictionaryOfVariableBindings(source,articleId,articleDate,thumb,hits,title);

    
    [self.coreDataApi insertNewEntity:dict success:^{
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
    NSString *filterStr = [NSString stringWithFormat:@"articleId = %d AND articleSource = '%@' AND articleDate = '%@'",model.articleId,model.source,model.articleDate];
    [self.coreDataApi readEntity:nil ascending:YES filterStr:filterStr success:^(NSArray *results,NSEntityDescription *entity,NSManagedObjectContext *context) {
        if (results.count>0) {
            NSManagedObject *obj = [results firstObject];
            //更新数据
            //[obj setValue:[NSNumber numberWithBool:model.finishStatus] forKey:@"finishStatus"];
            //通知更新
            [self.coreDataApi updateEntity:^{
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

#pragma mark - -- 删除指定条件记录
- (void)deleteModel:(Collection *)model success:(void(^)(void))success fail:(void(^)(NSError *error))fail
{
    NSString *filterStr = [NSString stringWithFormat:@"articleId = %d",model.articleId];
    [self.coreDataApi readEntity:nil ascending:YES filterStr:filterStr success:^(NSArray *results,NSEntityDescription *entity,NSManagedObjectContext *context) {
        if (results.count>0) {
            NSManagedObject *obj = [results firstObject];
            [self.coreDataApi deleteEntity:obj success:^{
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
    [self.coreDataApi readEntity:nil ascending:YES filterStr:nil success:^(NSArray *results,NSEntityDescription *entity,NSManagedObjectContext *context) {
        for (NSManagedObject *obj in results){
            [self.coreDataApi deleteEntity:obj success:^{
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
- (void)readAllModel:(NSString *)filter success:(void(^)(NSArray *finishArray))success fail:(void(^)(NSError *error))fail
{
    [self.coreDataApi readEntity:nil ascending:YES filterStr:filter success:^(NSArray *results,NSEntityDescription *entity,NSManagedObjectContext *context) {
        if(results.count>0){
            NSMutableArray *finishArray = [NSMutableArray array];
            for (NSManagedObject *obj in results) {
                
                Collection *model = [[Collection alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
                // 获取数据库中各个键值的值
                model.source      = [obj valueForKey:@"source"];
                model.articleDate = [obj valueForKey:@"articleDate"];
                model.articleId   = [[obj valueForKey:@"articleId"]intValue];
                model.thumb       = [obj valueForKey:@"thumb"];
                model.title       = [obj valueForKey:@"title"];
                model.hits        = [[obj valueForKey:@"hits"]intValue];
                NSLog(@"取到的Model%@",model);
                if (model.articleId) {
                    [finishArray addObject:model];
                }
            }
        
        if (success) {
            success(finishArray);
        }
            }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
        
    }];
}@end
