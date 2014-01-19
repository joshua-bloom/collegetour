//
//  StartScreen.h
//  TourProject
//
//  Created by Samuel Clark on 3/21/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewTourViewController;

// first view seen when app loads
@interface StartScreen : UIViewController {
	// add main menue buttons
	UIButton *newTour;
	UIButton *oldTours;
	UIButton *settings;
	UIButton *about;
	NewTourViewController *tv;
	NSManagedObjectContext* context;
}

// declare methods
-(id) initWithManagedObjectContext:(NSManagedObjectContext *) moc ;
-(IBAction) switchToNewTour:(UIButton*) newTour;
-(IBAction) switchToOldTours:(UIButton*) oldTours;
-(IBAction) switchToSettings:(UIButton*) settings;
-(IBAction) switchToAbout:(UIButton*) about;

@property (nonatomic, retain) NSManagedObjectContext* context;
@property (nonatomic, retain) NewTourViewController* tv;
@property (nonatomic, retain) IBOutlet UIButton* newTour;
@property (nonatomic, retain) IBOutlet UIButton* oldTours;
@property (nonatomic, retain) IBOutlet UIButton* settings;
@property (nonatomic, retain) IBOutlet UIButton* about;

@end
