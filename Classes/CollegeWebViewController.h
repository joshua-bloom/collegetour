//
//  CollegeWebViewController.h
//  Tour
//
//  Created by Joshua Bloom on 5/16/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollegeWebViewController : UIViewController {
	IBOutlet UIWebView *webView;
	NSString *webUrl; 
	NSArray *info;
	NSTimer *timer;
	IBOutlet UIActivityIndicatorView *activity;
}

-(id) initWithURl:(NSString *)url;

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) NSString *webUrl;
@property (nonatomic, retain) UIActivityIndicatorView * activity;
@end
