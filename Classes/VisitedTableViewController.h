//
//  VistitedTableViewController.h
//  Tour
//
//  Created by Samuel Clark on 3/30/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@class College;

@protocol VisitedViewDelegate
- (int)sortValueForControl;
@end

@interface VisitedTableViewController : CoreDataTableViewController  {
	College *col;
	int sortChoice;
	int choiceCount;
	NSManagedObjectContext *cxt;
	UIBarButtonItem *sorter;
}

-(void) changeSort:(int)newSortChoice;
- initInManagedObjectContext:(NSManagedObjectContext *)context;

@property(nonatomic, retain) NSManagedObjectContext *cxt;
@property(nonatomic, retain) UIBarButtonItem*sorter;

@end
