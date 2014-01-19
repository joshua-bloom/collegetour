//
//  AboutTableViewController.h
//  Tour
//
//  Created by Samuel Clark on 5/17/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AboutTableViewController : UITableViewController {
	NSArray *info;
	NSTimer *timer;
	IBOutlet UIActivityIndicatorView *activity;
}

@property(nonatomic,retain) NSArray * info;


@end
