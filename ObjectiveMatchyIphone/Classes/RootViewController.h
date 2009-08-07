//
//  RootViewController.h
//  ObjectiveMatchyIphone
//
//  Created by Matthias Hennemeyer on 03.08.09.
//  Copyright ChocolateCode 2009. All rights reserved.
//

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
	NSFetchedResultsController *fetchedResultsController;
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
