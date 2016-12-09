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
    _recipes = [[NSArray alloc]init];
    
    NSLog(@"%f",kDeviceWidth);
    [_tableView registerNib:[UINib nibWithNibName:@"NewsListCell" bundle:nil] forCellReuseIdentifier:@"newsListCell"];
    
    //初始化loading动画图片
    LoadingImageview *loading = [[LoadingImageview alloc]init];
    _lodingIMG = [loading initloadingImg];
    [self jsonGet];
    
}
-(void)jsonGet{
    NSString* articleListUrl = @"http://www.dtcqzf.gov.cn/mobile/article/list/2/0/20?thumb=1";
    
//    [articleListUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //如果传送的参数里面有中文的话，需要这样编码
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    manager.responseSerializer  = [AFHTTPResponseSerializer serializer];

    [manager GET:articleListUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"进度:%lld", downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功:%@", responseObject);
        _recipes  = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       [_tableView reloadData];
        NSLog(@"请求成功JSON:%@", _recipes);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@", error.description);
    }];
    
    [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:articleListUrl parameters:nil error:nil];
}
-(void)viewDidLayoutSubviews{
    [self initFrame];
    [self initScroolView];
    
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
    
    //添加背景view
    _backgroudIMG.frame  = CGRectMake(0, _historyButton.height-15, _historyButton.width, 15);
    
    UIImageView *backIMG2 = [[UIImageView alloc]init];
    UIImageView *backIMG3 = [[UIImageView alloc]init];
    UIImageView *backIMG4 = [[UIImageView alloc]init];
    
    backIMG2.frame = backIMG3.frame = backIMG4.frame = _backgroudIMG.frame;
    backIMG2.alpha = backIMG3.alpha = backIMG4.alpha = _backgroudIMG.alpha;
    backIMG2.backgroundColor = backIMG3.backgroundColor = backIMG4.backgroundColor = _backgroudIMG.backgroundColor;
    
    [_historyButton addSubview:_backgroudIMG];
    [_adminAreaButton addSubview:backIMG2];
    [_nationButton addSubview:backIMG3];
    [_areaButton addSubview:backIMG4];

    

    
    [_tableView setFrame:CGRectMake(10, _historyButton.bottom+blank, kDeviceWidth-20, kDeviceHeight*2 - (_historyButton.bottom+blank) )];

}
#pragma mark -  按钮点击事件
- (IBAction)historyClick:(id)sender {
    NSLog(@"点击事件");
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
    NewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsListCell"];
    if (cell == nil) {
        cell = (NewsListCell *)[tableView dequeueReusableCellWithIdentifier:@"newsListCell"];
    }
    
    if ( [_recipes count] > 0) {
        NSArray *data = [_recipes objectAtIndex:indexPath.row];
    
        NSString *imagUrl = [[NSString alloc] initWithFormat:@"%@%@",SiteUrl,[data valueForKey:@"thumb"]];
        [cell.leftImage sd_setImageWithURL:[NSURL URLWithString:imagUrl] placeholderImage:_lodingIMG];
        
        cell.title.text = [data valueForKey:@"title"];
        cell.source.text = [data valueForKey:@"source"];
        
        NSLog(@"%@",[[data valueForKey:@"id"] class]) ;
        NSString *time = [[data valueForKey:@"time"] stringValue];
        
        NSString *timeStr =  [TransDate TimeStamp:time];
        cell.date.text = timeStr;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( [_recipes count] > 0) {
        NSArray *data = [_recipes objectAtIndex:indexPath.row];
        ContentViewController *contentView = [[ContentViewController alloc]init];
        contentView.id = [data valueForKey:@"id"];
        [self.navigationController pushViewController:contentView animated:YES];
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
