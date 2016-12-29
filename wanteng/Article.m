//
//  Article.m
//  wanteng
//
//  Created by mrz on 2016/12/27.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "Article.h"

@implementation Article
-(instancetype)initWithColletion:(Collection*)collection{
    if(self=[super init]){
        if (collection) {
            self.Id = [[collection valueForKey:@"articleId"]intValue];
            self.Title = [collection valueForKey:@"title"];
            self.Thumb = [collection valueForKey:@"thumb"];
            self.Source = [collection valueForKey:@"source"];
            self.Date = [collection valueForKey:@"articleDate"];
            self.Hits = [[collection valueForKey:@"hits"]intValue];
        }
    }
    return self;
}
@end
