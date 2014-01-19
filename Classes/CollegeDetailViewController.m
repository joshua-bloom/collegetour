//
//  CollegeDetailViewController.m
//  Tour
//
//  Created by Samuel Clark on 4/1/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import "CollegeDetailViewController.h"
#import "College.h"
#import "MessageUI/MessageUI.h"
#import "TextDisplayViewController.h"
#import "CollegeWebViewController.h"

@implementation CollegeDetailViewController
@synthesize keys, overView;

#pragma mark -
#pragma mark View lifecycle

-(id) initWithCollege:(College*) collegeModel {
	if (self =[self initWithNibName:nil bundle:nil]) {
		col = collegeModel;
		[self makeKeyArray];
		[self overviewArray];
		self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
		email = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(emailV)];
		self.navigationItem.rightBarButtonItem = email;
	}
	return self;		
}

-(void) makeKeyArray {
	keys = [[NSArray alloc] init];
	[col.dic removeObjectForKey:@"Weather"];
	self.keys = [col.dic allKeys];
	self.keys = [self.keys sortedArrayUsingSelector:@selector(compare:)];
}

-(void) overviewArray {
	NSString *w;
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"MMM dd, yyyy HH:mm"];
	NSString *datString = [format stringFromDate:col.dat];
	if ([col.weather intValue] == 0) {
		w = @"Weather: Miserable";
	}
	else if ([col.weather intValue] == 1){
		w = @"Weather: Alright";
	}
	else {
		w = @"Weather: Good";
	}
	int rawScore = [self calculateTotal];
	overView = [[NSArray alloc] initWithObjects:col.name,datString,w,[NSString stringWithFormat:@"Overall Rating = %.2f",[col.rating floatValue]],[NSString stringWithFormat:@"Raw Score = %d/41",rawScore],nil];
	[format release];
}

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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (section == 0 ) {
		return overView.count;
	}
	if (section == 1) {
		 return col.dic.count;
	}
	return col.dic.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return @"Overview";
	}
	else {
		return @"Ratings";
	}
}

	// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.textLabel.textAlignment = UITextAlignmentLeft;
    }

	// first table in group table view (Overview)
	if (indexPath.section == 0) {
		// adds icons and text to tableview cells
		switch (indexPath.row) {
			case 0:		// College
				cell.imageView.image = [UIImage imageNamed:@"140-gradhat.png"];
				cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.overView objectAtIndex:indexPath.row]];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;	// cell appears unselected
				cell.accessoryType = UITableViewCellAccessoryNone;
				break;
			case 1:		// Date
				cell.imageView.image = [UIImage imageNamed:@"83-calendar.png"];
				cell.textLabel.text = [NSString stringWithFormat:@" %@",[self.overView objectAtIndex:indexPath.row]];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;	// cell appears unselected
				cell.accessoryType = UITableViewCellAccessoryNone;
				break;
			case 2:		// Weather
				cell.imageView.image = [UIImage imageNamed:@"25-weather.png"];
				cell.textLabel.text = [NSString stringWithFormat:@" %@",[self.overView objectAtIndex:indexPath.row]];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;	// cell appears unselected
				break;
			case 3:		// Rating
				cell.imageView.image = [UIImage imageNamed:@"161-calculator.png"];
				cell.textLabel.text = [NSString stringWithFormat:@"  %@",[self.overView objectAtIndex:indexPath.row]];
				cell.selectionStyle = UITableViewCellSelectionStyleBlue;	// cell appears selected
				cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
				break;
			case 4:		// Raw Score
				cell.imageView.image = [UIImage imageNamed:@"17-bar-chart.png"];
				cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.overView objectAtIndex:indexPath.row]];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;	// cell appears unselected
				break;
			default:
				break;
		}
		// sets tableview cell colors based on ratings, sets all others to white
		if (indexPath.row == 3) {		// Overall Rating
			if ([col.rating floatValue] >= 80.00) {
				cell.backgroundColor = [UIColor colorWithRed:0.5 green:1.0 blue:0.5 alpha:0.7];		// green cell color
			}
			else if ([col.rating floatValue] >= 70.00 && [col.rating floatValue] < 80.00) {
				cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:0.90];	// yellow cell color
			}
			else {
				cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.2 blue:0.3 alpha:0.7];		// red cell color
			}
		}
		else if (indexPath.row == 4) {	// Raw Score
			int rawScore = [self calculateTotal];
			if (rawScore >= 30) {
				cell.backgroundColor = [UIColor colorWithRed:0.5 green:1.0 blue:0.5 alpha:0.7];		// green cell color
			}
			else if (rawScore >= 15 && rawScore < 30) {
				cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:0.90];	// yellow cell color
			}
			else {
				cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.2 blue:0.3 alpha:0.7];		// red cell color
			}
		}
		else {							// for all other categories in Overview
			cell.backgroundColor = [UIColor whiteColor];
		}
	}
	
	// second table in group table view (Ratings)
	if (indexPath.section == 1) {
		//adds icons and text w/ ratings to tableview cells
		switch (indexPath.row) {
			case 0:		// Academics
				cell.imageView.image = [UIImage imageNamed:@"96-book.png"];
				//cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"42-photos"]];
				cell.textLabel.text = [NSString stringWithFormat:@"   %@ = %@ / 5",[self.keys objectAtIndex:indexPath.row],[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]]];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;	// cell appears unselected
				cell.accessoryType = UITableViewCellAccessoryNone;
				break;
			case 1:		// Athletics
				cell.imageView.image = [UIImage imageNamed:@"63-runner.png"];
				//cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"42-photos"]];
				cell.textLabel.text = [NSString stringWithFormat:@"   %@ = %@ / 5",[self.keys objectAtIndex:indexPath.row],[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]]];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;	// cell appears unselected
				cell.accessoryType = UITableViewCellAccessoryNone;
				break;
			case 2:		// Campus
				cell.imageView.image = [UIImage imageNamed:@"121-landscape.png"];
				//cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"42-photos"]];
				cell.textLabel.text = [NSString stringWithFormat:@" %@ = %@ / 5",[self.keys objectAtIndex:indexPath.row],[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]]];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;	// cell appears unselected
				cell.accessoryType = UITableViewCellAccessoryNone;
				break;
			case 3:		// Dorms
				cell.imageView.image = [UIImage imageNamed:@"53-house.png"];
				//cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"42-photos"]];
				cell.textLabel.text = [NSString stringWithFormat:@"  %@ = %@ / 5",[self.keys objectAtIndex:indexPath.row],[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]]];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;	// cell appears unselected
				cell.accessoryType = UITableViewCellAccessoryNone;
				break;
			case 4:		// Final Thoughts
				cell.imageView.image = [UIImage imageNamed:@"84-lightbulb.png"];
				//cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"42-photos"]];
				cell.selectionStyle = UITableViewCellSelectionStyleBlue;	// cell appears selected
				cell.textLabel.text = @"    Tap to see final thoughts";
				cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
				break;
			case 5:		// Food
				cell.imageView.image = [UIImage imageNamed:@"125-food.png"];
				//cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"42-photos"]];
				cell.textLabel.text = [NSString stringWithFormat:@" %@ = %@ / 5",[self.keys objectAtIndex:indexPath.row],[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]]];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;	// cell appears unselected
				cell.accessoryType = UITableViewCellAccessoryNone;
				break;
			case 6:		// Social
				cell.imageView.image = [UIImage imageNamed:@"112-group.png"];
				//cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"42-photos"]];
				cell.textLabel.text = [NSString stringWithFormat:@"%@ = %@ / 5",[self.keys objectAtIndex:indexPath.row],[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]]];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;	// cell appears unselected
				cell.accessoryType = UITableViewCellAccessoryNone;
				break;
			case 7:		// Tour Guide
				cell.imageView.image = [UIImage imageNamed:@"102-walk.png"];
				//cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"42-photos"]];
				cell.textLabel.text =[NSString stringWithFormat:@"    %@ = %@ / 4",[self.keys objectAtIndex:indexPath.row],[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]]+1];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;	// cell appears unselected
				cell.accessoryType = UITableViewCellAccessoryNone;
				break;
			case 8:		// Town
				cell.imageView.image = [UIImage imageNamed:@"178-city.png"];
				//cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"42-photos"]];
				cell.textLabel.text =[NSString stringWithFormat:@"  %@ = %@ / 3",[self.keys objectAtIndex:indexPath.row],[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]]+1];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;	// cell appears unselected
				cell.accessoryType = UITableViewCellAccessoryNone;
				break;
			case 9:		// Vibe
				cell.imageView.image = [UIImage imageNamed:@"29-heart.png"];
				//cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"42-photos"]];
				cell.textLabel.text =[NSString stringWithFormat:@"  %@ = %@ / 4",[self.keys objectAtIndex:indexPath.row],[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]]+1];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;	// cell appears unselected
				cell.accessoryType = UITableViewCellAccessoryNone;
				break;
			default:
				break;
		}
		// sets tableview cell colors based on ratings
		if (indexPath.row == 4) {								// Final Thoughts
			cell.backgroundColor = [UIColor whiteColor];
		}
		else if (indexPath.row == 7 || indexPath.row == 9) {	// Tour Guide and Vibe
			if ([[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]] intValue]+1 == 1) {
				cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.2 blue:0.3 alpha:0.7];			// red cell color
			}
			else if ([[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]] intValue]+1 == 2) {
				cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:0.90];		// yellow cell color
			}
			else {
				cell.backgroundColor = [UIColor colorWithRed:0.5 green:1.0 blue:0.5 alpha:0.7];			// green cell color
			}
		}
		else if (indexPath.row == 8) {							// Town
			if ([[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]] intValue]+1 == 1) {		
				cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.2 blue:0.3 alpha:0.7];			// red cell color
			}
			else if ([[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]] intValue]+1 == 2) {	
				cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:0.90];		// yellow cell color
			}
			else {
				cell.backgroundColor = [UIColor colorWithRed:0.5 green:1.0 blue:0.5 alpha:0.7];			// green cell color
			}
		}
		else {													// Academics, Athletics, Campus, Dorms, Food, Social
			if ([[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]] intValue] == 0) {
				cell.backgroundColor = [UIColor colorWithRed:.50 green:.50 blue:.50 alpha:1.00];		// grey cell color
				//cell.backgroundColor = [UIColor whiteColor];											// white cell color
			}
			else if ([[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]] intValue] >= 1 && 
					 [[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]]intValue] < 3) {
				cell.backgroundColor = [UIColor colorWithRed:1.0 green:0.2 blue:0.3 alpha:0.7];			// red cell color
			}
			else if ([[col.dic objectForKey:[self.keys objectAtIndex:indexPath.row]] intValue] == 3) {
				cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:0.90];		// yellow cell color
			}
			else {
				cell.backgroundColor = [UIColor colorWithRed:0.5 green:1.0 blue:0.5 alpha:0.7];			// green cell color
			}
		}
	}
	return cell;
}

-(int) calculateTotal {
	int rawScore = 0;
	for (int i=0;i<self.keys.count;i++) {
		rawScore+=[[col.dic objectForKey:[keys objectAtIndex:i]]intValue];
	}
	return rawScore;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 1 && indexPath.row == 4 ) {
		tvc = [[TextDisplayViewController alloc] initWithCollege:col];
		[self.navigationController pushViewController:tvc animated:YES];
		[tvc release];
	}
		// if user selects "Overall Rating" cell, pop alert view explaining aglorithm that calculates rating
	if (indexPath.section == 0 && indexPath.row == 3) {
		UIAlertView *overallRating = [[UIAlertView alloc] initWithTitle:@"Overall Rating Calculation" 
																message:@"Our algorithm takes into consideration all rated categories (unrated categories appear in grey), user preferences, the weather, and the tour guide's likeness. The algorithm gives heavier weight to preferred categoires (these can be changed in Settings), applies appropriate weather multipliers to the Campus, Social, and Vibe categories, and applies a tour guide multiplier to all categories." 
															   delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[overallRating show];
		[overallRating release];		
	}
}

-(NSString *) emailString {
	int rawScore = [self calculateTotal];
	float rating = [col.rating floatValue];
	NSDateFormatter *format = [[NSDateFormatter alloc] init];
	[format setDateFormat:@"MMM dd, yyyy HH:mm"];
	NSString *datString = [format stringFromDate:col.dat];
	NSString *tmp = [NSString stringWithFormat:@"Overview: \n\n College: %@\nRating = %.2f\n Raw Score = %d / 41\n Date: %@\n\nRatings:\n\n",col.name,rating,rawScore,datString];
	for (int j = 0; j<self.keys.count;j++) {
		// for tour guide and vibe
		if ([self.keys objectAtIndex:j] == @"Tour Guide" || [self.keys objectAtIndex:j] == @"Vibe") {
			tmp =[tmp stringByAppendingString:[NSString stringWithFormat:@"%@ = %@ / 4\n",[self.keys objectAtIndex:j],[col.dic objectForKey:[self.keys objectAtIndex:j]]+1]];
		}
		// for town
		else if ([self.keys objectAtIndex:j] == @"Town") {
			tmp =[tmp stringByAppendingString:[NSString stringWithFormat:@"%@ = %@ / 3\n",[self.keys objectAtIndex:j],[col.dic objectForKey:[self.keys objectAtIndex:j]]+1]];
		}
		// for final thoughts
		else if ([self.keys objectAtIndex:j] == @"Final Thoughts") {
			tmp =[tmp stringByAppendingString:[NSString stringWithFormat:@"%@ = '%@'\n",[self.keys objectAtIndex:j],[col.dic objectForKey:[self.keys objectAtIndex:j]]]];
		}
		// for all other keys in college model
		else {
			tmp =[tmp stringByAppendingString:[NSString stringWithFormat:@"%@ = %@ / 5\n",[self.keys objectAtIndex:j],[col.dic objectForKey:[self.keys objectAtIndex:j]]]];
		}
	}
	//need link to apple store  adrress
	[format release];
	return tmp;
}

//sets up the email view
-(void)showEmailView {
	MFMailComposeViewController *mailPicker  = [[MFMailComposeViewController alloc]init];
	mailPicker.mailComposeDelegate = self;
	[mailPicker setSubject:[NSString stringWithFormat:@"%@ Tour Information",col.name]];
	NSString *emailBody= [self emailString];
	[mailPicker setMessageBody:emailBody isHTML:NO];
	mailPicker.navigationBar.barStyle = UIBarStyleBlack;
	[self presentModalViewController:mailPicker animated:YES];
	[mailPicker release];
}

//sends email
-(void) emailV {
	if ([MFMailComposeViewController canSendMail]) {
		[self showEmailView];
	}
}

//composes mail or checks for error
- (void)mailComposeController:(MFMailComposeViewController*)mailPicker didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error { 
	switch (result) {
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
			
		case MFMailComposeResultFailed:
			break;
		default:
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending Failed"
														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
			[alert show];
			[alert release];
		}
		break;
	}
	[self dismissModalViewControllerAnimated:YES];
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
	// if user selects "Final Thoughts" cell, push new view
	if (indexPath.section == 1 && indexPath.row == 4 ) {
	   tvc = [[TextDisplayViewController alloc] initWithCollege:col];
	   [self.navigationController pushViewController:tvc animated:YES];
	   [tvc release];
	}
	// if user selects "Overall Rating" cell, pop alert view explaining aglorithm that calculates rating
	if (indexPath.section == 0 && indexPath.row == 3) {
		UIAlertView *overallRating = [[UIAlertView alloc] initWithTitle:@"Overall Rating Calculation" 
																message:@"Our algorithm takes into consideration all rated categories (unrated categories appear in grey), user preferences, the weather, and the tour guide's likeness. The algorithm gives heavier weight to preferred categoires (these can be changed in Settings), applies appropriate weather multipliers to the Campus, Social, and Vibe categories, and applies a tour guide multiplier to all categories." 
															   delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
		[overallRating show];
		[overallRating release];		
	}
	/*
	// if user selects the college cell, push web view controller and open the college's website
	if (indexPath.section == 0 && indexPath.row == 0) {
		 wvc = [[CollegeWebViewController alloc] initWithNibName:@"CollegeWebViewController" bundle:nil];
		[self.navigationController pushViewController:wvc animated:YES];
		[wvc release];
	}
	*/	 
	else {
		// Here we're going to push to photo album view containing photos tagged to particular cell category
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

