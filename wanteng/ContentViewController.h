//
//  ContentViewController.h
//  wanteng
//
//  Created by mrz on 2016/12/5.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking/AFNetworking.h"
#import "TransDate.h"

@interface ContentViewController : UIViewController
{
    NSArray *contentArray;
}
@property (weak, nonatomic) IBOutlet UILabel *contenTitle;
@property (weak, nonatomic) IBOutlet UILabel *date_source;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong,nonatomic) NSNumber* id;
@end
