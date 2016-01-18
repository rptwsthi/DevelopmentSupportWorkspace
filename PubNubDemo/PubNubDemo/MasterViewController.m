//
//  MasterViewController.m
//  PubNubDemo
//
//  Created by Developer on 09/01/16.
//  Copyright © 2016 Neerav. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "PubNubManager.h"


@interface MasterViewController ()<PubNubManagerSubscriptionDelegate>{
    NSString *myUserName_;
    BOOL subscribed_;
    
}
@property NSArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(refreshSubscription:)];
    self.navigationItem.rightBarButtonItem = addButton;
//    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    _objects = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UsersArray" ofType:@"plist"]];
    [self setUserName];
    
    [PubNub_MANAGER subscribeToChannels:[_objects valueForKey:@"myChannel"] withDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshSubscription:(id)sender {
    //subscrbe to channels
    
}

- (void) addChat : (NSString *) myUserName otherUserName : (NSString *) otherUserName {
    
}

- (void) setViewTitle : (NSString *) title {
    self.navigationItem.title = title;
}

#pragma mark - CheckAndGet User Name
- (void) setUserName {
    NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
    if (userName != nil && userName.length) {
        myUserName_ = userName;
        [self setTitle:myUserName_];
        return;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"User Name" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    UITextField *textField = [alertView textFieldAtIndex:0];
    if (textField.text.length != 0 && [self name:textField.text inList:_objects]) {
        [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        myUserName_ = textField.text;
        [self setTitle:textField.text];
    }
}

- (BOOL) alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView {
    return ([[[alertView textFieldAtIndex:0] text] length]);
}

- (BOOL) name : (NSString *) name inList : (NSArray *) userArray{
    for (NSDictionary *dictionary in userArray) {
        if ([dictionary[@"userName"] isEqualToString:name])  return YES;
    }
    return NO;
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setDetailItem:sender];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *object = _objects[indexPath.row];
    cell.textLabel.text = object[@"userName"];
    cell.detailTextLabel.text = object[@"myChannel"];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (myUserName_ == nil || myUserName_.length == 0) {
        [self setUserName];
        return;
    }
    if (!subscribed_)   return;

    NSDictionary *dictionary = _objects[indexPath.row];
    NSLog(@"dictionary = %@", dictionary);
    if (![dictionary[@"userName"] isEqualToString:myUserName_])
        [self performSegueWithIdentifier:@"showDetail" sender:dictionary];
}


#pragma mark - PubNubManagerSubscriptionDelegate
- (void) pnmanager:(PubNubManager *) manager subscribed : (BOOL) subscribed toChannels : (NSArray *) channels {
    NSLog(@"\n%s:\nsubscribed = %d, channels = %@", __PRETTY_FUNCTION__, subscribed, channels);
    subscribed_ = subscribed;
}

@end