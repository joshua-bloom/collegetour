//
//  TextViewController.m
//  TourProject
//
//  Created by Samuel Clark on 3/23/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import "TextViewController.h"
#import "College.h"

@implementation TextViewController
@synthesize col, tv;

-(id) initWithCollege:(College*) collegeModel {
	if (self =[self initWithNibName:nil bundle:nil]){
		col = collegeModel;
		tv.delegate = self;
	}
	return self;		
}

-(IBAction) updateText:(UITextView *) textv {
	col.finalThoughts = self.tv.text;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
	/*
		create text view
	*/
	if (range.length==0) {
        if ([text isEqualToString:@"\n"]) {
			[textView resignFirstResponder];
			col.finalThoughts = self.tv.text;
			NSLog(@"%@",col.finalThoughts);
			[self.navigationController popViewControllerAnimated:YES];
            return NO;
		}
	}
	return YES;
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
	if (col.finalThoughts != NULL ){
		self.tv.text = col.finalThoughts;
	}
	
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

-(void) viewWillDisappear {
	col.finalThoughts = self.tv.text;
	NSLog(@"setting final thoughts to %@",col.finalThoughts);
}
- (void)viewDidUnload {
	col.finalThoughts = self.tv.text;
	NSLog(@"setting final thoughts to %@",col.finalThoughts);
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


@end
