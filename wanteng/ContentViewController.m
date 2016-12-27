//
//  ContentViewController.m
//  wanteng
//
//  Created by mrz on 2016/12/5.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@property (nonatomic,strong) NSManagedObjectContext *collectionMOC;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    contentArray = [[NSArray alloc]init];
    fontSizeChangeTimes = 100;
    [self getOnlineData];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self searchData];
    
}
-(void)getOnlineData{
    NSString* Url = [NSString stringWithFormat:@"%@%@",@"http://www.dtcqzf.gov.cn/mobile/chapter/",_id] ;
    
        //    [articleListUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //如果传送的参数里面有中文的话，需要这样编码
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        manager.responseSerializer  = [AFHTTPResponseSerializer serializer];
        
        [manager GET:Url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"进度:%lld", downloadProgress.totalUnitCount);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            contentArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            [self refresh];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败:%@", error.description);
        }];
    

}
-(void)refresh{
    if (contentArray.count > 0 ) {
        NSDictionary *dic = [contentArray objectAtIndex:0];
        _contenTitle.text = [dic objectForKey:@"title"];
        _date_source.text = [NSString stringWithFormat:@"%@    %@",[dic objectForKey:@"source"],[TransDate TimeStamp:[[dic objectForKey:@"createTime"] stringValue]]];
        
        NSString *html = [dic objectForKey:@"content"];
        html = [ImgSrcFix fixedImageSrcHtml:html withImgWidth:_webView.width];
        [_webView loadHTMLString:html baseURL:nil];
        
        self.title = [dic objectForKey:@"title"];
        
        //[self changeImgSrc];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)changeImgSrc{
    
    [_webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
     
    "script.type = 'text/javascript';"
     
    "script.text = \"function changeImgSrc(){"
    
    "var oldSrc;"

    "for(i=0;i <document.images.length;i++){"
    
    "myimg = document.images[i];"
    
    "oldSrc = myimg.src.replace(\"file://\",\"\");"
    
    "myimg.src = \"http://www.dtcqzf.gov.cn\"+oldSrc;"
    
    "}"
    
    "}\";"];
    
    [_webView stringByEvaluatingJavaScriptFromString:@"changeImgSrc();"];
    
    [_webView reload];
 
    
}
#pragma mark- 手势相关
- (IBAction)swipeRight:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if(_swipRight == gestureRecognizer){
        return YES;
    }
    return NO;
}

#pragma mark - 按钮相关
- (IBAction)changeFont:(id)sender {
    
    if (fontSizeChangeTimes>200) {
        [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];
        fontSizeChangeTimes = 100;
    }
    else{
        fontSizeChangeTimes+=50;
        NSString *jsString =[NSString stringWithFormat:@"%@%ld%@", @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '",fontSizeChangeTimes,@"%'"];
        [_webView stringByEvaluatingJavaScriptFromString:jsString];
    }
    
}


- (IBAction)share:(id)sender {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma  mark - coredata
-(NSManagedObjectContext *)contextWithModelName:(NSString*)modelName{
    // 创建上下文对象，并发队列设置为主队列
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    // 创建托管对象模型，并使用modelName.momd路径当做初始化参数
    NSURL *modelPath = [[NSBundle mainBundle]URLForResource:modelName withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelPath];
    
    // 创建持久化存储调度器
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    
    // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite",modelName];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    
    // 上下文对象设置属性为持久化存储器
    context.persistentStoreCoordinator = coordinator;
    return context;
}
-(NSManagedObjectContext *)collectionMOC{
    if(!_collectionMOC){
        _collectionMOC = [self contextWithModelName:@"CollectionModel"];
    }
    return _collectionMOC;
}

- (IBAction)collect:(id)sender {
    Collection *collection = [NSEntityDescription insertNewObjectForEntityForName:@"Collection" inManagedObjectContext:self.collectionMOC];
    collection.articleId = 1;
    collection.articleSource = @"来源";
    collection.articleDate = @"2015-10-10";
    NSError *err = nil;
    if (self.collectionMOC.hasChanges) {
        [self.collectionMOC save:&err];
    }
    if(err==nil){
        [_collectionBt setImage:[UIImage imageNamed:@"ic_star_1"] forState:UIControlStateNormal];
    }
}
//查询数据库，如果已经收藏显示 已收藏状态
-(void)searchData{
    
    // 建立获取数据的请求对象，指明操作的实体为Student
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Collection"];
    NSError *error = nil;
    
    // 创建模糊查询条件。这里设置的带通配符的查询，查询条件是结果包含lxz
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"articleSource LIKE %@",@"*来源*"];
    request.predicate = predicate;
    
    NSArray *collection = [self.collectionMOC executeRequest:request error:&error];
    NSString *filter = @"articleId = 1";
    [self readEntity:nil ascending:YES filterStr:filter success:^(NSArray *results) {
        for(NSManagedObject *obj in results){
            NSLog(@"%@",[obj valueForKey:@"articleSource"]);
        }
        if (results.count>0) {
            NSManagedObject *obj = [results firstObject];
            NSLog(@"%@",[obj valueForKey:@"articleId"]);
        }
    } fail:^(NSError *error) {
        if (error) {
            
        }
    }];
    //[collection enumerateObjectsUsingBlock:^(Collection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //    NSLog(@"Fuzzy Search Result Name : %@, Age : %hd", obj.articleSource, obj.articleId);
    //}];
    // 错误处理
    if (error) {
        NSLog(@"Fuzzy Search Data Error : %@", error);
    }
    /**
     模糊查询的关键在于设置模糊查询条件，除了上面的模糊查询条件，还可以设置下面三种条件
     */
    // 以lxz开头
    // NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"name BEGINSWITH %@", @"lxz"];
    // 以lxz结尾
    // NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"name ENDSWITH %@"  , @"lxz"];
    // 其中包含lxz
    // NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"name contains %@"  , @"lxz"];
    // 还可以设置正则表达式作为查找条件，这样使查询条件更加强大，下面只是给了个例子
    // NSString *mobile = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    // NSPredicate *predicate4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];

}
// 查询数据
- (void)readEntity:(NSArray *)sequenceKeys ascending:(BOOL)isAscending filterStr:(NSString *)filterStr success:(void(^)(NSArray *results))success fail:(void(^)(NSError *error))fail
{
    // 1.初始化一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    // 2.设置要查询的实体
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"Collection" inManagedObjectContext:self.collectionMOC];
    request.entity = desc;
    // 3.设置查询结果排序
    if (sequenceKeys&&sequenceKeys.count>0) { // 如果进行了设置排序
        NSMutableArray *array = [NSMutableArray array];
        for (NSString *key in sequenceKeys) {
            /**
             *  设置查询结果排序
             *  sequenceKey:根据某个属性（相当于数据库某个字段）来排序
             *  isAscending:是否升序
             */
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:isAscending];
            [array addObject:sort];
        }
        if (array.count>0) {
            request.sortDescriptors = array;// 可以添加多个排序描述器，然后按顺序放进数组即可
        }
    }
    // 4.设置条件过滤
    if (filterStr) { // 如果设置了过滤语句
        NSPredicate *predicate = [NSPredicate predicateWithFormat:filterStr];
        request.predicate = predicate;
    }
    // 5.执行请求
    NSError *error = nil;
    NSArray *objs = [self.collectionMOC executeFetchRequest:request error:&error]; // 获得查询数据数据集合
    if (error) {
        if (fail) {
            fail(error);
        }
    } else{
        if (success) {
            success(objs);
        }
    }
}

@end
