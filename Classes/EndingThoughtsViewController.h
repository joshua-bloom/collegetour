//
//  EndingThoughts.h
//  TourProject
//
//  Created by Samuel Clark on 3/22/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class College;

@interface EndingThoughtsViewController : UIViewController {
	UISegmentedControl *vibe;
	UISegmentedControl *tourGuide;
	UITextField *notes;
	UIButton *end;
	College *col;
	UIButton *hide;
	UIButton *thoughts;
	NSManagedObjectContext *moc;
	UIAlertView *checkEnd;
	NSDate *currTime;
	UISegmentedControl *town;
}

-(id) initWithCollege:(College*)collegeModel andContext:(NSManagedObjectContext*)context;
-(IBAction) setVibe:(UISegmentedControl *) vibe;

-(IBAction) hideKeyBoard:(UIButton *) hide;
-(IBAction) goToThoughts:(UIButton *) thoughts;

@property (nonatomic, retain) IBOutlet UISegmentedControl *vibe;
@property (nonatomic, retain) IBOutlet UISegmentedControl *tourGuide, *town;
@property (nonatomic, retain) IBOutlet UITextField * notes;
@property (nonatomic, retain) College *col;
@property (nonatomic, retain) IBOutlet UIButton *hide, *thoughts;
@property (nonatomic, retain) NSDate * currTime;

@end
