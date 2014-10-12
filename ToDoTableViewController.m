//
//  ToDoTableViewController.m
//  start
//
//  Created by 谢润丰 on 14-9-23.
//  Copyright (c) 2014年 StarkIndustry. All rights reserved.
//

#import "ToDoTableViewController.h"
#import "ToDoItem.h"
#import "addViewController.h"
@interface ToDoTableViewController ()

@property NSMutableArray *itemsarray;

@end

@implementation ToDoTableViewController

//Sava data
- (void)savadata
{
    NSData *encodeditemsarray = [NSKeyedArchiver archivedDataWithRootObject:self.itemsarray];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodeditemsarray forKey:@"itemsarray"];
    [defaults synchronize];
}

//Load data
- (void)Loaddata
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *savedencodeditemsarray = [defaults objectForKey:@"itemsarray"];
    if (savedencodeditemsarray != nil) {
        self.itemsarray = (NSMutableArray *) [NSKeyedUnarchiver unarchiveObjectWithData:savedencodeditemsarray];
    }
}

- (IBAction)unwindtodo:(UIStoryboardSegue *)segue
{
    addViewController *source = [segue sourceViewController];
    ToDoItem *item = source.todoitem;
    if (item != nil) {
        [self.itemsarray addObject:item];
        //NSLog(@"%@",self.itemsarray);
        [self savadata];
        [self.tableView reloadData];
    }
}

- (IBAction)deletecell:(id)sender {
    [self delete];
}

- (void)delete{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if (self.tableView.editing){
        [self.navigationItem.leftBarButtonItem setTitle:@"删除"];
    }else{
        [self.navigationItem.leftBarButtonItem setTitle:@"管理"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.itemsarray = [[NSMutableArray alloc] init];
    [self Loaddata];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigatiobnItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.itemsarray count];
}

//table view 相关方法

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.itemsarray removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self savadata];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listprototypecell" forIndexPath:indexPath];
    
    // Configure the cell...
    ToDoItem *todoitem = [self.itemsarray objectAtIndex:indexPath.row];
    cell.textLabel.text = todoitem.itemname;
    if (todoitem.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ToDoItem *tappeditem = [self.itemsarray objectAtIndex:indexPath.row];
    tappeditem.completed = !tappeditem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
    [self savadata];
}

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
