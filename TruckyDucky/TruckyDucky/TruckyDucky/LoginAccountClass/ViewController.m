//
//  ViewController.m
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ViewController.h"
#import "LoginVC.h"
#import "HistorytabVC.h"
#import "ProfileVC.h"
#import "SettingtabVC.h"
#import "MainTabVC.h"

#import "BookedtabVC.h"
#import "ListingArchiveVC.h"


#import "RequestForCarVC.h"
#import "DriverLocationVC.h"
#import "LeaveFeedbackVC.h"

#import "ReportProblem.h"




@interface ViewController ()
{
     CLLocationManager      *CLlocationManger;
     NSString               *strCurrentLat;
     NSString               *strCurrentLong;
     NSString               *checkAlreadyLogin;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//     MainTabVC*Login = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabVC"];
//       [self.navigationController pushViewController:Login animated:YES];


    
//         HistorytabVC*Login = [self.storyboard instantiateViewControllerWithIdentifier:@"HistorytabVC"];
//           [self.navigationController pushViewController:Login animated:YES];
//    
      
    
    
        self.btnLoginAccount.layer.cornerRadius = 5;
    
        CLlocationManger = [[CLLocationManager alloc] init];
        [CLlocationManger requestAlwaysAuthorization];
        [CLlocationManger requestWhenInUseAuthorization];
        CLlocationManger.delegate=self;
        CLlocationManger.distanceFilter = kCLDistanceFilterNone;
        CLlocationManger.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [CLlocationManger startUpdatingLocation];
    
    
    checkAlreadyLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"Already Login"];
       
    if ([checkAlreadyLogin isEqualToString: @"GotoHomeUI"])
    {
        // Already Login. Move to Home UI
        MainTabVC *Home = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabVC"];
        [self.navigationController pushViewController:Home animated:YES];
        
    }
    
    else
    {
        
    }
    

}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
     strCurrentLat=[NSString stringWithFormat:@"%f",manager.location.coordinate.latitude];
     strCurrentLong=[NSString stringWithFormat:@"%f",manager.location.coordinate.longitude];
    
      NSLog(@"Lattitude of current location user %@ %@",strCurrentLat,strCurrentLong);
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:strCurrentLat forKey:@"Sender_Lattitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:strCurrentLong forKey:@"Sender_Longitude"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    [CLlocationManger stopUpdatingLocation];
    
}




#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        NSLog(@"Please authorize location services");
        return;
    }
    
    NSLog(@"CLLocationManager error: %@", error.localizedFailureReason);
    return;
    
}





- (IBAction)actionLoginWithAccount:(id)sender {
    LoginVC *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    [self.navigationController pushViewController:Login animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
