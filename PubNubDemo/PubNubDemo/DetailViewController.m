//
//  DetailViewController.m
//  PubNubDemo
//
//  Created by Developer on 09/01/16.
//  Copyright © 2016 Neerav. All rights reserved.
//

#import "DetailViewController.h"
#import "PubNubManager.h"

@interface DetailViewController ()<PubNubManagerMessageDelegate, UITableViewDelegate, UITableViewDataSource>

//
- (IBAction)sendButtonTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//
@property (nonatomic, strong) NSMutableArray *messages;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    //set message delegate
    [PubNub_MANAGER setMessageDelegate:self];
    [PubNub_MANAGER setActiveChannel:_detailItem[@"myChannel"]];
    
    if (_messages == nil) {
        _messages = [NSMutableArray array];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)sendButtonTouched:(id)sender {
    [_messageTextField resignFirstResponder];
    if (!_messageTextField.text.length) return;

    //publish
    [PubNub_MANAGER publishMessage:_messageTextField.text toChannel:_detailItem[@"myChannel"]];
}


//
- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.navigationItem.title = [NSString stringWithFormat:@"Chatting With: %@", _detailItem[@"userName"]];
//        [_pubNubManager ]
    }
}

#pragma mark - PubNubManagerDelegate
- (void) pnmanager:(PubNubManager *) manager message : (NSDictionary *) message recieved : (NSString *) channel {
    [_messages insertObject:@{@"sender":channel,
                              @"message":message[@"message"]} atIndex:0];
    //    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView reloadData];
    
}

- (void) pnmanager:(PubNubManager *) manager message : (NSDictionary *) message published : (NSString *) channel {
    [_messages insertObject:@{@"sender":@"me",
                              @"message":message[@"message"]} atIndex:0];
    [self.tableView reloadData];
    //    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    
}

#pragma mark - Table View
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _messages.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell"];
    cell.textLabel.text = _messages[indexPath.row][@"message"];
    cell.detailTextLabel.text = _messages[indexPath.row][@"sender"];
    return cell;
}

@end