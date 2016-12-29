//
//  CollectionTableViewController.m
//  wanteng
//
//  Created by mrz on 2016/12/27.
//  Copyright © 2016年 com.wanteng. All rights reserved.
//

#import "CollectionTableViewController.h"

@interface CollectionTableViewController ()
@property (strong,nonatomic) NSMutableArray *articleArray;
@end

@implementation CollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsListCell" bundle:nil] forCellReuseIdentifier:@"newsListCell"];
    
    //初始化loading动画图片
    LoadingImageview *loading = [[LoadingImageview alloc]init];
    _lodingIMG = [loading initloadingImg];
    
    [self readCoreData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)readCoreData{
    _articleArray = [[NSMutableArray alloc]init];
    CollectionCoreDataController *collection= [[CollectionCoreDataController sharedInstance]init];
    [collection readAllModel:nil success:^(NSArray *finishArray) {
        
        [self.tableView reloadData];
        for (Collection *clt in finishArray){
            Article *artile = [[Article alloc]initWithColletion:clt];
            [_articleArray addObject:artile];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _articleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsListCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = (NewsListCell *)[tableView dequeueReusableCellWithIdentifier:@"newsListCell"];
    }
    
    if ( [_articleArray count] > 0) {
        Article *article = [_articleArray objectAtIndex:indexPath.row];
        NSString *imagUrl = article.Thumb;
        [cell.leftImage sd_setImageWithURL:[NSURL URLWithString:imagUrl] placeholderImage:_lodingIMG];
        
        cell.title.text = article.Title;
        cell.source.text = article.Source;
        cell.date.text = article.Date;
    }
    // Configure the cell...
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Article *article = [_articleArray objectAtIndex:indexPath.row];
        [_articleArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        //删除数据库中的存储
        if (article) {
            NSFetchRequest* request=[[NSFetchRequest alloc] init];
            CollectionCoreDataController *coreController = [[CollectionCoreDataController sharedInstance]init];
            NSEntityDescription* collection=[NSEntityDescription entityForName:coreController.coreDataEntityName inManagedObjectContext:coreController.coreDataApi.context];
            [request setEntity:collection];
            NSPredicate* predicate=[NSPredicate predicateWithFormat:@"articleId == %d",article.Id];
            [request setPredicate:predicate];
            NSError* error=nil;
            NSMutableArray* mutableFetchResult=[[coreController.coreDataApi.context executeFetchRequest:request error:&error] mutableCopy];
            if (mutableFetchResult==nil) {
                NSLog(@"Error:%@",error);
            }
            for (Collection* ct in mutableFetchResult) {
                [coreController.coreDataApi.context deleteObject:ct];
            }
            
            if ([coreController.coreDataApi.context save:&error]) {
                NSLog(@"Error:%@,%@",error,[error userInfo]);
            }

        }
        
        
    }
    //else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //}
}


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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    if ( [_articleArray count] > 0) {
        Article *article = [_articleArray objectAtIndex:indexPath.row];//此处的data为clollection对象
        ContentViewController *contentView = [[ContentViewController alloc]initWithArticle];
        contentView.article = article;
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:contentView animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }

    
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    
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
