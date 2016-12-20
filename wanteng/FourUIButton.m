//
//  FourUIButton.m
//  wanteng
//
//  Created by mrz on 2016/12/20.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "FourUIButton.h"

@implementation FourUIButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init{
    self = [super init];
    if (self) {
        
        _theNewBgImg = [[UIImageView alloc]init];
        _topLabe = [[UILabel alloc]init];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, self.titleLabel.top, self.width, self.titleLabel.height);
    self.titleLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
