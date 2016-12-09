//
//  SecondContentViewController.m
//  wanteng
//
//  Created by mrz on 2016/12/7.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "SecondContentViewController.h"

@interface SecondContentViewController ()

@end

@implementation SecondContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_webview loadHTMLString:@"无内容" baseURL:nil];
    // Do any additional setup after loading the view from its nib.
    [self getOrgID];
}
//获取组织机构id
-(void)getOrgID{
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@%ld",SiteUrl,@"/mobile/type/",(long)_id];
    
    NetWork *work = [[NetWork alloc]init];
    [work byGet:url dic:nil withBlock:^(NSArray *needArray, NSError *error) {
        if (!error) {
           _orgID =  [[[needArray objectAtIndex:0]valueForKey:@"id"] integerValue];
            [self getOrgList];
        }
    }];
}
//获取组织机构栏目列表
-(void)getOrgList{
    NSInteger siteID = 2;
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@%ld%@%ld",SiteUrl,@"/mobile/article/list/",(long)siteID,@"/0/3?tid=",(long)_orgID];
    
    NetWork *work = [[NetWork alloc]init];
    [work byGet:url dic:nil withBlock:^(NSArray *needArray, NSError *error) {
        if (!error) {
            orgArray =  needArray;
            [self matching:@"领导设置"];
            NSLog(@"orgArray=%@",orgArray);
        }
    }];
}

-(void)loadWebContent:(NSNumber *)contentID{
     NSString* Url = [NSString stringWithFormat:@"%@%@%ld",SiteUrl,@"/mobile/chapter/",(long)[contentID integerValue]];
    NetWork *work = [[NetWork alloc]init];
    [work byGet:Url dic:nil withBlock:^(NSArray *needArray, NSError *error) {
        if (!error) {
            NSArray *contentArray =  needArray;
            [_webview loadHTMLString:[[contentArray objectAtIndex:0] valueForKey:@"content"] baseURL:nil];
            NSLog(@"contentArray=%@",contentArray);
        }
    }];

}

-(void)matching:(NSString*)title{
    if(orgArray.count>0){
        for (NSDictionary *dic  in orgArray){
            if ([[dic objectForKey:@"title"] isEqualToString:title]) {
                [self loadWebContent:[dic valueForKey:@"id"]];
            }
        }
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark- tabbar delegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"itemTitle=%@,%ld",item.title,item.tag);
    [self matching:item.title];
}
@end
