//
//  SecondViewController.m
//  wanteng
//
//  Created by mrz on 2016/11/30.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
NSInteger const cellHight = 80;
NSInteger const cellWidth = 110;

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化数据接收数组
    SectionDic  = [[NSMutableDictionary alloc]init];
    classArray = [[NSArray alloc]initWithObjects:@"http://www.dtcqzf.gov.cn/mobile/type/273",@"http://www.dtcqzf.gov.cn/mobile/type/274",@"http://www.dtcqzf.gov.cn/mobile/type/275",nil];
    sectionTitleArray = [[NSArray alloc]initWithObjects:@"工作部门",@"直属机构",@"街道办事处", nil];
    
    [_collectView registerNib:[UINib nibWithNibName:@"SecondCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"coustmCell"];
     //[_collectView registerClass:[SecondCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)_collectView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 0);
     cellCounts = 0;
    [self jsonGet];
}
-(void)viewDidLayoutSubviews{
    [self initFrame];
    
}


-(void)jsonGet{
    for (int i=0; i<classArray.count; i++) {
        NetWork *network = [[NetWork alloc]init];
        [network byGet:[classArray objectAtIndex:i] dic:nil withBlock:^(NSArray *needArray, NSError *error) {
            if(!error){
                [SectionDic setObject:needArray forKey:[classArray objectAtIndex:i]];
                
                cellCounts += needArray.count;//统计所有得到的cell
                //加载完所有的section数据后 再刷新
                if (SectionDic.count==classArray.count) {
                    [_collectView reloadData];
                    [self freshCollectView];
                }
            }
        }];
    }
    
}
-(void)initFrame{

}

/**
 根据得到的cell数量 动态设置collectview的frame
 */
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
    
    _collectView.frame = CGRectMake(0, 0, kDeviceWidth, 5000);
    NSLog(@"%@",NSStringFromCGRect(_collectView.frame));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collect delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (SectionDic.count>0) {
        return  [[SectionDic objectForKey:[classArray objectAtIndex:section]]count];
    }
    else {
        return 0;
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  classArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"coustmCell" forIndexPath:indexPath];
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    if (SectionDic.count>0) {
        NSArray *contentDic =[SectionDic objectForKey:[classArray objectAtIndex:sec]];
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
    if (SectionDic.count>0) {
        NSArray *contentDic =[SectionDic objectForKey:[classArray objectAtIndex:sec]];
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
    CGSize size={kDeviceWidth,30};
    if(section==0){
      CGSize size={kDeviceWidth,170};
        return size;
    }
    return size;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if(kind==UICollectionElementKindSectionHeader){
        SecondCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.title.text = [sectionTitleArray objectAtIndex:indexPath.section];
        headerView.backgroundImg.backgroundColor  = [UIColor grayColor];
        reusableView = headerView;
        
    }
    if (kind == UICollectionElementKindSectionFooter){
        
        
    }
    return reusableView;
}



@end
