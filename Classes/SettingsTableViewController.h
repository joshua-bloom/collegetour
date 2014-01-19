//
//  SettingsTableViewController.h
//  Tour
//
//  Created by Samuel Clark on 4/13/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsTableViewController.h"

@interface SettingsTableViewController : UITableViewController  {
	NSArray *objs;
	NSMutableDictionary *dic;
	NSMutableArray *bin;
}

-(void)showAlert:(id) sender;

@property(nonatomic,retain) NSArray *objs;
@property(nonatomic,retain) NSMutableDictionary* dic;

@end
