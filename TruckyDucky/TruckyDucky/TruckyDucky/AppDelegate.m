//
//  AppDelegate.m
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <UserNotifications/UserNotifications.h>

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate () <UNUserNotificationCenterDelegate,UIApplicationDelegate>

@end
// 7f558dcb4402852aa90e50d443bc1da69e1573ff
@implementation AppDelegate
id services_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    
    //for notification count setting
      //  NSLog(@"msg applicationWillEnterForeground");
    #if defined(__IPHONE_10_0) && IPHONE_OS_VERSION_MAX_ALLOWED >= IPHONE_10_0
    [[UNUserNotificationCenter currentNotificationCenter] getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *  >*  _Nonnull notifications) {
           // NSLog(@"msg getDeliveredNotificationsWithCompletionHandler count %lu", [notifications count]);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                 application.applicationIconBadgeNumber = [notifications count];
            });
           
    //        for (UNNotification* notification in notifications) {
    //            // do something with object
    //            NSLog(@"msg noti %@", notification.request);
    //        }
            
        }];
        #endif
        //for notification count setting
    
    
    
    
    
    
       [GMSPlacesClient provideAPIKey:@"AIzaSyCh8iJgNF3h-edODUQBvPBPq2TaNYyIWsQ"];

       [GMSServices provideAPIKey:@"AIzaSyCh8iJgNF3h-edODUQBvPBPq2TaNYyIWsQ"];
        
    
    //********************** Keyboard Manager ******************************
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:YES];
    
    
    
    
    
    
    
    
   //******************for notification alert allow ***************************//
    
   if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
       if (@available(iOS 10.0, *)) {
           UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
           center.delegate = self;
           [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
               if(!error){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                   [[UIApplication sharedApplication] registerForRemoteNotifications];
                        
                        });
               }
           }];
       } else {
           // Fallback on earlier versions
       }if (@available(iOS 10.0, *)) {
//           UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//           NSLog(@"%@",center);
       } else {
           // Fallback on earlier versions
       }
   }
    


    return YES;
}




- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"deviceToken: %@", deviceToken);
    
    NSUInteger length = deviceToken.length;
       if (length == 0) {
           
       }
       const unsigned char *buffer = deviceToken.bytes;
       NSMutableString *hexString  = [NSMutableString stringWithCapacity:(length * 2)];
       for (int i = 0; i < length; ++i) {
           [hexString appendFormat:@"%02x", buffer[i]];
       }
    NSLog(@"devicetoken %@",hexString);
    
    [[NSUserDefaults standardUserDefaults]setObject:hexString forKey:@"device_token"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
  //NSLog(@"error==%@",error);
    [[NSUserDefaults standardUserDefaults]setObject:@"2915992e704a0d3ab63df0e498f45e3e845ad76f8318b81a3fb3c875299d4055" forKey:@"device_token"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

///Called when a notification is delivered to a foreground app.
-(void)userNotificationCenter:(UNUserNotificationCenter* )center willPresentNotification:(UNNotification* )notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler API_AVAILABLE(ios(10.0))
{
    NSLog(@"User Info : %@",notification.request.content.userInfo);
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    
}

//Called to let your app know which action was selected by the user for a given notification.
-(void)userNotificationCenter:(UNUserNotificationCenter* )center didReceiveNotificationResponse:(UNNotificationResponse* )response withCompletionHandler:(void(^)(void))completionHandler API_AVAILABLE(ios(10.0))
{
   //  NSLog(@"User Info : %@",response.notification.request.content.userInfo);
      NSLog(@"User Info : %@",response.notification.request.content.userInfo);
    
//    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"countZero"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if( [UIApplication sharedApplication].applicationState == UIApplicationStateInactive)
    {
        NSLog( @"INACTIVE" );
        
        [[NSUserDefaults standardUserDefaults] setObject:response.notification.request.content.userInfo forKey:@"NotificationComing"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    else if( [UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        NSLog( @"BACKGROUND" );
        [[NSUserDefaults standardUserDefaults] setObject:response.notification.request.content.userInfo forKey:@"NotificationComing"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
//        // All instances of TestClass will be notified
//        [[NSNotificationCenter defaultCenter]
//         postNotificationName:@"VolumeNotificationForground"
//         object:self];

    }
    else if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        NSLog( @"FOREGROUND" );
        [[NSUserDefaults standardUserDefaults] setObject:response.notification.request.content.userInfo forKey:@"NotificationComing"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
      //   NSLog(@"notiiii--%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationComing"]);
        
       
        // All instances of TestClass will be notified
        [[NSNotificationCenter defaultCenter]
         postNotificationName:[[NSUserDefaults standardUserDefaults] objectForKey:@"NotificationScreenName"]
         object:self];

    }
    completionHandler();
}

//for notification count setting
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"msg applicationWillEnterForeground");
#if defined(__IPHONE_10_0) && IPHONE_OS_VERSION_MAX_ALLOWED >= IPHONE_10_0
    [[UNUserNotificationCenter currentNotificationCenter] getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *  >*  _Nonnull notifications) {
      //  NSLog(@"msg getDeliveredNotificationsWithCompletionHandler count %lu", [notifications count]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            application.applicationIconBadgeNumber = [notifications count];
        });
        
//        for (UNNotification* notification in notifications) {
//            // do something with object
//            NSLog(@"msg noti %@", notification.request);
//        }
        
    }];
#endif
}
//for notification count setting

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


//- (void)applicationWillEnterForeground:(UIApplication *)application {
//    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
