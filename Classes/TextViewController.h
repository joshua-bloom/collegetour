//
//  TextViewController.h
//  TourProject
//
//  Created by Samuel Clark on 3/23/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class College;

@interface TextViewController : UIViewController <UITextViewDelegate> {
	College * col;
	UITextView *tv;
}

-(id) initWithCollege:(College*) collegeModel;
-(IBAction) updateText:(UITextView*) textv;

@property(nonatomic, retain) College* col;
@property(nonatomic, retain) IBOutlet UITextView *tv;

@end
