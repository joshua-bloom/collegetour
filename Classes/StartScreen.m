//
//  StartScreen.m
//  TourProject
//
//  Created by Samuel Clark on 3/21/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import "StartScreen.h"
#import "NewTourViewController.h"
#import "SettingsTableViewController.h"
#import "VisitedTableViewController.h"
#import "AboutTableViewController.h"

@implementation StartScreen
@synthesize newTour, oldTours, settings, tv, context, about;

-(id) initWithManagedObjectContext:(NSManagedObjectContext *) moc {
	if (self = [super init]) {
		context = moc;	
	}
	return self;
}

-(NewTourViewController*) tv {
	if (!tv) {
		tv = [[NewTourViewController alloc] initWithManagedObjectContext:context];
		tv.title = @"New Tour";
	}
	return tv;
}

-(IBAction) switchToNewTour:(UIButton*) newTour {
	[self.navigationController pushViewController:self.tv animated:YES];
	self.tv = nil;
}

-(IBAction) switchToAbout: (UIButton*) about {
	AboutTableViewController * atvc = [[AboutTableViewController alloc] init];
	atvc.title = @"About";
	[self.navigationController pushViewController:atvc animated:YES];
	[atvc release];
}

-(IBAction) switchToSettings:(UIButton*)settings {
	SettingsTableViewController	*stvc = [[SettingsTableViewController alloc] init];
	stvc.title = @"Preferences";
	[self.navigationController pushViewController:stvc animated:YES];
	[stvc release];
}

-(IBAction) switchToOldTours: (UIButton *) oldTours {
	VisitedTableViewController* vtvc = [[VisitedTableViewController alloc] initInManagedObjectContext:context];
	vtvc.title = @"Visited Colleges";
	NSLog(@"created vtvc");
	[self.navigationController pushViewController:vtvc animated:YES];
	[vtvc release];
	NSLog(@"pushed vtvc");
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

/*- (void)viewDidLoad {

    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


@end
