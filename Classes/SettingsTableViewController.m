//
//  SettingsTableViewController.m
//  Tour
//
//  Created by Samuel Clark on 4/13/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "CheckboxViewController.h"

@implementation SettingsTableViewController
@synthesize objs, dic;

#pragma mark -
#pragma mark View lifecycle

- (id)init {
	if (self = [super init]) {
		self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
		objs = [[NSArray alloc] initWithObjects:@"Academics",@"Athletics",@"Dorms",@"Food",@"Campus",@"Town",@"Social",nil];
		dic =[[NSMutableDictionary alloc]init];
		NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
		NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"savedArray"];
		if (dataRepresentingSavedArray != nil) {
			NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
			if (oldSavedArray != nil) {
                bin = [[NSMutableArray alloc] initWithArray:oldSavedArray];
			}
			else {
             	bin = [[NSMutableArray alloc]initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",nil];
			}
		}
		else {
			bin = [[NSMutableArray alloc]initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",nil];
		}
	}
	return self;	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.rightBarButtonItem  = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
																	target:self action:@selector(showAlert:)] autorelease]; 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) showAlert:(id)sender {
	UIAlertView *info = [[UIAlertView alloc] initWithTitle:@"What is this?" message:@"By checking or unchecking a parameter, you can change how much value each category has in the overall rating. Changing the settings after you tour a college will have no effect so make sure to change them before you rate a college" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
	[info show];
	[info release];
}

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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *sectionHeader = nil;

	if (section == 0) {
		sectionHeader = @"User Preferences";
	}
	return sectionHeader;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (section == 0){
		return self.objs.count;
	}
	else {
		return 1;
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	if (indexPath.section == 0 && indexPath.row !=7) {
		cell.textLabel.text = [self.objs objectAtIndex:indexPath.row];
		if ([[bin objectAtIndex:indexPath.row] isEqualToString:@"1"]) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark; 
		}
		else {
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
	}    
    return cell;
}

-(void) viewWillDisappear:(BOOL)animated{
	[[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:bin] forKey:@"savedArray"];
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
	if (indexPath.row !=7) {
		if ([[bin objectAtIndex:indexPath.row]isEqualToString: @"1"]) {
			[bin replaceObjectAtIndex:indexPath.row withObject:@"0"]; 
		}
		else if ([[bin objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
			[bin replaceObjectAtIndex:indexPath.row withObject:@"1"];
		}
		[tableView reloadData];
		[[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:bin] forKey:@"savedArray"];
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

