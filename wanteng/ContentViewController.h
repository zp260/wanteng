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
#import "ImgSrcFix.h"
#import <CoreData/CoreData.h>
#import "Collection+CoreDataClass.h"
#import "Article.h"

@interface ContentViewController : UIViewController<UIGestureRecognizerDelegate,UIWebViewDelegate,NSFetchedResultsControllerDelegate>
{
    NSArray *contentArray;
    NSInteger fontSizeChangeTimes;
}
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *contenTitle;
@property (weak, nonatomic) IBOutlet UILabel *date_source;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipRight;

@property (weak, nonatomic) IBOutlet UIButton *collectionBt;

@property (strong,nonatomic) NSNumber* id;
@property (strong,nonatomic) Article *article;

-(instancetype)initWithArticle;
@end
