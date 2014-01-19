//
//  NewTourView.m
//  TourProject
//
//  Created by Samuel Clark on 3/21/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import "NewTourViewController.h"
#import "College.h"
#import "RatingsViewController.h"
#import "ItemDetailController.h"
#import "EndingThoughtsViewController.h"

@implementation NewTourViewController
@synthesize entry, weatherCont;
@synthesize keyboard, context, info, details, ttbc, checkEnd, college;


	//initializes view witht managed context from app delegate
-(id) initWithManagedObjectContext:(NSManagedObjectContext *) moc {
	if (self = [super init]) {
		context = moc;

	}
	return self;
}

- (void)saveContext {
    NSError *error = nil;
    if (context != nil) {
        if ([context hasChanges] && ![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }     
    }
}    

	//creates a college object for the first time and gives it name + weather. Checks for no input .Starts a tour.
-(IBAction) makeCollege{
	if (self.entry.text.length == 0) {
		UIAlertView *noName = [[UIAlertView alloc] initWithTitle:@"Incomplete Entry" message:@"Please enter a name for the college before continuing" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[noName show];
		[noName release];
	}
	else {
		college = [NSEntityDescription insertNewObjectForEntityForName:@"College"
												inManagedObjectContext:context];
		college.name = self.entry.text;
		college.dat = [NSDate date];
		college.weather = [NSNumber numberWithInt:self.weatherCont.selectedSegmentIndex];
		
		//creating the 3 view controllers 
		ItemDetailController * idc = [[ItemDetailController alloc] init];
		idc.title = @"Camera";
		UIImage * cam = [UIImage imageNamed:@"Camera.png"];
		idc.tabBarItem.image = cam;
		RatingsViewController * rv = [[RatingsViewController alloc] initWithCollege:college andContext:context];
		rv.title = @"Ratings";
		UIImage * str = [UIImage imageNamed:@"28-star.png"];
		rv.tabBarItem.image = str;
		
		EndingThoughtsViewController *et = [[EndingThoughtsViewController alloc]initWithCollege:college andContext:context];

		et.title = @"Final Thoughts";
		UIImage * light = [UIImage imageNamed:@"179-notepad.png"];
		et.tabBarItem.image = light;
		tbc = [[UITabBarController alloc] init];
		UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStylePlain
																			 target:self 
																			 action:@selector(saveAndEnd)];
		tbc.navigationItem.rightBarButtonItem = bbi;
		lbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStylePlain
																			 target:self 
																			 action:@selector(saveAndEnd)];
		
		NSArray *vc = [[NSArray alloc] initWithObjects:rv, et, idc, nil];
		tbc.viewControllers = vc;
		tbc.title = college.name;
		tbc.navigationItem.leftBarButtonItem = lbi;
		[self.navigationController pushViewController:tbc animated:YES];
		

		[idc release];
		[rv release];
		[vc release];
		[et release];
		[bbi release];
		[lbi release];
	}
}

-(void) saveAndEnd {
	NSString *msg = @"Are you sure you are ready to end your tour";
	checkEnd = [[UIAlertView alloc] initWithTitle:@"Done?" message:msg delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
	[checkEnd show];	
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0 && alertView == checkEnd) {

		NSLog(@"Final Thoughts == %@",college.finalThoughts);
		if (!college.finalThoughts) {
			college.finalThoughts = @"Nothing entered";
		}
	
		
		[college populateDictionary];
		self.college.rating =  [NSNumber numberWithFloat:[self.college calculateCollegeRating]];
		NSLog(@"Rating  = %@",college.rating);
		[self saveContext]; 
		
		
		[self.navigationController popToRootViewControllerAnimated:YES];
		
	}
	else {
		[checkEnd release];
	}
}

-(IBAction) showInfo:(UIButton *) info {
	NSString *msg = @"This is where you can start your tour. Enter the college you are visiting in the text field above. Next just select what the weather is like and you'll be on your way. The date will be recorded for you automatically";
	details = [[UIAlertView alloc] initWithTitle:@"Whats going on?" message:msg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
	[details show];
	[details release];
}

-(IBAction) hideKeyBoard:(id)sender {
	entry.resignFirstResponder;
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

- (void)viewDidLoad {
    [super viewDidLoad];
}

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
	//[self saveContext];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {	
    [super dealloc];
}


@end
