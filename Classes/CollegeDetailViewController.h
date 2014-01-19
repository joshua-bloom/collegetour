//
//  CollegeDetailViewController.h
//  Tour
//
//  Created by Samuel Clark on 4/1/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageUI/MessageUI.h"

@class TextDisplayViewController;
@class CollegeWebViewController;
@class College;

@interface CollegeDetailViewController : UITableViewController <MFMailComposeViewControllerDelegate> {
	College* col;
	NSArray* keys;
	NSArray* overView;
	UIBarButtonItem *email;
	TextDisplayViewController *tvc;
	TextDisplayViewController *tvc2;
	CollegeWebViewController *wvc;
}

-(id) initWithCollege:(College*) college ;
-(void) makeKeyArray;-(void) makeKeyArray;
-(void) overviewArray;
-(IBAction)showEmailView;
-(void) emailV;
-(int) calculateTotal;

@property (nonatomic,retain) NSArray * keys;
@property (nonatomic,retain) NSArray * overView;

@end
