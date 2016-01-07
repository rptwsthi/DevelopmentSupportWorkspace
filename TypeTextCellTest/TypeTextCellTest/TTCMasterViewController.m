//
//  TTCMasterViewController.m
//  TypeTextCellTest
//
//  Created by Developer on 19/09/14.
//  Copyright (c) 2014 rptwsthi. All rights reserved.
//

#import "TTCMasterViewController.h"

@interface TTCMasterViewController (){
    NSMutableDictionary *textCellDictionary;
}
@end

@implementation TTCMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    textCellDictionary = [NSMutableDictionary dictionary];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        switch (indexPath.row) {
            case 0:
                //image cell
                break;
            case 1:
                //image cell
                break;
            case 2:
                //Video player cell
                break;
            case 3:
                //webview cell
                break;
            case 4:
                //any other cell
                break;


            default:
                break;
        }
        TypeTextTableViewCell *cell = (TypeTextTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"ttcIdentifier" forIndexPath:indexPath];
        [cell setDelegate:self];
        cell.ttcTextView.text = textCellDictionary[indexPath][@"text"];
        [cell setParentTableView:self.tableView];
        return cell;
    }

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (textCellDictionary[indexPath] != nil) {
        return [textCellDictionary[indexPath][@"height"] floatValue];
    }
    
    return 60.0f;
}

#pragma mark - TypeTextTableViewCellDelegate

- (void) typeText:(NSString *)string cell:(TypeTextTableViewCell *)cell heightChange:(CGFloat)newHeight{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *dictionary = [NSDictionary dictionary];
    dictionary = @{@"text": string, @"height" : [NSNumber numberWithFloat:newHeight]};
    [textCellDictionary setObject:dictionary forKey:indexPath];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
