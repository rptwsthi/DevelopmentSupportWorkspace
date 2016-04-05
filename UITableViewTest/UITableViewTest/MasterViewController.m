////
////  MasterViewController.m
////  UITableViewTest
////
////  Created by Developer on 07/01/16.
////  Copyright © 2016 Neerav. All rights reserved.
////
//
//#import "MasterViewController.h"
//#import "DetailViewController.h"
//
//@interface MasterViewController ()
//
//@property NSDictionary *objects;
//@end
//
//@implementation MasterViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    
//    _objects = @{@"About Stepone": @[ @{ @"text": @"Step0ne 1" },
//                                      @{ @"text": @"Step0ne 2" },
//                                      @{ @"text": @"Step0ne 3" },
//                                      @{ @"text": @"Step0ne 4" },
//                                      @{ @"text": @"Step0ne 5" },
//                                      @{ @"text": @"Step0ne 6" },
//                                      @{ @"text": @"Step0ne 7" },
//                                      @{ @"text": @"Step0ne 8" }],
//                 @"profile": @[ @{ @"text": @"profile 1" },
//                                @{ @"text": @"profile 2" },
//                                @{ @"text": @"profile 3" },
//                                @{ @"text": @"profile 4" },
//                                @{ @"text": @"profile 5" },
//                                @{ @"text": @"profile 6" },
//                                @{ @"text": @"profile 7" },
//                                @{ @"text": @"profile 8" }]
//                 };
//    
//}
//
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark - Table View
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return _objects.allKeys.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return ((NSArray *) _objects[_objects.allKeys[section]]).count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//
//    NSDictionary *object = _objects[_objects.allKeys[indexPath.section]][indexPath.row];
//    cell.textLabel.text = object[@"text"];
//    return cell;
//}
//
//- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return _objects.allKeys[section];
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//
//@end


////Add image in ulernate cell
////
////  MasterViewController.m
////  UITableViewTest
////
////  Created by Developer on 07/01/16.
////  Copyright © 2016 Neerav. All rights reserved.
////
//
//#import "MasterViewController.h"
//#import "DetailViewController.h"
//
//@interface MasterViewController ()
//
//@property NSArray *objects;
//@end
//
//@implementation MasterViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    
//    _objects = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ImageList" ofType:@"plist"]];
//}
//
//
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark - Table View
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _objects.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
//    
//    NSDictionary *object = _objects[indexPath.row];
//    cell.textLabel.text = object[@"text"];
//    cell.imageView.image = [UIImage imageNamed:object[@"image"]];
//    return cell;
//}
//
////- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
////    return _objects.allKeys[section];
////}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//
//    return YES;
//}
//
//- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [_objects[indexPath.row][@"image"] length] ? 60.0f : 30.0f;
//}
//
//@end


//Add image in ulernate cell
//
//  MasterViewController.m
//  UITableViewTest
//
//  Created by Developer on 07/01/16.
//  Copyright © 2016 Neerav. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController (){
    NSIndexPath *selectedIndexPath;
}

@property NSArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //
    _objects = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ImageList" ofType:@"plist"]];
    
    //
    [self.tableView setDelegate:self];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    cell.textLabel.text = object[@"text"];
    cell.imageView.image = [UIImage imageNamed:object[@"image"]];
    return cell;
}

//- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return _objects.allKeys[section];
//}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    return YES;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selectedIndexPath!=nil && indexPath.section == selectedIndexPath.section && indexPath.row == selectedIndexPath.row) return 30.0f;
    
    return [_objects[indexPath.row][@"image"] length] ? 100.0f : 60.0f;
}

- (void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedIndexPath = indexPath;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
