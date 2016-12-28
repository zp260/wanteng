//
//  FirstViewController.m
//  wanteng
//
//  Created by mrz on 2016/11/30.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "FirstViewController.h"
static NSString *const rootDomain = @"http://www.dtcqzf.gov.cn";//网站域名
static NSString *const articleListPath = @"http://www.dtcqzf.gov.cn/mobile/article/list/";//取文章列表的path
static int const pageCount = 20; //每页加载20个数据
@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize pageControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //初始化抽屉参数
    _isShow = NO;
    
    
    pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = 4; //重要，初始化pageControl的时候要初始化它的numberOfPages.
    pageControl.currentPage = 0;
    startPage = 0;
    siteID = 2;
    
    self.title = @"城区网站";
    
    //设置访问参数
    parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:@"1" forKey:@"thumb"];

    [_tableView registerNib:[UINib nibWithNibName:@"NewsListCell" bundle:nil] forCellReuseIdentifier:@"newsListCell"];
    
    //初始化loading动画图片
    LoadingImageview *loading = [[LoadingImageview alloc]init];
    _lodingIMG = [loading initloadingImg];
    [self jsonGet:2 startpage:0 pagecount:20];
    
    //下拉刷新
   _tableController = [[UITableViewController alloc]init];
    _tableController.tableView = _tableView;
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [refresh addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    _tableController.refreshControl =refresh;
    
    [self addTimer];
    
}
#pragma 获取网络数据
-(void)jsonGet:(int)siteid startpage:(int)startpage pagecount:(int)pagecount{
    NSString* articleListUrl = [[NSString alloc]initWithFormat:@"%@%d/%d/%d",articleListPath,siteid,startpage,pagecount];
    NetWork *work = [[NetWork alloc]init];
    [work byGet:articleListUrl dic:parameter withBlock:^(NSArray *needArray, NSError *error) {
        [self.recipes addObjectsFromArray:needArray] ;
        [_tableView reloadData];
        [_loadMoreView stopAnimation];//数据加载成功后停止旋转菊花
        if(needArray.count<pageCount){  //如果载入的数据量小于每页应该加载的数据量，说明到最后一页了
            [_loadMoreView noMoreData];
        }
    }];
}
#pragma mark-下拉刷新
-(void)refreshData{
    if (_tableController.refreshControl.isRefreshing) {
        [_recipes removeAllObjects]; //清除旧数据，每次加载都是最新的数据
        _tableController.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中。。。"];
        [self jsonGet:2 startpage:0 pagecount:20];
        _tableController.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
        [_tableController.refreshControl endRefreshing];
        _loadMoreView.tipsLabel.hidden = YES;
        startPage = 0;
        
    }
}

#pragma mark- 加载更多事件,上拉加载
-(void)loadMore{
    startPage++;
    NSLog(@"startPage=%d",startPage);
    [self jsonGet:siteID startpage:startPage pagecount:pageCount];
}

-(void)viewDidLayoutSubviews{
    
    [self initFrame];
    [self initFoucs];
}
-(NSMutableArray*)recipes{
    if (!_recipes) {
        _recipes = [NSMutableArray array];
    }
    return _recipes;
}
#pragma mark-初始化轮播
-(void)initFoucs{
    
    //初始化loading动画图片
    LoadingImageview *loading = [[LoadingImageview alloc]init];
    _lodingIMG = [loading initloadingImg];
    
    
    
    _ScroolImageArray = [[NSMutableArray alloc]init];//初始化轮播图片数组
    UIImage *img1 = [UIImage imageNamed:@"scrool_1"];
    UIImage *img2 = [UIImage imageNamed:@"scrool_2"];
    UIImage *img3 = [UIImage imageNamed:@"ad_01"];
    [_ScroolImageArray addObject:img3];
    [_ScroolImageArray addObject:img2];
    [_ScroolImageArray addObject:img1];
    [_ScroolImageArray addObject:img2];
    [self AddScroolViews:0];
    [self AddScroolViews:1];
    [self AddScroolViews:2];
    [self AddScroolViews:3];
    
    [_foucsScroll setContentSize:CGSizeMake(kDeviceWidth*_ScroolImageArray.count, 0)];
    _foucsScroll.tag = 111;
    
    //把pageControl添加到界面上,有bug
//    pageControl.frame = CGRectMake(0, _foucsScroll.bottom+37, _foucsScroll.width, 37);
//    [self.view addSubview:pageControl];
    
}


#pragma mark-初始frame
-(void)initFrame{
    [_foucsScroll setFrame:CGRectMake(0, 0, kDeviceWidth, 150)];
    [_tableView setFrame:CGRectMake(0, 64, kDeviceWidth, kDeviceHeight)];
    
    int btX = 0;
    float btY = _foucsScroll.bottom + 10 ;
    
    //间距固定 设置按钮
    float blank = 10;
    float btWidth = (_tableView.width - 6*blank) / 5;
    float btHeight =btWidth;
    
    
    _newsButton.frame = CGRectMake(btX+blank, btY, btWidth, btHeight);
    _infoButton.frame = CGRectMake(_newsButton.right+blank, btY, btWidth, btHeight);
    _yjManageButton.frame = CGRectMake(_infoButton.right+blank, btY, btWidth, btHeight);
    _govFilesButton.frame = CGRectMake(_yjManageButton.right+blank, btY, btWidth, btHeight);
    _sangongButton.frame = CGRectMake(_govFilesButton.right+blank, btY, btWidth, btHeight);
    
    
    _jingjiButton.frame = CGRectMake(btX+blank, _sangongButton.bottom+10, btWidth, btHeight);
    _vipOrgButton.frame = CGRectMake(_jingjiButton.right+blank, _jingjiButton.top, btWidth, btHeight);
    _cityManageButton.frame = CGRectMake(_vipOrgButton.right+blank, _jingjiButton.top, btWidth, btHeight);
    _unitManageButton.frame = CGRectMake(_cityManageButton.right+blank, _jingjiButton.top, btWidth, btHeight);
    _messageButton.frame = CGRectMake(_unitManageButton.right+blank, _jingjiButton.top, btWidth, btHeight);
    
    float f_btWidth = (_tableView.width - 3*10) / 4;
    float f_btHeight =f_btWidth*0.75;
    _historyButton.frame = CGRectMake(btX, _messageButton.bottom+10, f_btWidth, f_btHeight);
    _adminAreaButton.frame = CGRectMake(_historyButton.right+blank, _historyButton.top, f_btWidth, f_btHeight);
    _nationButton.frame = CGRectMake(_adminAreaButton.right+blank, _adminAreaButton.top, f_btWidth, f_btHeight);
    _areaButton.frame = CGRectMake(_nationButton.right+blank, _historyButton.top, f_btWidth, f_btHeight);
    
    _headerView.frame = CGRectMake(0, 0 , _tableView.width, _historyButton.bottom+10);//定义tableHeaderView
    _tableView.tableHeaderView = _headerView;
    _loadMoreView = [[SGLoadMoreView alloc]initWithFrame:CGRectMake(0, 0, _tableView.width, 44)];
    _tableView.tableFooterView = _loadMoreView;

}

#pragma mark -  按钮点击事件
- (IBAction)historyClick:(id)sender {
    NSLog(@"点击事件");
}
#pragma mark-tableview 代理


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
        
        NSString *time = [[data valueForKey:@"time"] stringValue];
        
        NSString *timeStr =  [TransDate TimeStamp:time];
        cell.date.text = timeStr;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( [_recipes count] > 0) {
        NSArray *data = [_recipes objectAtIndex:indexPath.row];
        ContentViewController *contentView = [[ContentViewController alloc]initWithArticle];
        
        contentView.article.Id      = [[data valueForKey:@"id"] intValue];
        contentView.article.Title   = [data valueForKey:@"title"];
        contentView.article.Thumb   = [NSString stringWithFormat:@"%@%@",rootDomain,[data valueForKey:@"thumb"]];//拼接缩略图具体的url
        contentView.article.Source  = [data valueForKey:@"source"];
        contentView.article.Date    = [TransDate TimeStamp:[[data valueForKey:@"time"]stringValue]];
        contentView.article.Hits    = [[data valueForKey:@"hits"]intValue];
        
        self.parentViewController.hidesBottomBarWhenPushed = YES;
        [self.parentViewController.navigationController pushViewController:contentView animated:YES];
        self.parentViewController.hidesBottomBarWhenPushed = NO;
        
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
    NSInteger i=pageControl.currentPage;
    if (i==_ScroolImageArray.count-1)
    {
        i=-1;
    }
    i++;
    [_foucsScroll setContentOffset:CGPointMake(i*_foucsScroll.width, 0) animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 111) {
        //    计算页码    页码 = (contentoffset.x + scrollView一半宽度)/scrollView宽度
        float currentOffsetX = scrollView.contentOffset.x;
        NSInteger page = (_foucsScroll.width*0.5+currentOffsetX)/_foucsScroll.width;
        [pageControl setCurrentPage:page];
    }else
    {
        CGFloat currentOffsetY = scrollView.contentOffset.y;
        /*self.refreshControl.isRefreshing == NO加这个条件是为了防止下面的情况发生：
         每次进入UITableView，表格都会沉降一段距离，这个时候就会导致currentOffsetY + scrollView.frame.size.height   > scrollView.contentSize.height 被触发，从而触发loadMore方法，而不会触发refresh方法。
         */
        if ( currentOffsetY + scrollView.frame.size.height  > scrollView.contentSize.height &&  _tableController.refreshControl.isRefreshing == NO  && self.loadMoreView.isAnimating == NO && self.loadMoreView.tipsLabel.isHidden ){
            [self.loadMoreView startAnimation];//开始旋转菊花
            [self loadMore];
        }
//        NSLog(@"%@ ---%f----%f",NSStringFromCGRect(scrollView.frame),currentOffsetY,scrollView.contentSize.height);
    }
    
    
    
   
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

#pragma mark-按钮点击事件

- (IBAction)histotyClick:(id)sender {
    ContentViewController *content = [[ContentViewController alloc]init];
    content.article.Id =29310;
    [self.navigationController pushViewController:content animated:YES];
    
}
#pragma mark-  nav 按钮点击事件
- (IBAction)showLeft:(id)sender {
    
}



#pragma 图片点击事件代理

#pragma mark-布局事件
@end
