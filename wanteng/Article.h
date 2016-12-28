//
//  Article.h
//  wanteng
//
//  Created by mrz on 2016/12/27.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (nonatomic)        int       Id;
@property (nonatomic,strong) NSString *Title;
@property (nonatomic,strong) NSString *Thumb;
@property (nonatomic,strong) NSString *Source;
@property (nonatomic,strong) NSString *Date;
@property (nonatomic)        int       Hits;

@end
