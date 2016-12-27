//
//  FirstMainViewController.m
//  wanteng
//
//  Created by mrz on 2016/12/19.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "FirstMainViewController.h"
#import "LeftTableViewController.h"
#import "Column.h"
// 手势结束时的x
#define kEndX frame.origin.x
// 左view的宽度
#define kLeftWidth _leftView.frame.size.width



@interface FirstMainViewController ()
{
    // 手指按下的时候,记住,mainView的起始x
    CGFloat _startX;
    
    // 成员变量,记住左边控制器的实例
    LeftTableViewController *_leftVC;
    
    
    // 字典 ,记住所有实例化了 栏目的子控制器,避免每次都重新创建
    NSMutableDictionary *_columnViewControllers;
}

@end

@implementation FirstMainViewController
// 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 0 字典 ,记住所有实例化了 栏目的子控制器,避免每次都重新创建
    _columnViewControllers = [NSMutableDictionary dictionary];
    
    // 1,添加左边控制器的view到左边的view里面
    _leftVC = [[LeftTableViewController alloc]init];
    // 关键代码 为了拿到左边控制器的某一行被点击时候,对应的栏目数据模型对象,主控制器成为了左边控制器的代理,遵守了它定好的协议,实现了协议中的方法,从而拿到左边控制器被点击行号对应的数据模型对象
    _leftVC.delegate = self;
    _leftVC.view.frame = self.leftView.bounds;
    [self.leftView addSubview:_leftVC.view];
    // 3,第一次加载时候,就就应该显示新闻 子栏目的控制器到导航控制器,再将导航控制器的view添加到 mainView里面
    [self firstLoading];
}
// 自定义方法,第一次加载时候,就就应该显示新闻 子栏目的控制器到导航控制器,再将导航控制器的view添加到 mainView里面
- (void)firstLoading
{
        //主城区栏目
    Column * column = [Column columnNamed:@"城区" imgName:@"face" className:@"FirstViewController"];

    // 仅需手动调用一个 LeftViewController的代理 方法,leftTableViewRowClicked,传递一个新闻 子栏目即可
    [self leftTableViewRowClicked:column];
}
-(void)leftTableViewRowClicked:(Column*)columnSelected{
    Column *column = (Column*)columnSelected;
    // 1,关闭左边的控制=======================调用抽取出来的公共代码,设置mainView的x,参数是endX
    [self setmainViewX:0];
    
    self.navigationItem.title = column.columnName;
    
    // 根据栏目数据模型中的类名,实例化对应栏目的控制器,并且将其设置为导航控制器的根控制器,最后将导航控制器的view添加到mainView中,目的是方便设置导航条,以及,各控制器的跳转
    
    
    // 2,从缓存字典中取,如果子控制器字典有曾经创建过的子控制器,直接取出来用
    UIViewController *columnVC = _columnViewControllers[column.columnClassName];
    // 如果子控制器字典中没有保存过该栏目的控制器,才要创建子控制器
    if (columnVC == nil) {
        Class c = NSClassFromString(column.columnClassName);
        columnVC = [[c alloc]init];
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        columnVC = [story instantiateViewControllerWithIdentifier:@"first"];
        [self addChildViewController:columnVC];
        // 并且一定要将其放到 子控制器字典里面,存起来
        [_columnViewControllers setObject:columnVC forKey:column.columnClassName];
    }
    // 4,移除contentView中的正在显示的旧的子view
    if (_contentView.subviews.count > 0) {
        UIView *oldView = [_contentView subviews][0];
        [oldView removeFromSuperview];
    }
    // 5,最后将子控制器的view添加到contentView中,显示
    columnVC.view.frame = _contentView.bounds;
    [self.contentView addSubview:columnVC.view];
    NSLog(@"%@",self.contentView);
    // 在添加到mainView之前 ,先得到mainView导航控制器的子控制器,并将其移除(如果有的话),然后才将新的栏目对应的子控制器添加到导航控制器容器中,注意,这儿可以用字典 记住 所有的已经实例化出来 的栏目子控制器,这样就避免每次都alloc创建新的栏目子控制器,而是只需要根据类名,从字典取出上一次实例化了的同一栏目的子控制器即可
    _leftView.hidden = YES;
    
}
// 抽取出来的公共代码,设置mainView的x,参数是endX
- (void)setmainViewX:(CGFloat)endX
{
    CGRect frame = self.mainView.frame;
    frame.origin.x = endX;
    [UIView animateWithDuration:0.2 animations:^{
        self.mainView.frame=frame;
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// pan 拽 手势处理
- (IBAction)panGesture:(UIPanGestureRecognizer *)sender
{
    
    // 如果是刚按下的状态,则记住,mainView的起始x
    if (UIGestureRecognizerStateBegan == sender.state) {
        _startX = self.mainView.frame.origin.x;
    }
    
    
    // 平移拖动的距离
    CGPoint delta = [sender translationInView:_mainView];
    
    CGRect frame = self.mainView.frame;
    
    // 计算新的x值,并做健壮性判断
    kEndX = _startX + delta.x;
    
    // 1,限制最大拖动范围
    
    if (kEndX >= kLeftWidth) {
        kEndX = kLeftWidth;
    }
//    if (kEndX <= - kRightWidth) {
//        kEndX = - kRightWidth;
//    }
    // 2,由于 左view和右view在重叠,所以要隐藏其中的一个
    if (kEndX > 0) {
        // NSLog(@"--调用频率相当高--");
        //_rightView.hidden = YES;
        _leftView.hidden = NO;
    } else {
        //_rightView.hidden = NO;
        _leftView.hidden = YES;
    }
    
    
    if (UIGestureRecognizerStateEnded == sender.state) {
        
        // 手势结束的时候,需进行robust判断
        
        // 2,分析end松手时候,的位置x,决定展开到什么程度
        /*
         // 2.1 如果只向右拖了一点点,小于 1/2 的左view的宽度,则归0
         if (kEndX < 0.5*kLeftWidth && kEndX >= 0) {
         kEndX = 0;
         }else if (kEndX >= 0.5*kLeftWidth && kEndX <= kLeftWidth) {
         // 2.2 如果向右拖一大半了,大于 1/2 的左view的宽度,虽然还没到位,也可以认为是到位了
         kEndX = kLeftWidth;
         }else if (kEndX > - 0.5*kRightWidth && kEndX <= 0) {
         // 2.3 如果只向左拖了一点点,小于 1/2 的右view的宽度,则归0
         kEndX = 0;
         }else if (kEndX <= - 0.5*kRightWidth) {
         // 2.4 如果向左拖一大半了,大于 1/2 的右view的宽度,虽然还没到位,也可以认为是到位了
         kEndX = - kRightWidth;
         }
         */
        
        
        // 第2种判断方式
        // 起始为0,delta.x大于0 代表向右滑动
        if (_startX == 0 && delta.x >0) {
            kEndX = kLeftWidth;
        }else if (_startX == 0 && delta.x < 0){
            // 起始为0,delta.x小于0 代表向左滑动
           // kEndX = - kRightWidth;
        }else if (_startX == kLeftWidth && delta.x < 0){
            // 起始为kLeftWidth,delta.x小于0 代表向左滑动
            kEndX =0;
        }
        //else if (_startX == - kRightWidth && delta.x > 0){
        // 起始为- kRightWidth,delta.x大于0 代表向右滑动
        //    kEndX = 0;
        //}
        
        
        
    }
    
    // 最后,才设置mainView的新的frame
    [UIView animateWithDuration:0.2 animations:^{
        self.mainView.frame=frame;
    }];   
}

// 单击按钮,也一样可以展开 左右侧边栏
- (IBAction)btnClick:(UIButton *)sender
{
    // 定义一个临时变量
    CGFloat startX = _mainView.frame.origin.x;
    
    
    
    
    // 定义一个临时变量
    CGFloat tempEndX = 0;
    // 左边的按钮被单击
    if (1 == sender.tag) {
        // 隐藏右半边
        _leftView.hidden = NO;
        //_rightView.hidden = YES;
        
        if (startX == 0) {
            tempEndX = kLeftWidth;
        }else if (startX == kLeftWidth){
            tempEndX = 0;
            _leftView.hidden = YES;
        }
    } else {
        // 单击右边按钮, 隐藏左半边
        _leftView.hidden = YES;
        //_rightView.hidden = NO;
        //if (startX == 0) {
        //    tempEndX = - kRightWidth;
        //}else if (startX == - kRightWidth){
        //    tempEndX = 0;
        //}
    }
    // 最后才设置mainView的x,调用抽取出来的公共代码,设置mainView的x,参数是endX
    [self setmainViewX:tempEndX];
    
    
    
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
