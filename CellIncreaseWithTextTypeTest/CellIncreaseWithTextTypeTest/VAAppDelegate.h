//
//  VAAppDelegate.h
//  CellIncreaseWithTextTypeTest
//
//  Created by Developer on 19/09/14.
//  Copyright (c) 2014 rptwsthi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
