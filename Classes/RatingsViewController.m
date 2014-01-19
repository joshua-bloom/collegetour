//
//  RatingsView.m
//  TourProject
//
//  Created by Samuel Clark on 3/21/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import "RatingsViewController.h"
#import "College.h"
#import "EndingThoughtsViewController.h"

@implementation RatingsViewController
@synthesize dorms, food, athletics, campus, town, social, academics, et;

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

	//initializer passes college and context to this view.
-(id) initWithCollege:(College*)collegeModel andContext:(NSManagedObjectContext*)context {
	if (self =[self initWithNibName:nil bundle:nil]){
		col = collegeModel;
		moc = context;
		UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStylePlain
																			 target:self 
																			 action:@selector(goToEnd)];
		self.navigationItem.rightBarButtonItem = bbi;
		[bbi release];
	}
	return self;		
}

	//pushes view to EndThoughtsView controller --connected to UIButton
-(void) goToEnd {
	et = [[EndingThoughtsViewController alloc]initWithCollege:col andContext:moc];
	et.title = @"Last Impression";
	[self.navigationController pushViewController:et animated:YES];
}

	//manually draws all the star views into the page (MIGHT NEED TO RELEASE THESE IN DEALLOC)
-(void)createStarViews{
	// make a row for each category
	dorms = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(110, 10, 200, 50) andStars:5];
	dorms.delegate = self;
	food = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(110, 70, 200, 50) andStars:5];
	food.delegate = self;
	athletics = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(110, 130, 200, 50) andStars:5];
	athletics.delegate = self;
	campus = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(110, 190, 200, 50) andStars:5];
	campus.delegate = self;
	//town = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(110, 250, 200, 50) andStars:5];
	//town.delegate = self;
	social = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(110, 310, 200, 50) andStars:5];
	social.delegate = self;
	academics = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(110, 250, 200, 50) andStars:5];
	academics.delegate = self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
//adds drawn stars to view before loading
- (void)viewDidLoad {
	[self createStarViews];
	[self.view addSubview:dorms];
	[self.view addSubview:food];
	[self.view addSubview:athletics];
	[self.view addSubview:campus];
	//[self.view addSubview:town];
	[self.view addSubview:social];
	[self.view addSubview:academics];
	[super viewDidLoad];
}

-(void)newRating:(int)rating {
	[self updateRatings]; 
	//	NSLog(@"%@",[col fullDescription]);
}

-(void) updateRatings {
	col.dorms = [NSNumber numberWithInt:self.dorms.rating];
	col.food = [NSNumber numberWithInt:self.food.rating];
	col.athletics = [NSNumber numberWithInt:self.athletics.rating];
	col.campus = [NSNumber numberWithInt:self.campus.rating];
	//col.town = [NSNumber numberWithInt:self.town.rating];
	col.social = [NSNumber numberWithInt:self.social.rating];
	col.academics = [NSNumber numberWithInt:self.academics.rating];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


@end
