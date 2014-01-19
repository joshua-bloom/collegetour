//
//  AboutTableViewController.m
//  Tour
//
//  Created by Samuel Clark on 5/17/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import "AboutTableViewController.h"
#import "CollegeWebViewController.h"


@implementation AboutTableViewController
@synthesize info;

-(id) init {
	if (self =[self initWithNibName:nil bundle:nil]) {
		info = [[NSArray alloc] initWithObjects:@"About Us",@"Email",@"Facebook",@"Twitter",@"Website",@"Icons",@"Promote",@"Acknowledgements",@"FAQ",nil];
	}
	return self;		
}


#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return info.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.textLabel.text = [info objectAtIndex:indexPath.row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */

	NSString *aMsg = @"Developed by Sam Clark and Josh Bloom, Juniors @ Swarthmore College";
	NSString *tMsg = @"Follow us on twitter: @CollegeVisApp  for news about updates and future plans";
	NSString *fMsg = @"Check us out on our Facebook Page, College Visions";
	NSString *iMsg = @"Icons by Joseph Wain / Glyph Icons,  www.glyphicons.com ";
	NSString *eMSg = @"Email us with questions, comments, or anytype of feedback at feedback@collegevisions.net";
	NSString *pMsg = @"Want to promote your college when this app loads? Contact jbloom@collegevisions.net for more information";
	NSString *ackMsg = @"Special thanks to Richard Wicentowski";
	
	UIAlertView *detail;
	if (indexPath.row ==0) {
		detail = [[UIAlertView alloc] initWithTitle:@"Who we are" message:aMsg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[detail show];
		[detail release];
	}
	if (indexPath.row == 1) {
		detail = [[UIAlertView alloc] initWithTitle:@"Email us" message:eMSg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[detail show];
		[detail release];
	}
	if (indexPath.row == 2) {
		detail = [[UIAlertView alloc] initWithTitle:@"Facebook" message:fMsg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[detail show];
		[detail release];
	}
	if (indexPath.row == 4) {
		CollegeWebViewController * wvc = [[CollegeWebViewController alloc] initWithURl:@"http://www.collegevisions.net"];
		[self.navigationController pushViewController:wvc animated:YES];
		[wvc release];
	}
	if (indexPath.row == 3) {
		detail = [[UIAlertView alloc] initWithTitle:@"Twitter" message:tMsg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[detail show];
		[detail release];
	}
	if (indexPath.row == 5) {
		detail = [[UIAlertView alloc] initWithTitle:@"Icons" message:iMsg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[detail show];
		[detail release];
	}
	if (indexPath.row == 6) {
		detail = [[UIAlertView alloc] initWithTitle:@"Promote" message:pMsg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[detail show];
		[detail release];
	}
	if (indexPath.row == 7 ) {
		detail = [[UIAlertView alloc] initWithTitle:@"Thanks" message:ackMsg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[detail show];
		[detail release];
	}
	if (indexPath.row == 8 ) {
		CollegeWebViewController * wvc = [[CollegeWebViewController alloc] initWithURl:@"http://www.collegevisions.net/faq"];
		[self.navigationController pushViewController:wvc animated:YES];
		[wvc release];
	}
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
}


@end

