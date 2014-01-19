//
//  RatingsView.h
//  TourProject
//
//  Created by Samuel Clark on 3/21/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "College.h"
#import "DLStarRatingControl.h"

// view controller to handle the star ratings portion of college evaluation
@class EndingThoughtsViewController;

@interface RatingsViewController : UIViewController <DLStarRatingDelegate> { // declare star delegate
	College *col; // takes college
	DLStarRatingControl *dorms,*food,*athletics,*campus,*social,*academics,*town;
	EndingThoughtsViewController *et;
	NSManagedObjectContext *moc;
}

@property (nonatomic, retain) DLStarRatingControl *dorms,*food,*athletics,*campus,*social,*academics,*town;
@property (nonatomic, retain) EndingThoughtsViewController *et;

// methods
-(id) initWithCollege:(College*)collegeModel andContext:(NSManagedObjectContext*)context;
-(void)newRating:(int)rating;
-(void)updateRatings;

@end
