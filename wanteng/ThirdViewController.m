//
//  ThirdViewController.m
//  wanteng
//
//  Created by mrz on 2016/12/7.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
@property (strong,nonatomic) NSArray *cellTitleArray;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self loadWeather];
    [_collectionView registerNib:[UINib nibWithNibName:@"SecondCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"coustmCell"];
}

-(void)initData{
    _cellTitleArray = [[NSArray alloc]initWithObjects:@"万年历",@"身份信息",@"快递查询",@"微信精选",@"号码归属地",@"汇率查询",@"历史今天",@"星座运势",@"公交查询", nil];
}
- (void)loadWeather
{
    //101180301
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    date = [formatter stringFromDate:[NSDate date]];
    
    NSURL *URL =[NSURL URLWithString:@"http://www.weather.com.cn/data/cityinfo/101100201.html"];
    NSError *error;
    NSString *stringFromFileAtURL = [[NSString alloc]
                                     initWithContentsOfURL:URL
                                     encoding:NSUTF8StringEncoding
                                     error:&error];
    NSString *strTempL;
    NSString *strTempH;
    NSString *strWeather;
    NSString *fileName=@"晴.png";
    if(stringFromFileAtURL !=nil)
    {
        
        NSLog(@"%@", stringFromFileAtURL);
        NSArray *strarray = [stringFromFileAtURL componentsSeparatedByString:@"\""];
        
        for(int i=0;i<strarray.count;i++)
        {
            NSLog(@"%@", [strarray objectAtIndex:i]);
            NSString *str = [strarray objectAtIndex:i];
            if(YES == [str isEqualToString:@"temp1"])//最高温度
            {
                strTempH = [strarray objectAtIndex:i+2];
            }
            else if(YES == [str isEqualToString:@"temp2"])//最低温度
            {
                strTempL = [strarray objectAtIndex:i+2];
            }
            else if(YES == [str isEqualToString:@"weather"])//天气
            {
                strWeather = [strarray objectAtIndex:i+2];
            }
            
        }
        
        
        NSString *sweather = [[NSString alloc]initWithFormat:@"今日天气:%@",strWeather];
        
        if(NSNotFound != [strWeather rangeOfString:@"晴"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@",@"晴.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"多云"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"多云.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"阴"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"阴.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"雨"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"中雨.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"雪"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"小雪.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"雷"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"雷雨.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"雾"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"雾.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"大雪"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"大雪.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"大雨"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"大雨.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"中雪"].location)
        {
            fileName = [[NSString alloc]initWithFormat:@"%@",@"中雪.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"中雨"].location)
        {
            fileName = [[NSString alloc]initWithFormat:@"%@",@"中雨.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"小雪"].location)
        {
            fileName = [[NSString alloc]initWithFormat:@"%@",@"小雪.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"小雨"].location)
        {
            fileName = [[NSString alloc]initWithFormat:@"%@",@"中雨.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"雨加雪"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"雨夹雪.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"阵雨"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"中雨.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"雷阵雨"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"雷阵雨.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"大雨转晴"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"大雨转晴.png"];
        }
        if(NSNotFound != [strWeather rangeOfString:@"阴转晴"].location)
        {
            fileName =[[NSString alloc]initWithFormat:@"%@", @"阴转晴.png"];
        }
        
        if (strTempL!=nil && strTempH!=nil) {
            _oCtext.text = [[NSString alloc]initWithFormat:@"%@~%@",strTempL,strTempH];
        }
        
    }
    _weathText.text = date;
    NSLog(@"%@", fileName);
    self.weathImage.image = [UIImage imageNamed:fileName];
}

#pragma mark - collect delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return _cellTitleArray.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"coustmCell" forIndexPath:indexPath];
    cell.layer.borderWidth = 0.4f;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    NSInteger sec = indexPath.section;
    NSInteger row = indexPath.row;
    NSUInteger imageWidth = 60;
    cell.image.frame = CGRectMake(30, 30, imageWidth, imageWidth);
        NSString *title = [_cellTitleArray objectAtIndex:row];
        cell.title.text = title;
   
    
    return cell;
}
//UICollectionViewCell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(_collectionView.width/3, 100);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return  0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
