//
//  AppDelegate.h
//  FreeWilder
//
//  Created by Koustov Basu on 01/03/16.
//  Copyright © 2016 Koustov Basu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <FacebookSDK/FacebookSDK.h>
#import "LocalizeHelper.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic)BOOL basicSaved,calendarSaved,pricingSaved,overviewSaved,imageSaved,locationSaved;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,strong) NSDictionary *currentLangDic;

@property(nonatomic)NSString *locationData,*location_lat,*location_long,*sw_lat,*sw_long,*ne_lat,*ne_long;

-(void)openActiveSessionWithPermissions:(NSArray *)permissions allowLoginUI:(BOOL)allowLoginUI;
-(void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
