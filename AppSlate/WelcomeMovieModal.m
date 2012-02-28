//
//  WelcomeMovieModal.m
//  AppSlate
//
//  Created by 김 태한 on 12. 2. 17..
//  Copyright (c) 2012년 ChocolateSoft. All rights reserved.
//

#import "WelcomeMovieModal.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation WelcomeMovieModal

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // Margin between edge of container frame and panel. Default = 20.0
        if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
            // I am iPad
            self.outerMargin = 100.0f;
            self.cornerRadius = 20.0;
        }
        else {
            // I am iPhone
        }
        // Margin between edge of panel and the content area. Default = 20.0
        self.innerMargin = 10.0f;

        [self setTitleBarHeight:40];
        self.headerLabel.text = @"Welcome to AppSlate";

        [self embedYouTube:@"http://www.youtube.com/embed/-G8fG1bKgQo" frame:CGRectMake(10, 90, 530, 380)];

        UISwitch *killSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(10, 700, 60, 30)];
        [killSwitch setOnTintColor:[UIColor grayColor]];
        [killSwitch addTarget:self action:@selector(notWelcome:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:killSwitch];

        turnOffLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 700, 180, 30)];
        [turnOffLabel setBackgroundColor:CSCLEAR];
        [turnOffLabel setTextColor:[UIColor grayColor]];
        [turnOffLabel setFont:CS_FONT(13)];
        [turnOffLabel setText:@"Do not show this again"];
        [self.contentView addSubview:turnOffLabel];
    }

    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews {
	[super layoutSubviews];
}

- (void)embedYouTube:(NSString *)urlString frame:(CGRect)frame
{
    NSString *embedHTML = @"<html><head>\
    <style type=\"text/css\">\
    body { background-color: transparent; color: white; }\
    </style>\
    </head><body style=\"margin:0\">\
    <iframe width=\"%0.0f\" height=\"%0.0f\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe>\
    </body></html>";
    NSString *html = [NSString stringWithFormat:embedHTML, frame.size.width, frame.size.height, urlString ];
    UIWebView *videoView = [[UIWebView alloc] initWithFrame:frame];
    [videoView loadHTMLString:html baseURL:nil];
    [self.contentView addSubview:videoView];
}

- (void) notWelcome:(UISwitch*)sw
{
    [[NSUserDefaults standardUserDefaults] setBool:sw.isOn forKey:@"WELCOME_SWITCH"];

    if( sw.isOn )
        [turnOffLabel setTextColor:[UIColor lightGrayColor]];
    else {
        [turnOffLabel setTextColor:[UIColor grayColor]];
    }
}

@end