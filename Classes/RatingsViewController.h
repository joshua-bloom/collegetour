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

@class EndingThoughtsViewController;

@interface RatingsViewController : UIViewController <DLStarRatingDelegate> {
	College *col;
	DLStarRatingControl *dorms,*food,*athletics,*campus,*social,*academics,*town;
	EndingThoughtsViewController *et;
	NSManagedObjectContext *moc;
}

@property (nonatomic,retain) DLStarRatingControl *dorms,*food,*athletics,*campus,*social,*academics,*town;
@property (nonatomic,retain) EndingThoughtsViewController *et;

-(id) initWithCollege:(College*)collegeModel andContext:(NSManagedObjectContext*)context;
-(void)newRating:(int)rating;
-(void)updateRatings;

@end
