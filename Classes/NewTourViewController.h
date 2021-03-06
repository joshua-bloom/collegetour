//
//  NewTourView.h
//  TourProject
//
//  Created by Samuel Clark on 3/21/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class College;
@class TourTabBarController;
//@class Camera;

// parent view controller for beginning new tour functionality
@interface NewTourViewController : UIViewController <UIAlertViewDelegate> {
	UITextField* entry;
	UISegmentedControl *weatherCont;
	NSManagedObjectContext *context;
	UIButton *keyboard;
	UIButton * info;
	// alerts
	UIAlertView *details;
	UIAlertView *checkEnd;
	// nav controllers
	TourTabBarController *ttbc;
	UITabBarController *tbc;
	College *college;
	UIBarButtonItem *lbi;
}

// methods
-(IBAction) makeCollege; // create new college
-(IBAction) hideKeyBoard: (id) sender;
-(IBAction) showInfo:(UIButton *) info;

@property(nonatomic, retain) IBOutlet UITextField* entry;
@property(nonatomic, retain) NSManagedObjectContext* context;
@property (nonatomic, retain) IBOutlet UIAlertView *details, *checkEnd;
@property(nonatomic, retain) IBOutlet UISegmentedControl* weatherCont;
@property(nonatomic, retain) IBOutlet UIButton *keyboard,*info;
@property(nonatomic, retain) TourTabBarController* ttbc;
@property(nonatomic, retain) College* college;


@end
