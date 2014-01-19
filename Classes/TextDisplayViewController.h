//
//  TextDisplayViewController.h
//  Tour
//
//  Created by Samuel Clark on 4/10/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import <UIKit/UIKit.h>
@class College;

@interface TextDisplayViewController : UIViewController {
	College *col;
	UITextView *tv;
}

@property (nonatomic,retain) College *col;
@property (nonatomic,retain) IBOutlet UITextView *tv;

@end
