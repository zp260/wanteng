//
//  SecondViewController.m
//  wanteng
//
//  Created by mrz on 2016/11/30.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "SecondViewController.h"
NSInteger const cellHight = 80;
NSInteger const cellWidth = 110;

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化数据接收数组
    SectionArray  = [[NSMutableArray alloc]init];
    classAryyay = [[NSArray alloc]initWithObjects:@"http://www.dtcqzf.gov.cn/mobile/type/273",@"http://www.dtcqzf.gov.cn/mobile/type/274",@"http://www.dtcqzf.gov.cn/mobile/type/275",nil];
    sectionTitleArray = [[NSArray alloc]initWithObjects:@"工作部门",@"直属机构",@"街道办事处", nil];
    
    [_collectView registerNib:[UINib nibWithNibName:@"SecondCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"coustmCell"];
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)_collectView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
     cellCounts = 0;
    [self jsonGet];
}
-(void)viewDidLayoutSubviews{
    [self initFrame];
}
-(void)jsonGet{
    for (int i=0; i<classAryyay.count; i++) {
        NetWork *network = [[NetWork alloc]init];
        [network byGet:[classAryyay objectAtIndex:i] dic:nil withBlock:^(NSArray *needArray, NSError *error) {
            if(!error){
                [SectionArray addObject:needArray];
                cellCounts += needArray.count;
                if (SectionArray.count==classAryyay.count) {
                    [_collectView reloadData];
                    [self freshCollectView];
                }
            }
        }];
    }
    
}
-(void)initFrame{
    _rootScroolView.frame = CGRectMake(0, 0, kDeviceWidth, kDeviceHeight);
//    _rootScroolView.contentSize = CGSizeMake(kDeviceWidth, kDeviceHeight*3);
    _topImage.frame = CGRectMake(0, 0, _rootScroolView.width, 150);
//    _collectView.frame = CGRectMake(15, _topImage.bottom+10, _rootScroolView.width-30, kDeviceHeight*3-(_topImage.bottom+10));
}
-(void)freshCollectView{
    NSInteger count = 0; //CollectView总行数
    NSInteger per_count =floor(_collectView.width / cellWidth); //每行的cell个数
    
    if (cellCounts%per_count == 0)
    {
        count = cellCounts/per_count;
    }
    else
    {
        count = cellCounts/per_count+1;
    }
    
    _collectView.frame = CGRectMake(0, _topImage.bottom+10, _rootScroolView.width, count*(cellHight+20));
    _rootScroolView.contentSize =CGSizeMake(kDeviceWidth, _collectView.height + _topImage.height) ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collect delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (SectionArray.count>0) {
        return [[SectionArray objectAtIndex:section] count];
    }
    else {
        return 0;
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  classAryyay.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"coustmCell" forIndexPath:indexPath];
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    if (SectionArray.count>0) {
        NSArray *contentDic =[SectionArray objectAtIndex:sec];
        NSArray *contentArr = [contentDic objectAtIndex:row];
        NSString *title = [contentArr valueForKey:@"name"];
        cell.title.text = title;
    }
    
    return cell;
}
//UICollectionViewCell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(cellWidth, cellHight);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    if (SectionArray.count>0) {
        NSArray *contentDic =[SectionArray objectAtIndex:sec];
        NSArray *contentArr = [contentDic objectAtIndex:row];
        NSNumber* topid = [contentArr valueForKey:@"id"];
        NSLog(@"topid=%ld",[topid integerValue]);
        self.hidesBottomBarWhenPushed = YES;
        SecondContentViewController *contentView = [[SecondContentViewController alloc]init];
        contentView.id = [topid integerValue];
        [self.navigationController pushViewController:contentView animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }

}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={kDeviceWidth,20};
    return size;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        SecondCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        if (SectionArray.count>0) {
            NSInteger sec = indexPath.section;
            headerView.backgroundImg.backgroundColor = [UIColor grayColor];
            headerView.title.text = [sectionTitleArray objectAtIndex:sec];
        }
        
        reusableview = headerView;
    }
    
    return reusableview;
}

@end
