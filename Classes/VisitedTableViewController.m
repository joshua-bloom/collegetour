    //
//  VistitedTableViewController.m
//  Tour
//
//  Created by Samuel Clark on 3/30/11.
//  Copyright 2011 College Visions. All rights reserved.
//

#import "VisitedTableViewController.h"
#import "College.h"
#import "CollegeDetailViewController.h"

@implementation VisitedTableViewController
@synthesize cxt, sorter;

// load context and handle sorting logic
-(id)initInManagedObjectContext:(NSManagedObjectContext *)context {
	self.tableView.delegate = self;
	sortChoice = 0;
	choiceCount = 0;
	
	sorter = [[UIBarButtonItem alloc] initWithTitle:@"Sort" style:UIBarButtonItemStyleBordered target:self action:@selector(changeSort:)];
	self.navigationItem.rightBarButtonItem = sorter;
	[sorter release];
	self.cxt = context;
	
	if ((self = [super initWithStyle:UITableViewStylePlain])) {
		NSFetchRequest *request = [[NSFetchRequest alloc] init];
		[request setEntity:[NSEntityDescription entityForName:@"College"
									   inManagedObjectContext:context]];
		[request setFetchBatchSize:20];
		
			
		
			//can I make this dependet on a button or selector
			//when change segmented controller need to replace old controller and push a new one.
			
		if (sortChoice == 0) {
			NSLog(@"Here setting name to sort descript");
			NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" 
																			 ascending:YES 
																			  selector:@selector(compare:)];
			[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
		}
		else {
			NSLog(@"Here setting ratings to sort descript");
			NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"rating" 
																			 ascending:YES 
																			  selector:@selector(compare:)];
			[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
		}
		NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
										   initWithFetchRequest:request
										   managedObjectContext:context
										   sectionNameKeyPath:@"sectionTitle"
										   cacheName:nil];
		[request release];
		self.fetchedResultsController = frc;
		[frc release];
		self.titleKey = @"titleKey";
		self.searchKey = @"name";
	}
	return self;
}

- (void)managedObjectSelected:(NSManagedObject *)managedObject {
	// which object has been selected?
	col = (College*) managedObject;
	CollegeDetailViewController* cdvc = [[CollegeDetailViewController alloc] initWithCollege:col];
	cdvc.title = col.name;
	[self.navigationController pushViewController:cdvc animated:YES];
	[cdvc release];
	//self.fetchedResultsController = nil;
	//[self.fetchedResultsController performFetch:&e];
}

-(void) changeSort:(int) newSortChoice  {	
	// manipulate sort options via NSFetchRequest
	sortChoice = newSortChoice;
	choiceCount++;
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	[request setEntity:[NSEntityDescription entityForName:@"College"
									inManagedObjectContext:self.cxt]];
	[request setFetchBatchSize:20];
	
	if (choiceCount%3 == 0) {
		NSLog(@"Here setting name to sort descript");
		NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" 
																			ascending:YES 
																			selector:@selector(caseInsensitiveCompare:)];
		[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
		sorter.title = @"Name";
	}
	else if (choiceCount%3 ==1 ) {
		sorter.title = @"Rating";
		NSLog(@"Here setting ratings to sort descript");
		NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"rating" 
																			ascending:NO 
																			selector:@selector(compare:)];
		[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	}
	else if (choiceCount %3 == 2) {
		sorter.title = @"Date";
		NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"dat" 
																			ascending:NO 
																			selector:@selector(compare:)];
		[request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	}
	NSFetchedResultsController *frc = [[NSFetchedResultsController alloc]
										initWithFetchRequest:request
										managedObjectContext:self.cxt
										sectionNameKeyPath:@"sectionTitle"
										cacheName:nil];
	[request release];
	self.fetchedResultsController = frc;
	[frc release];
	self.titleKey = @"titleKey";
	self.searchKey = @"name";
}

-(UITableViewCellEditingStyle) tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath{
	return UITableViewCellEditingStyleDelete;
}

-(void) showOptions {
		//
}


@end
