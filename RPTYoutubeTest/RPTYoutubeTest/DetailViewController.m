//
//  DetailViewController.m
//  RPTYoutubeTest
//
//  Created by Developer on 10/04/16.
//  Copyright © 2016 Neerav. All rights reserved.
//

#import "DetailViewController.h"
#import "YTPlayerView.h"

@interface DetailViewController ()

@property (strong, nonatomic) IBOutlet YTPlayerView *playerView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item
- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        // Update the view.
        //[self configureView];
    }
}

- (void)configureView {
    NSString *youtubeURL = ((NSString *) _detailItem);//((NSString *) _detailItem).lastPathComponent;
    // Update the user interface for the detail item.
    NSLog(@"_detailItem = %@, videoId = %@", _detailItem, youtubeURL);
    [self.playerView loadVideoByURL:youtubeURL startSeconds:5.0f suggestedQuality:kYTPlaybackQualityMedium];
    return;
    
    NSError *error = NULL;
    NSString *regexString = @"http://(?:www\.)?youtu(?:be\.com/watch\?v=|\.be/)([\w\-]+)(&(amp;)?[\w\?=]*)?";
    NSRegularExpression *regex =
    [NSRegularExpression regularExpressionWithPattern:regexString
                                              options:NSRegularExpressionCaseInsensitive
                                                error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:youtubeURL
                                                    options:0
                                                      range:NSMakeRange(0, [youtubeURL length])];
    if (match) {
        NSRange videoIDRange = [match rangeAtIndex:1];
        NSString *substringForFirstMatch = [youtubeURL substringWithRange:videoIDRange];
        if (substringForFirstMatch) {
//        [self.playerView loadVideoByURL:_detailItem startSeconds:0 endSeconds:0 suggestedQuality:kYTPlaybackQualityAuto];
//        [_playerView loadVideoById:videoId startSeconds:0 suggestedQuality:kYTPlaybackQualityAuto];
//            [self.playerView loadWithVideoId:substringForFirstMatch];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //
    [self configureView];
}

@end
