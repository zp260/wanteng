//
//  LeftTableViewController.m
//  wanteng
//
//  Created by mrz on 2016/12/19.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "LeftTableViewController.h"
#import "Column.h"
#import "LeftTableViewControllerDelegate.h"
@interface LeftTableViewController ()
{
    // 栏目数组,保存的是左边栏目列表中的所有栏目对象
    NSArray *_arr;
}
@end

@implementation LeftTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //主城区栏目
    Column *newsColumn = [Column columnNamed:@"城区" imgName:@"ic_zheng" className:@"FirstViewController"];
    //南郊栏目
    Column *nanjiaoColumn =[Column columnNamed:@"南郊" imgName:@"ic_zheng" className:@""];
    //安监局栏目
    Column *safeColumn =[Column columnNamed:@"安监局" imgName:@"ic_zheng" className:@""];
    _arr = @[newsColumn,nanjiaoColumn,safeColumn];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"leftVC";
    // 下面这个dequeue只能用于storyboard或xib中
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    //
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    // 设置独一无二的数据
    Column *column = _arr[indexPath.row];
    cell.textLabel.text = column.columnName;
    cell.imageView.image = [UIImage imageNamed:column.columnImgName];
    return cell;
}
// 点击一行时,主控制中的主视图必须展示相应栏目的内容,因此,必须实例化对应点击的行的栏目控制器,并用添加到导航控制器,调用代理 的方法传递数据给代理 使用,此处的代理 其实就是 主控制器
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 先取消默认的点击 高亮的颜色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 取出对应行的数据模型(栏目)
    Column *column = _arr[indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(leftTableViewRowClicked:)]) {
        
        // 传递数据给主控制器 BeyondViewController,通过代理
        // 关键代码~
        [self.delegate leftTableViewRowClicked:column];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
