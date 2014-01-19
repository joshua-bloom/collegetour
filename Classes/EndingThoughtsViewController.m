//
//  EndingThoughts.m
//  TourProject
//
//  Created by Samuel Clark on 3/22/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import "EndingThoughtsViewController.h"
#import "College.h"
#import "TextViewController.h"

@implementation EndingThoughtsViewController
@synthesize vibe,tourGuide,notes,col,hide,thoughts,currTime,town;

	//initializer which allows us to pass college and context from previous view
-(id) initWithCollege:(College*)collegeModel andContext:(NSManagedObjectContext*)context{
	if (self =[self initWithNibName:nil bundle:nil]){
		col = collegeModel;
		moc = context;
	}
	return self;		
}

	//loads text view for thought input
-(IBAction) goToThoughts:(UIButton *)thoughts {
	TextViewController *tv = [[TextViewController alloc] initWithCollege:col];
	tv.title = @"Additional Notes";
	[self.navigationController pushViewController:tv  animated:YES];
	[tv release];
}


-(void) hideKeyBoard:(UIButton *)hide {
		//
}

	//saves college to cor data, called after end tour
- (void)saveContext {
    NSError *error = nil;
    if (moc != nil) {
        if ([moc hasChanges] && ![moc save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }     
    }
}    

	//functionality responding to end tour button. sets final variables, calculates rating, saves college, goes home. Need to check to make sure they want to end tour.



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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
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

-(void) updateCol {
	
	self.col.vibe = [NSNumber numberWithInt:vibe.selectedSegmentIndex];
	NSLog(@"vibe = %@",self.col.vibe);
	self.col.tourGuide = [NSNumber numberWithInt:tourGuide.selectedSegmentIndex];
	self.col.town = [NSNumber numberWithInt:town.selectedSegmentIndex];
		//[self.col populateDictionary];
		//[self saveContext];
	NSLog(@"COLLEGE = %@",col);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc. that aren't in use.
}



-(void) viewWillDisappear:(BOOL)animated{
		//[self updateCol];
		//[self saveContext];
		
}
- (void)viewDidUnload {
		[self updateCol];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


@end
