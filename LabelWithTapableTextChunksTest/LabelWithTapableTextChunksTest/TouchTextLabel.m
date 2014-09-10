//
//  UILabel+TouchTextLabel.m
//  LabelWithTapableTextChunksTest
//
//  Created by Developer on 07/09/14.
//  Copyright (c) 2014 Neerav. All rights reserved.
//

#import "TouchTextLabel.h"

@interface TouchTextLabel()
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) NSArray  *touchTextArray;

@end

@implementation TouchTextLabel

- (void) awakeFromNib{
    // Initialization code
    [self addInternalWebView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addInternalWebView];
    }
    return self;
}

- (id) init{
    if (self = [super init]) {
        [self addInternalWebView];
    }
    return self;
}

- (void) addInternalWebView{
    [self setUserInteractionEnabled:YES];
    [self setNumberOfLines:0];
    [self.webView setUserInteractionEnabled:YES];
    
    self.webView = [[UIWebView alloc] init];
    CGRect frame = self.frame;
    frame.origin = CGPointZero;
    [self.webView setFrame:frame];
    [self.webView setDelegate:self];
    [self.webView.scrollView setScrollEnabled:NO];
    [self addSubview:self.webView];
}

- (void) setTouchLabelFrame:(CGRect)frame{
    [self setFrame:frame];
    [self.webView setFrame:frame];
}

- (NSArray *) getTextDetailArray{
    NSMutableArray *array = [NSMutableArray array];
    
    NSInteger numeberOfTextChunk = [_ttDatasource numberOfTouchableText];
    for (NSInteger i = 0; i < numeberOfTextChunk; i++) {
        TouchText *textChunk = [_ttDatasource touchText:i];
        [array addObject:textChunk];
    }

    return [NSArray arrayWithArray:array];
}

- (NSString *) createHtml  : (NSString *) textContent touchTextDetails : (NSArray *) touchTextArray{
    NSString *htmlText = nil;
    int index = 0;
    for (TouchText * obj in touchTextArray) {
        NSString *linkText = [NSString stringWithFormat:@"<a href=\"%d\" style=\"color:%@\">%@</a>", index, [obj hexValueOfTextColor], obj.touchText];
        textContent = [textContent stringByReplacingOccurrencesOfString:obj.touchText withString:linkText];
         index++;
    }
    htmlText = [NSString stringWithFormat:@"<html><body>%@</body></html>", textContent];

    return htmlText;
}

- (void) callTouchLabelDelegate : (NSInteger) index{
    [_ttDelegate touchTextLabel:self touchText:_touchTextArray[index] atPosition:index];
}

#pragma mark - Overriding UI LabeMessage
- (void) setText:(NSString *)text{
    _content = text;
    _touchTextArray = [self getTextDetailArray];
    
    NSString *htmlText = [self createHtml:_content touchTextDetails:_touchTextArray];
    [self.webView loadHTMLString:htmlText baseURL:nil];
}

- (void) sizeToFit{
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:self.frame];
    [tempLabel setNumberOfLines:0];
    tempLabel.text = _content;
    [tempLabel sizeToFit];
    CGRect frame = self.frame;
    frame.size = tempLabel.frame.size;
    self.frame = frame;
    
    //set frame
    frame = self.webView.frame;
    frame.size = self.frame.size;
    self.webView.frame = frame;
}

#pragma mark - Webview Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlLastPathComponent = [[request.URL absoluteString] lastPathComponent];
    if ([urlLastPathComponent isEqualToString:@"about:blank"]) {
        return YES;
    }
    
    NSLog(@"request.url = %@", [[request.URL absoluteString] lastPathComponent]);
    [self callTouchLabelDelegate:[[[request.URL absoluteString] lastPathComponent] integerValue]];
    return NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}


@end
