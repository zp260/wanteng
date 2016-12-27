//
//  FourViewController.m
//  wanteng
//
//  Created by mrz on 2016/12/9.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , _tableView.width, 220)];//定义tableHeaderView
    _tableView.tableHeaderView = _tableHeaderView;
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scrool_2"]];
    img.frame = CGRectMake(0, 0, _tableHeaderView.width, _tableHeaderView.height);
    [_tableHeaderView addSubview:img];
    
    _recipes = [[NSArray alloc]initWithObjects:@"1g",@"2g",@"1g",@"2g",@"1g",@"2g",@"1g",@"2g",@"1g",@"2g",@"1g",@"2g", nil];
     [_tableView registerNib:[UINib nibWithNibName:@"NewsListCell" bundle:nil] forCellReuseIdentifier:@"newsListCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        cell.title.text = [_recipes objectAtIndex:indexPath.row];
        cell.source.text = @"ssdsa";
        NSString *timeStr = @"time";
        cell.date.text = timeStr;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (IBAction)showColletion:(id)sender {
    CollectionTableViewController *colletion = [[CollectionTableViewController alloc]init];
    [self.navigationController pushViewController:colletion animated:YES];
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
