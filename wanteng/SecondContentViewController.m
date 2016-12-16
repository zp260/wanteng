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
    [_tabBar setSelectedItem:_leaderItem];//初始化选择第一个tab
}
//获取组织机构id
-(void)getOrgID{
    //HUD
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.bezelView.alpha = 0.5;
    HUD.bezelView.color = [UIColor clearColor];
    HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    HUD.label.text = @"读取组织机构数据";
    HUD.detailsLabel.text = @"loading...";
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@%ld",SiteUrl,@"/mobile/type/",(long)_id];
    
    NetWork *work = [[NetWork alloc]init];
    [work byGet:url dic:nil withBlock:^(NSArray *needArray, NSError *error) {
        if (!error) {
           _orgID =  [[[needArray objectAtIndex:0]valueForKey:@"id"] integerValue];
            HUD.removeFromSuperViewOnHide = YES;
            [HUD hideAnimated:YES afterDelay:0];
            [self getOrgList];
            
        }
    }];
}
//获取组织机构栏目列表
-(void)getOrgList{
    HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    HUD.label.text = @"读取栏目数据";
    HUD.detailsLabel.text = @"loading...";
    NSInteger siteID = 2;
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@%ld%@%ld",SiteUrl,@"/mobile/article/list/",(long)siteID,@"/0/3?tid=",(long)_orgID];
    
    NetWork *work = [[NetWork alloc]init];
    [work byGet:url dic:nil withBlock:^(NSArray *needArray, NSError *error) {
        if (!error) {
            orgArray =  needArray;
            [self matching:@"领导设置"];
            HUD.removeFromSuperViewOnHide = YES;
            [HUD hideAnimated:YES afterDelay:0];
        }
    }];
}

-(void)loadWebContent:(NSNumber *)contentID{
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;
    HUD.bezelView.color = [UIColor clearColor];
    HUD.bezelView.alpha = 0.5;
    HUD.label.text = @"loading...";
    NSString* Url = [NSString stringWithFormat:@"%@%@%ld",SiteUrl,@"/mobile/chapter/",(long)[contentID integerValue]];
    NetWork *work = [[NetWork alloc]init];
    [work byGet:Url dic:nil withBlock:^(NSArray *needArray, NSError *error) {
        if (!error) {
            NSArray *contentArray =  needArray;
            NSString *html = [[contentArray objectAtIndex:0] valueForKey:@"content"];
            html = [ImgSrcFix fixedImageSrcHtml:html];
            [_webview loadHTMLString:html baseURL:nil];
            HUD.removeFromSuperViewOnHide = YES;
            [HUD hideAnimated:YES afterDelay:0];
        }else{
            HUD.mode = MBProgressHUDModeText;
            HUD.label.text = @"网络链接出错";
            HUD.removeFromSuperViewOnHide = YES;
            [HUD hideAnimated:YES afterDelay:2];
        }
    }];

}

-(void)matching:(NSString*)title{
    if(orgArray.count>0){
        for (NSDictionary *dic  in orgArray){
            if ([[dic objectForKey:@"title"] isEqualToString:title]) {
                [self loadWebContent:[dic valueForKey:@"id"]];
            }else{
                [_webview loadHTMLString:@"无内容" baseURL:nil];
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
#pragma mark-手势代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if(_swipeRight == gestureRecognizer || _swipeLeft == gestureRecognizer){
        return YES;
    }
    return NO;
}
- (IBAction)swipeRight:(id)sender {
    NSInteger selectedTag = _tabBar.selectedItem.tag;
    switch (selectedTag) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            [_tabBar setSelectedItem:_leaderItem];
            [self tabBar:_tabBar didSelectItem:_leaderItem];
            break;
        case 2:
            [_tabBar setSelectedItem:_administrativeItem];
            [self tabBar:_tabBar didSelectItem:_administrativeItem];
            break;
        default:
            break;
    }
}
- (IBAction)swipeLeft:(id)sender {
    NSInteger selectedTag = _tabBar.selectedItem.tag;
    switch (selectedTag) {
        case 0:
            [_tabBar setSelectedItem:_administrativeItem];
            [self tabBar:_tabBar didSelectItem:_administrativeItem];
            break;
        case 1:
            [_tabBar setSelectedItem:_orgItem];
            [self tabBar:_tabBar didSelectItem:_orgItem];
            break;
        case 2:
            break;
        default:
            break;
    }
}

#pragma mark HUD的代理方法,关闭HUD时执行
-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}

@end
