//
//  CollegeWebViewController.m
//  Tour
//
//  Created by Joshua Bloom on 5/16/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import "CollegeWebViewController.h"
#import "Reachability.h"

@implementation CollegeWebViewController
@synthesize webView,webUrl,activity;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

-(int)checkInternet {
	//Test for Internet Connection
	Reachability *r = [Reachability reachabilityForInternetConnection];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	int internet;
	if (internetStatus == ReachableViaWiFi) {
		internet = 1;
	}
	else if (internetStatus == ReachableViaWWAN) {
		internet = 1;
	}
	else {
		internet = 0;
	}
	return internet;
}

-(id) initWithURl:(NSString *) url {
	if (self = [super init]) {
		webUrl = url;
	}
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	int gotInternet = [self checkInternet]; //Test for Internet, calling the self method
	if  (gotInternet == 0) {
		UIAlertView *noInternet = [[UIAlertView alloc]initWithTitle:@"No Active Connection" message:@"Your device is not currently connected to the internet, please connect and try again" delegate:self cancelButtonTitle:@"back" otherButtonTitles:nil];
		[noInternet show];
		[noInternet release];
	}
	else {
		NSString *urlAddress = webUrl;
		NSURL *url = [NSURL URLWithString:urlAddress];						//Create a URL object.
		NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];		//URL Requst Object
		[webView loadRequest:requestObj];	//Load the request in the UIWebView.
		timer = [NSTimer scheduledTimerWithTimeInterval:(1.0/2.0) target:self selector:@selector(loading) userInfo:nil repeats:YES];
	}

	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)loading {
		//activity indicator function
	if (!webView.loading) {
		[activity stopAnimating];
		activity.alpha = 0.0;
		[activity hidesWhenStopped];
	}
	else {
		activity.alpha = 1.0;
		[activity startAnimating];
	}
	
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[webView release];
    [super dealloc];
}


@end
