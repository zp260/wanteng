//
//  TLWindow.m
//  LeftSwipDemo
//
//  Created by tianlei on 16/11/4.
//  Copyright © 2016年 tianlei. All rights reserved.
//

#import "TLWindow.h"

@interface TLWindow ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end


@implementation TLWindow

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initData];
    }
    return self;
}

- (void)initData{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, -[UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
}

- (UIView *)boredView{
    if (!_boredView) {
        _boredView = [[UIView alloc] initWithFrame:self.bounds];
        _boredView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [_boredView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    }
    return _boredView;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint tempoint = [_tableView convertPoint:point fromView:self];
        if (CGRectContainsPoint(_tableView.bounds, tempoint))
        {
            view = _tableView;
        }
    }
    return view;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Test"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"控制器%zd",indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformIdentity;
        [self.boredView removeFromSuperview];
    }];
    if(self.selectIndex){
        self.selectIndex(indexPath.row);
    }
}

- (void)dismiss{
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformIdentity;
        [self.boredView removeFromSuperview];
    }];
    
    if(self.selectIndex){
        self.selectIndex(-1);
    }
}
@end
