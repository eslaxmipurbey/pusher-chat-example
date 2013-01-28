//
//  MessageTableViewController.m
//  Messaging
//
//  Created by Scott Nicol on 11/01/2013.
//  Copyright (c) 2013 Scott Nicol. All rights reserved.
//

#import "MessageTableViewController.h"

@interface MessageTableViewController ()

@end

@implementation MessageTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(openAlert)];
    
    [super viewDidLoad];
    self.messages = [[NSMutableArray alloc] init];
    self.client = [PTPusher pusherWithKey:@"d547d01f9e158c812707" delegate:nil];
    self.client.reconnectAutomatically = YES;
    [self.client connect];
    PTPusherPrivateChannel *channel = [self.client subscribeToPrivateChannelNamed:@"main"];
    
    [channel bindToEventNamed:@"message-incoming" handleWithBlock:^(PTPusherEvent *channelEvent) {
        NSString *stringForArray = [NSString stringWithFormat:@"%@: %@", [[channelEvent data] objectForKey:@"name"], [[channelEvent data] objectForKey:@"message"]];
        [self.messages addObject:stringForArray];
        [self.tableView reloadData];
        NSLog(@"%@", stringForArray);
    }];
}

- (void)openAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Okay", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Message: %@",[[alertView textFieldAtIndex:0] text]);
    NSString *json = [NSString stringWithFormat:@"{\"name:\": \"scott\", \"message\" : \"%@\"}", [[alertView textFieldAtIndex:0] text]];
    NSString *stringForArray = [NSString stringWithFormat:@"Scott: %@", [[alertView textFieldAtIndex:0] text]];
    [self.messages addObject:stringForArray];
    [self.tableView reloadData];
    [self.client sendEventNamed:@"client-message-incoming" data:json channel:@"private-main"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
    tableView.transform = transform;
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.transform = transform;
    cell.textLabel.text = [self.messages objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:10.0];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
