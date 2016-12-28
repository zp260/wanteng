//
//  ContentViewController.m
//  wanteng
//
//  Created by mrz on 2016/12/5.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@property (nonatomic,strong) CollectionCoreDataController *coreDataController;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    contentArray = [[NSArray alloc]init];
    fontSizeChangeTimes = 100;
    [self getOnlineData];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    colletionState = NO;
    [self initCoreData];
    [self searchData];
    
    

    
}
-(instancetype)initWithArticle{
    if(!self.article){
        self.article = [[Article alloc]init];
    }
    return self;
}
-(void)initCoreData{
    _coreDataController = [[CollectionCoreDataController sharedInstance]init];
}
-(void)getOnlineData{
    NSString* Url = [NSString stringWithFormat:@"%@%d",@"http://www.dtcqzf.gov.cn/mobile/chapter/",self.article.Id] ;
    
        //    [articleListUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //如果传送的参数里面有中文的话，需要这样编码
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
        manager.responseSerializer  = [AFHTTPResponseSerializer serializer];
        
        [manager GET:Url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            contentArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            [self refresh];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败:%@", error.description);
        }];
    

}
-(void)refresh{
    if (contentArray.count > 0 ) {
        NSDictionary *dic = [contentArray firstObject];
        _contenTitle.text = [dic objectForKey:@"title"];
        _contenTitle.text = self.article.Title;
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
        NSString *jsString =[NSString stringWithFormat:@"%@%ld%@", @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '",(long)fontSizeChangeTimes,@"%'"];
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
- (IBAction)collect:(id)sender {
    [self changeColletionState];
}
//查询数据库，如果已经收藏显示 已收藏状态
-(void)searchData{
    NSString *filter = [NSString stringWithFormat:@"articleId == %d",self.article.Id];
    CollectionCoreDataController  *Controller = [[CollectionCoreDataController sharedInstance]init];
    [Controller readAllModel:filter success:^(NSArray *finishArray) {
        if (finishArray.count>0) {
            colletionState = YES;
            [_collectionBt setImage:[UIImage imageNamed:@"ic_star_1"] forState:UIControlStateNormal];
        }
    } fail:^(NSError *error) {
        
    }];
}
-(void)changeColletionState{
        if(colletionState){
            NSFetchRequest* request=[[NSFetchRequest alloc] init];
            NSEntityDescription* collection=[NSEntityDescription entityForName:self.coreDataController.coreDataEntityName inManagedObjectContext:self.coreDataController.coreDataApi.context];
            [request setEntity:collection];
            NSPredicate* predicate=[NSPredicate predicateWithFormat:@"articleId == %d",self.article.Id];
            [request setPredicate:predicate];
            NSError* error=nil;
            NSMutableArray* mutableFetchResult=[[self.coreDataController.coreDataApi.context executeFetchRequest:request error:&error] mutableCopy];
            if (mutableFetchResult==nil) {
                NSLog(@"Error:%@",error);
            }
            NSLog(@"The count of entry: %lu",(unsigned long)[mutableFetchResult count]);
            for (Collection* ct in mutableFetchResult) {
                [self.coreDataController.coreDataApi.context deleteObject:ct];
                colletionState = NO;
                [_collectionBt setImage:[UIImage imageNamed:@"ic_star_0"] forState:UIControlStateNormal];
            }
            
            if ([self.coreDataController.coreDataApi.context save:&error]) {
                NSLog(@"Error:%@,%@",error,[error userInfo]);  
            }
        }else{
            [_coreDataController insertModel:self.article success:^{
                colletionState = YES;
                [_collectionBt setImage:[UIImage imageNamed:@"ic_star_1"] forState:UIControlStateNormal];
            } fail:^(NSError *error) {
                
            }];
        }
}
@end
