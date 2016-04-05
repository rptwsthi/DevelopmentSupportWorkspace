//
//  FormattingPage.m
//  
//
//  Created by Developer on 05/04/16.
//
//

#import "FormattingPage.h"

@implementation FormattingPage

@end

//
//  ContactViewController.m
//  SimpleMessaging
//
//  Created by Subhasis Saha on 17/03/15.
//  Copyright (c) 2015 Technologies33. All rights reserved.

#import "ContactViewController.h"
#import "SettingViewController.h"
#import "SendMessageViewController.h"
#import "InviteContactViewController.h"
#import "MessageListViewController.h"
#import "EditProfileViewController.h"
#import "ChangePasscodeViewController.h"
#import "CommunityBoardViewController.h"
#import "LeaderBoardViewController.h"
#import "ContactTVCell.h"
#import "ContactData.h"
#import "SVProgressHUD.h"
#import "ContactManager.h"
#import "ContactViewController.h"
#import "DAKeyboardControl.h"

NSInteger const kTagUnblockUserAlert = 101;

@interface ContactViewController ()
{
    NSMutableArray * arrContactList;
    NSMutableArray * arrSelectedContacts;
}

@end

@implementation ContactViewController

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrContactList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ContactTVCell";
    ContactTVCell *cell = (ContactTVCell*) [tableView dequeueReusableCellWithIdentifier: cellIdentifier];

    //set
    [cell.btnCheckbox setHidden:YES];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    [cell.btnCheckbox addTarget:self action:@selector(btnCheckBoxTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnCheckbox setHidden:NO];
    [cell.btnCheckbox setTag:indexPath.row];
    
    //
    for (ContactData * contact in arrSelectedContacts) {
        if ([objContactData.memberid isEqualToString:contact.memberid]) {
            [cell.btnCheckbox setSelected:YES];
            break;
        }
        else
            [cell.btnCheckbox setSelected:NO];
    }
    
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.pageWorkingType == enumForshowingBlockedFriend) {
        return nil;
    }
    return _footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.pageWorkingType == enumForshowingBlockedFriend) return 0.0f;
    
    return 70.0f;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // you need to implement this method too or nothing will work:
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Remove the row from data model
        //sif showing
        [_contactManager block:(self.pageWorkingType != enumForshowingBlockedFriend) contact:arrContactList[indexPath.row]];
        [arrContactList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView reloadData];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES; //tableview must be editable or nothing will work...
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.pageWorkingType == enumForshowingBlockedFriend) {
        return @"Unblock";
    }
    return @"Block";
}

#pragma mark - TableView cell Button Action
- (void) btnCheckBoxTapped:(UIButton *) sender {
    ContactData * objContactData = [arrContactList objectAtIndex:sender.tag];
    if ([sender isSelected]) {
        [sender setSelected:NO];
        [arrSelectedContacts removeObject:objContactData];
    }
    else {
        [sender setSelected:YES];
        [arrSelectedContacts addObject:objContactData];
    }
}

#pragma mark - SettingViewControllerDelegate Methods
- (void) performActionForEnum:(SettingActionType)actionEnum
{
    [self setCurrentActionType:actionEnum];
    switch (actionEnum)
    {
        case enumUsername:
            break;
            
        case enumFindFriend:
        {
            [self NavigateToContactViewControllerForPageWorkingType:enumForFindingFriend];
            break;
        }
            
        case enumInvite:
        {
            [self NavigateToInviteContactViewController];
            break;
        }
            
        case enumEditProfile:
        {
            [self NavigateToEditProfileViewController];
            break;
        }
            
        case enumSentCount:
            break;
            
        case enumReceivedCount:
            break;
            
        case enumChangePasscode:
        {
            [self NavigateToChangePasscodeViewController];
            break;
        }
            
        case enumContactUs:
            break;
            
        case enumRating:
            break;
        case enumCommunityBoard:
        {
            [self NavigateToCommunityBoardViewController];
            break;
        }
        case enumLeaderBoard:
        {
            [self NavigateToLeaderBoardViewController];
            
            break;
        }
            
        case enumUnblock://open contact list with contact you have blocked (or create a new page)
        {
            [self NavigateToContactViewControllerForPageWorkingType:enumForshowingBlockedFriend];
            break;
        }
        case enumAboutUS://open contact list with contact you have blocked (or create a new page)
        {
            InformationTableViewController * ContactVC = (InformationTableViewController *)[[UIStoryboard storyboardWithName:keyStoryBoardName bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier: NSStringFromClass([InformationTableViewController class])];
            [self.navigationController pushViewController:ContactVC animated:YES];
            break;
        }
            
        case enumLogout:
            [self.navigationController popToRootViewControllerAnimated:NO];
            break;
            
        default:
            break;
    }
}

#pragma mark - Navigation

- (void) NavigateToContactViewControllerForPageWorkingType:(PageWorkingType)pageWorkingType
{
    ContactViewController * ContactVC = (ContactViewController *)[[UIStoryboard storyboardWithName:keyStoryBoardName bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier: NSStringFromClass([ContactViewController class])];
    [ContactVC setPageWorkingType:pageWorkingType];
    [ContactVC setCurrentActionType:self.currentActionType];
    [self.navigationController pushViewController:ContactVC animated:YES];
}

- (void) NavigateToInviteContactViewController
{
    InviteContactViewController * ContactListVC = (InviteContactViewController *)[[UIStoryboard storyboardWithName:keyStoryBoardName bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier: NSStringFromClass([InviteContactViewController class])];
    [ContactListVC setCurrentActionType:self.currentActionType];
    [self.navigationController pushViewController:ContactListVC animated:NO];
}

- (void) NavigateToEditProfileViewController
{
    EditProfileViewController * EditProfileVC = (EditProfileViewController *)[[UIStoryboard storyboardWithName:keyStoryBoardName bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier: NSStringFromClass([EditProfileViewController class])];
    [EditProfileVC setCurrentActionType:self.currentActionType];
    [self.navigationController pushViewController:EditProfileVC animated:NO];
}

- (void) NavigateToChangePasscodeViewController
{
    ChangePasscodeViewController* ChangePasscodeVC = (ChangePasscodeViewController *)[[UIStoryboard storyboardWithName:keyStoryBoardName bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier: NSStringFromClass([ChangePasscodeViewController class])];
    [self.navigationController pushViewController:ChangePasscodeVC animated:NO];
}

- (void) NavigateToMessageListViewController
{
    MessageListViewController * MessageListVC = (MessageListViewController *)[[UIStoryboard storyboardWithName:keyStoryBoardName bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier: NSStringFromClass([MessageListViewController class])];
    [self.navigationController pushViewController:MessageListVC animated:YES];
}

- (void) NavigateToCommunityBoardViewController
{
    CommunityBoardViewController * CommunityBoardVC = (CommunityBoardViewController *)[[UIStoryboard storyboardWithName:keyStoryBoardName bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier: NSStringFromClass([CommunityBoardViewController class])];
    [CommunityBoardVC setNavigateFrom:enumNavigateFromOther];
    [CommunityBoardVC setCurrentActionType:self.currentActionType];
    [self.navigationController pushViewController:CommunityBoardVC animated:YES];
}

- (void) NavigateToLeaderBoardViewController
{
    LeaderBoardViewController * LeaderBoardVC = (LeaderBoardViewController *)[[UIStoryboard storyboardWithName:keyStoryBoardName bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier: NSStringFromClass([LeaderBoardViewController class])];
    [LeaderBoardVC setCurrentActionType:self.currentActionType];
    [self.navigationController pushViewController:LeaderBoardVC animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - IBAction Method
- (IBAction)btnGoToSetting:(UIButton *)sender
{
    SettingViewController * SettingVC = (SettingViewController *)[[UIStoryboard storyboardWithName:keyStoryBoardName bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier: NSStringFromClass([SettingViewController class])];
    [SettingVC setDelegate:self];
    [SettingVC setLastAction:self.currentActionType];
    UINavigationController * navcontroller = [[UINavigationController alloc] initWithRootViewController:SettingVC];
    [navcontroller setNavigationBarHidden:YES];
    [navcontroller setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:navcontroller animated:YES completion:nil];
}

- (IBAction)btnDone_Tapped:(UIButton *)sender
{
    if ([arrSelectedContacts count])
    {
        SendMessageViewController * SendMessageVC = (SendMessageViewController *)[[UIStoryboard storyboardWithName:keyStoryBoardName bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier: NSStringFromClass([SendMessageViewController class])];
        [SendMessageVC setMessageType:self.messageType];
        [SendMessageVC setConversationType:self.conversationType];
        if (self.conversationType == enumExistingConversation)
            [SendMessageVC setObjReceivedMessages:self.objReceivedMessages];
        else
            [SendMessageVC setObjMessageData:self.objMessageData];
        [SendMessageVC setSelectedContacts:arrSelectedContacts];
        [self.navigationController pushViewController:SendMessageVC animated:YES];
    }
    else
        Show_ToastView(@"Please select atleast one contact");
}

- (IBAction)btnBack_Tapped:(UIButton *)sender {
    [self setCurrentActionType:0];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGSize size = _contactListTableView.contentSize;
    size.height += 120.0f;
    [_contactListTableView setContentSize:size];
    [textField setTextAlignment:NSTextAlignmentCenter];
    [_imgAdd setHidden:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    CGSize size = _contactListTableView.contentSize;
    size.height -= 120.0f;
    [_contactListTableView setContentSize:size];
    
    if ([textField.text length]) [textField setTextAlignment:NSTextAlignmentCenter];
    else [_imgAdd setHidden:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    //service call for search
    if ([textField.text length]) [_contactManager searchContacts:textField.text];
    
    return YES;
}

#pragma mark - ContactManagerDelegate
- (void) contactManager : (ContactManager *) manager blocked : (BOOL) blocked contact : (ContactData *) contact {
    [_refreshControl endRefreshing];
    if (!blocked)
        [self loadTableViewWithContactList];
}

- (void) contactManager : (ContactManager *) manager
                searched: (NSString *) searchedTerm
               contacts : (NSArray *) contactArray {
    [_refreshControl endRefreshing];
    
    if (contactArray!=nil && contactArray.count) {
        _serchedUser = [contactArray lastObject];
        
        //if returned user have blocked this user don't show him in results just act user not found
        if ([_serchedUser[@"blockedMe"] integerValue] == 1) {
            Show_ToastView(@"Not found!");
            _serchedUser = nil;
            return;
        }
        
        //if this user have blocked returned user prompt him to ask if he wants to unblock returned user
        if ([_serchedUser[@"blocked"] integerValue] == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Blocked User!", nil)
                                                            message:NSLocalizedString(@"You have blocked this user.", nil)
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                                  otherButtonTitles:NSLocalizedString(@"Unblock", nil), nil];
            alert.tag = kTagUnblockUserAlert;
            [alert show];
        }
        else{
            [SVProgressHUD showSuccessWithStatus:nil];
            [self loadTableViewWithContactList];
        }
    }else{
        Show_ToastView(@"Not found!");
    }
}

//Alert Delegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (alertView.tag) {
        case kTagUnblockUserAlert:
            if (buttonIndex == 1) {
                ContactData *contactData = (ContactData *)[Utility getRecord:NSStringFromClass([ContactData class]) where:[NSString stringWithFormat:@"memberid = '%@'", _serchedUser[@"memberid"]]];
                [_contactManager block:NO contact:contactData];
            }
            break;
            
        default:
            break;
    }
}

@end