//
//  FirstViewController.m
//  wanteng
//
//  Created by mrz on 2016/11/30.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _recipes = [NSArray arrayWithObjects:@"第一条数据",@"第二条数据",@"第三条数据",@"第四条数据",@"第五条数据",@"第一条数据",@"第二条数据",@"第三条数据",@"第四条数据",@"第五条数据", nil];
    
    NSLog(@"%f",kDeviceWidth);
   
    
}
-(void)viewWillLayoutSubviews{
    
}
-(void)viewDidLayoutSubviews{
    [self initFrame];
    [self initScroolView];
    
    [self initTableUI];
}
//轮播相关
-(void)initScroolView{
    
    //初始化loading动画图片
    LoadingImageview *loading = [[LoadingImageview alloc]init];
    _lodingIMG = [loading initloadingImg];
    
    
    
    _ScroolImageArray = [[NSMutableArray alloc]init];//初始化轮播图片数组
    UIImage *img1 = [UIImage imageNamed:@"scrool_1"];
    UIImage *img2 = [UIImage imageNamed:@"scrool_2"];
    [_ScroolImageArray addObject:img1];
    [_ScroolImageArray addObject:img2];
    [_ScroolImageArray addObject:img1];
    [_ScroolImageArray addObject:img2];
    [self AddScroolViews:0];
    [self AddScroolViews:1];
    [self AddScroolViews:2];
    [self AddScroolViews:3];
    
   
    [_scroolView setContentSize:CGSizeMake(0, kDeviceHeight*2)];
    
    [_foucsScroll setContentSize:CGSizeMake(_scroolView.width*_ScroolImageArray.count, 0)];
    
}

#pragma mark-初始化table位置
-(void)initTableUI{
    [_tableView setFrame:CGRectMake(0, 500, kDeviceWidth, 600)];
}
#pragma mark-初始frame
-(void)initFrame{
     [_scroolView setFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight)];
    [_foucsScroll setFrame:CGRectMake(0, 0, _scroolView.width, _foucsScroll.height)];
    
    int btX = 10;
    float btY = _foucsScroll.bottom + 10 ;
    float blank = 10;
    float btWidth = (_scroolView.width - 6*10) / 5;
    float btHeight =btWidth;
    
    
    _newsButton.frame = CGRectMake(btX, btY, btWidth, btHeight);
    _infoButton.frame = CGRectMake(_newsButton.right+blank, btY, btWidth, btHeight);
    _yjManageButton.frame = CGRectMake(_infoButton.right+blank, btY, btWidth, btHeight);
    _govFilesButton.frame = CGRectMake(_yjManageButton.right+blank, btY, btWidth, btHeight);
    _sangongButton.frame = CGRectMake(_govFilesButton.right+blank, btY, btWidth, btHeight);
    
    
    _jingjiButton.frame = CGRectMake(btX, _sangongButton.bottom+10, btWidth, btHeight);
    _vipOrgButton.frame = CGRectMake(_jingjiButton.right+blank, _jingjiButton.top, btWidth, btHeight);
    _cityManageButton.frame = CGRectMake(_vipOrgButton.right+blank, _jingjiButton.top, btWidth, btHeight);
    _unitManageButton.frame = CGRectMake(_cityManageButton.right+blank, _jingjiButton.top, btWidth, btHeight);
    _messageButton.frame = CGRectMake(_unitManageButton.right+blank, _jingjiButton.top, btWidth, btHeight);
    
    float f_btWidth = (_scroolView.width - 5*10) / 4;
    float f_btHeight =f_btWidth*0.75;
    _historyButton.frame = CGRectMake(btX, _messageButton.bottom+10, f_btWidth, f_btHeight);
    _adminAreaButton.frame = CGRectMake(_historyButton.right+blank, _historyButton.top, f_btWidth, f_btHeight);
    _nationButton.frame = CGRectMake(_adminAreaButton.right+blank, _adminAreaButton.top, f_btWidth, f_btHeight);
    _areaButton.frame = CGRectMake(_nationButton.right+blank, _historyButton.top, f_btWidth, f_btHeight);

//    float lastSpace = kDeviceWidth - (3*_infoButton.width+2*10);//    取剩余使用空间
//    float lastBtSpace = lastSpace / 2;//    每个bt可以使用的空间
//    float btBlank = (lastBtSpace-_infoButton.width)/2; //得到左右间距
//    
//    [_infoButton setLeft:_newsButton.right+btBlank]; //重新定位位置
//    [_govFilesButton setLeft:_yjManageButton.right+btBlank];
//    [_vipOrgButton setLeft:_infoButton.left];
//    [_unitManageButton setLeft:_govFilesButton.left];
    
    //四个大按钮的
    float f_lastSpace = kDeviceWidth - (2*_historyButton.width+2*10);//    取剩余使用空间
    float f_lastBtSpace = f_lastSpace - 2*_historyButton.width;//    每个bt可以使用的空间
    float f_btBlank = f_lastBtSpace/3; //得到左右间距
    
    [_adminAreaButton setLeft:_historyButton.right+f_btBlank];
    [_nationButton setLeft:_adminAreaButton.right+f_btBlank];
}
#pragma mark-tableview datasource delege

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_recipes count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"listCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [_recipes objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"test.jpg"];
    return cell;
}

//添加轮播图片
-(void)AddScroolViews:(NSInteger)i
{
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ScroolViewPicClick:)];
    singleFingerOne.numberOfTouchesRequired =1;
    singleFingerOne.numberOfTapsRequired=1;
    singleFingerOne.delegate =self;
    
    
    
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0+_foucsScroll.width*i, 0, _foucsScroll.width, _foucsScroll.height)];
    imgview.image = [_ScroolImageArray objectAtIndex:i];
//    [imgview sd_setImageWithURL:[NSURL URLWithString:[[_ScroolImageArray objectAtIndex:i]valueForKey:@"image"]] placeholderImage:lodingIMG];
//    [_ScroolClickAaary addObject:[[ScroolImageArray objectAtIndex:i]valueForKey:@"url"]];
    imgview.userInteractionEnabled=YES;
    if(imgview.image != _lodingIMG)
    {
        imgview.contentMode=UIViewContentModeScaleToFill;
    }
    
    [imgview addGestureRecognizer:singleFingerOne];
    imgview.tag=i;
    [_foucsScroll addSubview:imgview];
    
}

//异步加载ScroolView用de图片,解决上下滚动的卡顿现象
-(void)getScroolImages:(NSMutableArray *)ImageArray
{
    for (id object in  ImageArray)
    {
        if([object objectForKey:@"url"])
        {
//            [_ScroolClickAaary addObject:[object objectForKey:@"url"]];
            NSURL *ImgUrl =[NSURL URLWithString:[object objectForKey:@"image"]];
            UIImage *IMG=[UIImage imageWithData:[NSData dataWithContentsOfURL:ImgUrl]];
            if(!IMG)
            {
                IMG = [UIImage imageNamed:@"tab_photo"];
            }
            [_ScroolImageArray addObject:IMG];
        }
        
    }
}
#pragma mark-图片点击相关
-(void)ScroolViewPicClick:(UITapGestureRecognizer *)sender
{
    
//    _webCrtrol.url =[_ScroolClickAaary objectAtIndex:sender.view.tag];
    //NSLog(@"data is %@",[_ScroolClickAaary objectAtIndex:sender.view.tag]);
    if (sender.numberOfTapsRequired==1) {
//        [self.navigationController pushViewController:_webCrtrol animated:YES];
        [self removeTimer];
    }
}

#pragma mark-SCroll and TIMER
-(void)nextImage
{
    NSInteger i=self.pageControl.currentPage;
    if (i==_ScroolImageArray.count-1)
    {
        i=-1;
    }
    i++;
    [_foucsScroll setContentOffset:CGPointMake(i*_foucsScroll.width, 0) animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //    计算页码
    //    页码 = (contentoffset.x + scrollView一半宽度)/scrollView宽度
    self.pageControl.currentPage=(_foucsScroll.width*0.5+_foucsScroll.contentOffset.x)/_foucsScroll.width;
    NSLog(@"滚动中,%d",self.pageControl.currentPage);
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}
- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer=nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma 图片点击事件代理

@end
