//
//  ViewController.m
//  iOSTest
//
//  Created by Developer on 21/12/15.
//  Copyright © 2015 Neerav. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>
#import <MediaToolbox/MediaToolbox.h>
#import <MediaPlayer/MediaPlayer.h>


@interface ViewController ()<MPMediaPickerControllerDelegate>
@property (nonatomic, strong) MPMediaItemCollection *selectedSongCollection;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) selectSong: (id) sender {
    MPMediaPickerController *picker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    
    picker.delegate                     = self;
    picker.allowsPickingMultipleItems   = NO;
    picker.prompt                       = NSLocalizedString (@"Select any song from the list", @"Prompt to user to choose some songs to play");
    
    [self presentViewController:picker animated:YES completion:nil];
}

-  (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
    [self dismissViewControllerAnimated:YES completion:nil];
    _selectedSongCollection=mediaItemCollection;
}

- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
