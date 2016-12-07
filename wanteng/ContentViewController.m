//
//  ContentViewController.m
//  wanteng
//
//  Created by mrz on 2016/12/5.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    contentArray = [[NSArray alloc]init];
    [self getOnlineData];
    
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
        [_webView loadHTMLString:[dic objectForKey:@"content"] baseURL:nil];
        [self changeImgSrc];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)changeImgSrc{
    [_webView stringByEvaluatingJavaScriptFromString:@"var script = document.createElement('script');"
    "script.type = 'text/javascript';"
    "script.text = \"function changeImgSrc() { "
    
    "var oldSrc;"

    "for(i=0;i <document.images.length;i++){"
    
    "myimg = document.images[i];"
    
    "oldSrc = myimg.src;"
    
    "myimg.src = \"http://www.dtcqzf.gov.cn\"+oldSrc ;"
    
    "}"
    
    "}\";"
    
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    [_webView stringByEvaluatingJavaScriptFromString:@"changeImgSrc();"];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
