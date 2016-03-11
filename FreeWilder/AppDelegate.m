//
//  AppDelegate.m
//  FreeWilder
//
//  Created by Koustov Basu on 01/03/16.
//  Copyright © 2016 Koustov Basu. All rights reserved.
//

#import "AppDelegate.h"
#import "DashboardViewController.h"
#import "FindInterestsViewController.h"
#import "WishlistViewController.h"
#import "FW_JsonClass.h"
#import "Reachability.h"

@interface AppDelegate ()
{
    
    FW_JsonClass *globalObj;
    
    NSString *userName;
    
    NSString *userImageURL;
    
    NSString *facebookId;
    
    NSUserDefaults *userData;
    
    NSString *gender,*dob;
    
    NSString *emailID;
    
}
@end

@implementation AppDelegate

@synthesize currentLangDic,locationData,location_lat,location_long,sw_lat,sw_long,ne_lat,ne_long;


//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
    {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    

    
  Reachability *reachability = [Reachability reachabilityWithHostname:@"www.google.com"];
    
//    reachability.reachableBlock = ^(Reachability *reachability) {
//        NSLog(@"Network is reachable.");
//    };
//    
//    reachability.unreachableBlock = ^(Reachability *reachability) {
//        NSLog(@"Network is unreachable.");
//    };
//    
    // Start Monitoring
    [reachability startNotifier];
    
    
    location_lat=@"";
    location_long=@"";
    sw_lat=@"";
    sw_long=@"";
    ne_lat=@"";
    ne_long=@"";
    
    userData=[NSUserDefaults standardUserDefaults];
    
    [application setStatusBarHidden:YES];
    
    
    globalObj=[[FW_JsonClass alloc]init];
    
    NSDictionary *langDicEng=@{@"LOG_IN":@"Log In",@"Log_in_with_your":@"Log in with your",@"Dnt_hv_acnt":@"Don't have an account ?", @"Frgt_pass":@"Forgot Password",@"sign_up":@"Sign up",@"Do_u_hv_bsns":@"DO YOU HAVE A BUSINESS?",@"Get_Started":@"Get Started",@"Find_ur_intrst":@"FIND YOUR INTEREST",@"Product_Listing":@"Product Listing",@"Details:":@"Details:",@"Reviews":@"Reviews",@"Booking_details":@"Booking Details",@"Check In":@"Check In",@"Check Out":@"Check Out",@"Request To Book":@"Request To Book",@"Direct Book":@"Direct Book",@"Reviews":@"Reviews",@"Available":@"Available",@"From":@"From",@"To":@"To",@"Last available date":@"Last available date",@"Next available date":@"Next available date",@"Always available":@"Always available",@"Direct Book":@"Direct Book",@"is currently not available":@"is currently not available",@"Quantity":@"Quantity",@"Price Details":@"Price Details",@"Service Fee":@"Service Fee",@"Admin Charge":@"Admin Charge",@"Total":@"Total",@"ASK QUESTION":@"ASK QUESTION",@"Subject":@"Subject",@"Message":@"Message",@"Attach file":@"Attach file:",@"Please enter a message":@"Please enter a message",@"Product Search":@"Product Search",@"SEARCH":@"SEARCH",@"Business or Service":@"Business or Service",@"Location":@"Location",@"Start Date":@"Start Date",@"End Date":@"End Date",@"Ok":@"Ok",@"Cancel":@"Cancel",@"Confirm Password":@"Confirm Password",@"Email":@"Email",@"Name":@"Name",@"Password":@"Password",@"Sign up for Free":@"Sign up for Free",@"Date of Birth":@"Date of Birth",@"Select your Gender":@"Select your Gender",@"SIGN UP":@"SIGN UP",@"Male":@"Male",@"Female":@"Female"};
    
    NSDictionary *langDicViet=@{@"LOG_IN":@"Đăng nhập",@"Log_in_with_your":@"Đăng nhập với bạn", @"Dnt_hv_acnt":@"Không có tài khoản?",@"Frgt_pass":@"Quên mật khẩu",@"sign_up":@"Đăng ký",@"Do_u_hv_bsns":@"BẠN CÓ KINH DOANH?", @"Get_Started":@"Bắt đầu", @"Find_ur_intrst":@"TÌM LÃI CỦA BẠN",@"Product_Listing":@"Liệt kê sản phẩm",@"Details:":@"Thông tin chi tiết :",@"Reviews":@"Nhận xét",@"Booking_details":@"Chi tiết đặt",@"Check In":@"Đăng ký vào",@"Check Out":@"Kiểm tra",@"Request To Book":@"Yêu cầu Để Book", @"Direct Book":@"Sách Direct",@"Reviews":@"Nhận xét",@"Available":@"có sẵn", @"From":@"Từ",@"To":@"Đến",@"Last available date":@"Cuối cùng có sẵn ngày",@"Next available date":@"Tiếp theo ngày có sẵn",@"Always available":@"Luôn luôn sẵn sàng",@"Direct Book":@"Sách Direct",@"is currently not available":@"hiện tại không có sẵn",@"Quantity":@"Số lượng",@"Price Details":@"Chi tiết giá",@"Service Fee":@"Phí dịch vụ",@"Admin Charge":@"Admin Charge",@"Total":@"Tổng số",@"ASK QUESTION":@"HỎI CÂU HỎI",@"Subject":@"Bộ môn",@"Message":@"Lời nhắn", @"Attach file":@"Đính kèm tập tin:",@"Please enter a message":@"Vui lòng nhập thông",@"Product Search":@"Tìm kiếm Sản phẩm",@"SEARCH":@"TÌM KIẾM",@"Business or Service":@"Kinh doanh hoặc dịch vụ", @"Location":@"Vị trí",@"Start Date":@"ngày bắt đầu",@"End Date":@"Ngày cuối",@"Ok":@"Được",@"Cancel":@"hủy bỏ",@"Confirm Password":@"Xác nhận mật khẩu",@"Email":@"E-mail",@"Name":@"Tên",@"Password":@"mật khẩu",@"Sign up for Free":@"Đăng kí miễn phí",@"Date of Birth":@"Ngày sinh",@"Select your Gender":@"Chọn giới tính của bạn",@"SIGN UP":@"ĐĂNG KÝ",@"Male":@"Nam",@"Female":@"Nữ"};
    
    
    NSDictionary *langDicPolis=@{  @"LOG_IN" :@"Zaloguj się",@"Log_in_with_your":@"Zaloguj się swoim",@"Dnt_hv_acnt":@"Nie masz konta ?",@"Frgt_pass":@"Zapomniałeś hasła?",@"sign_up":@"Zapisz się",@"Do_u_hv_bsns":@"Czy masz BIZNES?",@"Get_Started":@"Zaczynać",@"Find_ur_intrst":@"ZNAJDŹ zainteresowanie",@"Product_Listing":@"Lista produktów",@"Details:":@"Bliższe dane:",@"Reviews":@"Recenzje",@"Booking_details":@"Rezerwacja Szczegóły",@"Check In":@"Odprawa lotnicza",@"Check Out":@"Sprawdź",@"Request To Book":@"Zapytanie do Księgi",@"Direct Book":@"Bezpośredni Rezerwuj",@"Reviews":@"Recenzje",@"Available":@"Do dyspozycji",@"From":@"Od",@"To":@"Do",@"Last available date":@"Ostatnio dostępny data",@"Next available date":@"Następny dostępny data",@"Always available":@"Zawsze dostępne",@"Direct Book":@"Bezpośredni Rezerwu",@"is currently not available":@"jest obecnie niedostępny",@"Quantity":@"Ilość",@"Price Details":@"Cena Szczegóły",@"Service Fee":@"Opłata za usługę",@"Admin Charge":@"Admin Charge",@"Total":@"Całkowity",@"ASK QUESTION":@"ZADAJ PYTANIE",@"Subject":@"Przedmiot",@"Message":@"Wiadomość",@"Attach file":@"Dołącz plik:",@"Please enter a message":@"Wprowadź treść wiadomości",@"Product Search":@"Szukaj produktów",@"SEARCH":@"WYSZUKAJ",@"Business or Service":@"Biznes i usługi",@"Location":@"Lokalizacja",@"Start Date":@"Data rozpoczęcia",@"End Date":@"Data końcowa",@"Ok":@"Ok",@"Cancel":@"Anuluj",@"Confirm Password":@"Potwierdź hasło",@"Email":@"E-mail",@"Name":@"Imię",@"Password":@"Hasło",@"Sign up for Free":@"Zarejestruj się za darmo",@"Date of Birth":@"Data urodzenia",@"Select your Gender":@"Wybierz płeć",@"SIGN UP":@"ZAPISZ SIĘ",@"Male":@"męski",@"Female":@"Płeć żeńska"};
    
    //    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:langDicEng];
    //    NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:langDicViet];
    //    NSData *data3 = [NSKeyedArchiver archivedDataWithRootObject:langDicPolis];
    
    //    NSArray *langArr=[[NSArray alloc]initWithObjects:data1,data2,data3,nil];
    //    NSArray *langCodeArr=[[NSArray alloc]initWithObjects:@"en",@"vi",@"pl",nil];
    
    NSManagedObjectContext *context=[self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"LanguageTable"];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if(fetchedObjects.count>0)
    {
        
        
        for (NSManagedObject *object in fetchedObjects)
        {
            [context deleteObject:object];
        }
        
        error = nil;
        [context save:&error];
    }
    
    NSDictionary *langDicFinal=@{@"en":langDicEng,@"vi":langDicViet,@"pl":langDicPolis};
    
    //NSArray *langArryFinal=[[NSArray alloc]initWithObjects:eng,viet,polis,nil];
    
    // NSLog(@"Boro array------> \n %@",langDicFinal);
    
    NSManagedObjectContext *contextD=[self managedObjectContext];
    // NSFetchRequest *fetchRequestD = [[NSFetchRequest alloc] initWithEntityName:@"LanguageTable"];
    NSError *errorD;
    // NSArray *fetchedObjectsD = [contextD executeFetchRequest:fetchRequestD error:&errorD];
    
    // NSLog(@"Count...............>>>>>>>>> %lu",(long)fetchedObjectsD.count);
    
    NSManagedObject *newUser=[NSEntityDescription insertNewObjectForEntityForName:@"LanguageTable" inManagedObjectContext:contextD];
    [newUser setValue:[NSKeyedArchiver archivedDataWithRootObject:langDicFinal] forKey:@"langDic"];
    //[newUser setValue:langCodeArr[i] forKey:@"langId"];
    [contextD save:&errorD];
    
    
    
    
    
    // NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
    
    NSString *currentLang=[userData valueForKey:@"language"];
    
    // NSLog(@"Current lang----> %@",currentLang);
    
    if(![currentLang isKindOfClass:[NSString class]])
    {
        
        NSLog(@"Null check---->");
        
        LocalizationSetLanguage(@"en");
        
        currentLang=@"en";
        
        [userData setValue:@"en" forKey:@"language"];
        
    }
    else
    {
        // For polaski(poland)
        // LocalizationSetLanguage(@"pl");
        
        
        LocalizationSetLanguage(currentLang);
        
    }
    
    NSLog(@"Current lang----> %@",currentLang);
    
    
    NSManagedObjectContext *theContext=[self managedObjectContext];
    NSFetchRequest *fetchRequest1 = [[NSFetchRequest alloc] initWithEntityName:@"LanguageTable"];
    // fetchRequest1.predicate=[NSPredicate predicateWithFormat:@"langId== %@",currentLang];
    
    [fetchRequest1 setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSArray *fetchedObjects1 =[[NSArray alloc]initWithObjects:[[theContext executeFetchRequest:fetchRequest error:nil] objectAtIndex:0], nil];// [theContext executeFetchRequest:fetchRequest error:nil];
    
    //
    //    for(NSManagedObject *obj in fetchedObjects1)
    //    {
    
    //NSLog(@"Lang table...1 %@",[NSKeyedUnarchiver unarchiveObjectWithData:[fetchedObjects1[0] valueForKey:@"langDic"]]);
    
    NSDictionary *myLangDic=[NSKeyedUnarchiver unarchiveObjectWithData:[fetchedObjects1[0] valueForKey:@"langDic"]];
    
    currentLangDic=[myLangDic valueForKey:currentLang];
    
    //    }
    
    
    
    
    
    // [userData setObject:session forKey:@"session"];
    // [userData setObject:[NSNumber numberWithInteger:status] forKey:@"status"];
    
    
    if([userData valueForKey:@"status"] || [[userData valueForKey:@"logInCheck"] isEqualToString:@"Logged in"])
    {
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        //        FindInterestsViewController * vc=[storyboard instantiateViewControllerWithIdentifier:@"Interest_page"];
        DashboardViewController *dashVC = [storyboard instantiateViewControllerWithIdentifier:@"Dashboard"];
        
        
        [(UINavigationController*)self.window.rootViewController pushViewController:dashVC animated:NO];
        
    }
    
    
    
    
    // Override point for customization after application launch.
    return YES;
}



-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}


-(void)openActiveSessionWithPermissions:(NSArray *)permissions allowLoginUI:(BOOL)allowLoginUI
{
    [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:allowLoginUI completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        
        [FBRequestConnection startWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, picture.type(normal), email, birthday,gender"} HTTPMethod:@"GET" completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            
            
            if (!error) {
                
                // Set the use full name.
                
                NSLog(@"user data from facebook ..... %@ \n",result);
                
                // NSLog(@"result email---->%@",[result valueForKey:@"email"]);
                
                // NSLog(@"facebook access token----> %@",[FBSession activeSession].accessTokenData.accessToken);
                
                userName =[NSString stringWithFormat:@"%@ %@",[result valueForKey:@"first_name"],[result valueForKey:@"last_name"]];
                
                userImageURL = [NSString stringWithFormat:@"%@",[[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"]];
                
                facebookId = [NSString stringWithFormat:@"%@",[result valueForKey:@"id"] ];
                
                //    userData=[NSUserDefaults standardUserDefaults];
                
                gender=[NSString stringWithFormat:@"%@",[result valueForKey:@"gender"] ];
                
                emailID=[NSString stringWithFormat:@"%@",[result valueForKey:@"email"] ];
                
                [userData setValue:facebookId forKey:@"status"];
                [userData setValue:userName forKey:@"UserName"];
                [userData setValue:userImageURL forKey:@"UserImage"];
                [userData setValue:[result valueForKey:@"email"] forKey:@"email"];
                
                [userData synchronize];
                
                dob=@"";
                
                NSString *url = [NSString stringWithFormat:@"%@app_fb_reg?email=%@&user_name=%@&fb_id=%@&dob=%@&gender=%@",App_Domain_Url,emailID,userName,facebookId,dob,gender];
                
                url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                
                [globalObj GlobalDict:url Globalstr:@"array" Withblock:^(id result, NSError *error) {
                    
                    
                    NSLog(@"Hello facebook user-----> %@",result);
                    
                    if([[result valueForKey:@"response"] isEqualToString:@"Success"])
                    {
                        
                        [userData setValue:[result valueForKey:@"user_id_site"] forKey:@"UserId"];
                        
                        UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
                        
                        DashboardViewController *dashVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Dashboard"];
                        [navigationController pushViewController:dashVC animated:YES];
                        
                        
                        
                    }
                    
                    
                }];
                
                
            }
            
        }];
        
        
        
        
        
        //                                      [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *FBuser, NSError *error) {
        //                                          if (error) {
        //                                              // Handle error
        //                                          }
        //
        //                                          else {
        //                                              NSString *userName = [FBuser name];
        //                                              NSString *userImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [FBuser objectID]];
        //
        //                                              NSString *facebookId = FBuser.objectID;
        //
        //                                              NSString *email = [FBuser objectForKey:@"email"];
        //
        //
        //
        //                                              NSLog(@"Id---------> %@",facebookId);
        //                                              NSLog(@"email---------> %@",email);
        //
        //                                              NSUserDefaults *userData=[NSUserDefaults standardUserDefaults];
        //                                              [userData setValue:facebookId forKey:@"status"];
        //                                              [userData setValue:userName forKey:@"UserName"];
        //                                              [userData setValue:userImageURL forKey:@"UserImage"];
        //
        //                                              [userData synchronize];
        //
        //
        //                                          }
        //                                      }];
        
        
        
        
        if(!error)
        {
            
            //
            
        }
        
        
    }];
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    

    
    
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateInactive)
    {
              UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
              WishlistViewController    *obj=[storyboard instantiateViewControllerWithIdentifier:@"WishlistViewControllersid"];
        
        [(UINavigationController*)self.window.rootViewController pushViewController:obj animated:NO];

    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if(![[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
    
       // NSLog()
    
    }
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    
    
    
    
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "esolz.FreeWilder" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FreeWilder" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FreeWilder.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            // abort();
        }
        
    }
}

@end
