//
//  AboutTableViewController.h
//  Tour
//
//  Created by Samuel Clark on 5/17/11.
//  Copyright 2011 College Visions. All rights reserved.
//

// A TVC to display the information about College Tours
#import <UIKit/UIKit.h>


@interface AboutTableViewController : UITableViewController {
	NSArray *info; // Twitter, email etc
	NSTimer *timer;
	IBOutlet UIActivityIndicatorView *activity; 
}

@property(nonatomic, retain) NSArray * info;


@end
