//
//  CoreDataTableViewController.m
//
//  Created for Stanford CS193p Spring 2010
//

#import "CoreDataTableViewController.h"

@implementation CoreDataTableViewController

@synthesize fetchedResultsController;
@synthesize titleKey, subtitleKey, searchKey, deleteCheck;

- (void)createSearchBar
{
	if (self.searchKey.length) {
		if (self.tableView && !self.tableView.tableHeaderView) {
			UISearchBar *searchBar = [[[UISearchBar alloc] init] autorelease];
			[[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
			self.searchDisplayController.searchResultsDelegate = self;
			self.searchDisplayController.searchResultsDataSource = self;
			self.searchDisplayController.delegate = self;
			searchBar.frame = CGRectMake(0, 0, 0, 38);
			self.tableView.tableHeaderView = searchBar;
		}
	} else {
		self.tableView.tableHeaderView = nil;
	}
}

- (void)setSearchKey:(NSString *)aKey
{
	[searchKey release];
	searchKey = [aKey copy];
	[self createSearchBar];
}

- (NSString *)titleKey
{
	if (!titleKey) {
		NSArray *sortDescriptors = [self.fetchedResultsController.fetchRequest sortDescriptors];
		if (sortDescriptors.count) {
			return [[sortDescriptors objectAtIndex:0] key];
		} else {
			return nil;
		}
	} else {
		return titleKey;
	}
}

- (void)performFetchForTableView:(UITableView *)tableView
{
	NSError *error = nil;
	[self.fetchedResultsController performFetch:&error];
	if (error) {
		NSLog(@"[CoreDataTableViewController performFetchForTableView:] %@ (%@)", [error localizedDescription], [error localizedFailureReason]);
	}
	[tableView reloadData];
}

- (NSFetchedResultsController *)fetchedResultsControllerForTableView:(UITableView *)tableView
{
	if (tableView == self.tableView) {
		if (self.fetchedResultsController.fetchRequest.predicate != normalPredicate) {
			[NSFetchedResultsController deleteCacheWithName:self.fetchedResultsController.cacheName];
			self.fetchedResultsController.fetchRequest.predicate = normalPredicate;
			[self performFetchForTableView:tableView];
		}
		[currentSearchText release];
		currentSearchText = nil;
	} else if ((tableView == self.searchDisplayController.searchResultsTableView) && self.searchKey && ![currentSearchText isEqual:self.searchDisplayController.searchBar.text]) {
		[currentSearchText release];
		currentSearchText = [self.searchDisplayController.searchBar.text copy];
		NSString *searchPredicateFormat = [NSString stringWithFormat:@"%@ contains[c] %@", self.searchKey, @"%@"];
		NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:searchPredicateFormat, self.searchDisplayController.searchBar.text];
		[NSFetchedResultsController deleteCacheWithName:self.fetchedResultsController.cacheName];
		self.fetchedResultsController.fetchRequest.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:searchPredicate, normalPredicate , nil]];
		[self performFetchForTableView:tableView];
	}
	return self.fetchedResultsController;
}


// UISearchDisplayDelegate
- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
	// reset the fetch controller for the main (non-searching) table view
	[self fetchedResultsControllerForTableView:self.tableView];
}

- (void)setFetchedResultsController:(NSFetchedResultsController *)controller
{
	fetchedResultsController.delegate = nil;
	[fetchedResultsController release];
	fetchedResultsController = [controller retain];
	controller.delegate = self;
	normalPredicate = [self.fetchedResultsController.fetchRequest.predicate retain];
	if (!self.title) self.title = controller.fetchRequest.entity.name;
	if (self.view.window) [self performFetchForTableView:self.tableView];
}

-(NSString*)deleteIsTrue {
	return @"True";
	
}

-(NSString *)deleteIsFalse{
	return @"False";
}
- (UITableViewCellAccessoryType)accessoryTypeForManagedObject:(NSManagedObject *)managedObject
{
	return UITableViewCellAccessoryDisclosureIndicator;
}

- (UIImage *)thumbnailImageForManagedObject:(NSManagedObject *)managedObject
{
	return nil;
}

- (void)configureCell:(UITableViewCell *)cell forManagedObject:(NSManagedObject *)managedObject
{
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForManagedObject:(NSManagedObject *)managedObject
{
    static NSString *ReuseIdentifier = @"CoreDataTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (cell == nil) {
		UITableViewCellStyle cellStyle = self.subtitleKey ? UITableViewCellStyleSubtitle : UITableViewCellStyleDefault;
        cell = [[[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:ReuseIdentifier] autorelease];
    }
	
	if (self.titleKey) cell.textLabel.text = [managedObject valueForKey:self.titleKey];
	if (self.subtitleKey) cell.detailTextLabel.text = [managedObject valueForKey:self.subtitleKey];
	cell.accessoryType = [self accessoryTypeForManagedObject:managedObject];
	UIImage *thumbnail = [self thumbnailImageForManagedObject:managedObject];
	if (thumbnail) cell.imageView.image = thumbnail;
	
	return cell;
}

- (void)managedObjectSelected:(NSManagedObject *)managedObject
{
    // Navigation logic may go here. Create and push another view controller.
    // AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
    // [self.navigationController pushViewController:anotherViewController];
    // [anotherViewController release];
}



- (void)deleteManagedObject:(NSManagedObject *)managedObject
{
		//UIAlertView *endCheck =[[UIAlertView alloc]initWithTitle:@"Delete?" message:@"Are you sure you want to delete this tour?" delegate:self cancelButtonTitle:@"yes" otherButtonTitles:@"no",nil];
		//[endCheck show];
	
		//	NSLog(@"Delete check = %@",deleteCheck);
	
	
		//if ([deleteCheck isEqualToString:@"True"]) {
		[self.fetchedResultsController.managedObjectContext deleteObject:managedObject];
		[self.fetchedResultsController.managedObjectContext save:NULL];
		//	}	
		

 
		//NSLog(@"Manged objecti n delete =%@",managedObject);
	
		
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	NSLog(@"Here");
	if (buttonIndex == 0) {
		deleteCheck = [self deleteIsTrue];
		
	}
	else {
		deleteCheck = [self deleteIsFalse];
	}
}


- (BOOL)canDeleteManagedObject:(NSManagedObject *)managedObject
{

	
	return YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	NSManagedObject *managedObject = [[self fetchedResultsControllerForTableView:tableView] objectAtIndexPath:indexPath];
		//NSLog(@"Deleting %@",managedObject);

	return [self canDeleteManagedObject:managedObject];


}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

		

	NSManagedObject *managedObject = [[self fetchedResultsControllerForTableView:tableView] objectAtIndexPath:indexPath];
	NSLog(@"Deleting %@",managedObject);
		//	UIAlertView *endCheck =[[UIAlertView alloc]initWithTitle:@"Delete?" message:@"Are you sure you want to delete this tour?" delegate:self cancelButtonTitle:@"yes" otherButtonTitles:@"no",nil];
		//[endCheck show];
	
	[self deleteManagedObject:managedObject];


		//[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	 
		//[endCheck release];
	
		
	
	
}

#pragma mark UIViewController methods

- (void)viewDidLoad
{	
	[self createSearchBar];
	
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self performFetchForTableView:self.tableView];
		//[self.navigationController setToolbarHidden:NO animated:YES];
}

#pragma mark UITableViewDataSource methods

//Sample code taken from NSFetchedResultsController Class Reference
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self fetchedResultsControllerForTableView:tableView] sections] count];
}

//Sample code taken from NSFetchedResultsController Class Reference
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	return nil; //[[self fetchedResultsControllerForTableView:tableView] sectionIndexTitles];
}

#pragma mark UITableViewDelegate methods

//Sample code taken from NSFetchedResultsController Class Reference
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSLog(@"count %d",[[[[self fetchedResultsControllerForTableView:tableView] sections] objectAtIndex:section] numberOfObjects]);
    return [[[[self fetchedResultsControllerForTableView:tableView] sections] objectAtIndex:section] numberOfObjects];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
	return [self tableView:tableView cellForManagedObject:[[self fetchedResultsControllerForTableView:tableView] objectAtIndexPath:indexPath]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self managedObjectSelected:[[self fetchedResultsControllerForTableView:tableView] objectAtIndexPath:indexPath]];
}

//Sample code taken from NSFetchedResultsController Class Reference
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [[[[self fetchedResultsControllerForTableView:tableView] sections] objectAtIndex:section] name];
}

//Sample code taken from NSFetchedResultsController Class Reference
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	return [[self fetchedResultsControllerForTableView:tableView] sectionForSectionIndexTitle:title atIndex:index];
}

#pragma mark NSFetchedResultsControllerDelegate methods

//Sample code taken from NSFetchedResultsControllerDelegate Protocol Reference "Typical Use"
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

//Sample code taken from NSFetchedResultsControllerDelegate Protocol Reference "Typical Use"
- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex
	 forChangeType:(NSFetchedResultsChangeType)type
{	
    switch(type)
	{
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


//Sample code taken from NSFetchedResultsControllerDelegate Protocol Reference "Typical Use"
- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath
{	
    UITableView *tableView = self.tableView;
	
    switch(type)
	{
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeUpdate:
			[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

//Sample code taken from NSFetchedResultsControllerDelegate Protocol Reference "Typical Use"
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

#pragma mark dealloc

- (void)dealloc
{
	fetchedResultsController.delegate = nil;
	[fetchedResultsController release];
	[searchKey release];
	[titleKey release];
	[currentSearchText release];
	[normalPredicate release];
    [super dealloc];
}

@end

