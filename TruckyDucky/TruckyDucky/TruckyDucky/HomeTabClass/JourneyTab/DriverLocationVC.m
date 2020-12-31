//
//  DriverLocationVC.m
//  TruckyDucky
//
//  Created by anil kumar on 13/02/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import "DriverLocationVC.h"

#import "webServicesSingulton.h"
#import "SVProgressHUD.h"
@interface DriverLocationVC ()
{
    CLLocationManager      *CLlocationManger;
    GMSMarker              *DriverMarker;
    NSString *strDriverLattitude;
    NSString *strDriverLongitude;
    
    
    NSArray *arrResponse;
    
    
    
    NSArray *arrtemp;
    
    
    
    
    
    NSString *strLat;
    NSString *strLong;
    
    NSString *strPassLat;
    NSString *strPassLong;
    
    
    CLLocationCoordinate2D startLocation;
    CLLocationCoordinate2D endLocation;
    
    
    
}

@end

@implementation DriverLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.lblHeaderTitle.text = self.strPassHeaderTitle;
//    [self setNeedsStatusBarAppearanceUpdate];
//
//    [self CurrentLocationCall];
//
//   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//       NSLog(@"on background queue");
//       dispatch_async(dispatch_get_main_queue(), ^{
//           NSLog(@"on main queue");
//           [NSTimer scheduledTimerWithTimeInterval:6.0
//                                        target:self
//                                      selector:@selector(DriverLocationGet)
//                                      userInfo:nil
//                                       repeats:YES];
//       });
//   });
//

    

         strLat         =@"28.6139";
         strLong        =@"77.2090";
         
         //30.7500° N, 76.7800° E
         strPassLat                      =@"21.203510";
         strPassLong                     =@"72.839233";
      
      
      
    
    startLocation = CLLocationCoordinate2DMake([strLat floatValue],[strLong floatValue]);
    endLocation = CLLocationCoordinate2DMake([strPassLat floatValue],[strPassLong floatValue]);
    
    
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[strLat floatValue]
                                                             longitude:[strLong floatValue]
                                                                  zoom:7];
    
    
    
    self.objMapVW.camera = camera;
    
   //  GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
     self.objMapVW.myLocationEnabled = YES;

     NSBundle *mainBundle = [NSBundle mainBundle];
     NSURL *styleUrl = [mainBundle URLForResource:@"mapstyle-night" withExtension:@"json"];
     NSError *error;

     // Set the map style by passing the URL for style.json.
     GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL:styleUrl error:&error];

     if (!style) {
       NSLog(@"The style definition could not be loaded: %@", error);
     }

     self.objMapVW.mapStyle = style;
    // self.view = mapView;
       
       
    
    [self drawPathFrom];
       
     //  [self DrawCurvedPolylineOnMapFrom:startLocation To:endLocation];
    
    
    
    
    
    //[[cllocationcordi alloc] initWithLatitude:[strLat doubleValue] longitude:[strLong doubleValue]];
      
//      endLocation = [[CLLocationCoordinate2D alloc] initWithLatitude:[strPassLat doubleValue] longitude:[strPassLong doubleValue]];
//
    
    
  
}



//- (void)loadView {
//
//
//}



- (void)DrawCurvedPolylineOnMapFrom:(CLLocationCoordinate2D)startLocation To:(CLLocationCoordinate2D)endLocation
{
    GMSMutablePath * path = [[GMSMutablePath alloc]init];
    [path addCoordinate:startLocation];
    [path addCoordinate:endLocation];
    // Curve Line
    double k = 0.2; //try between 0.5 to 0.2 for better results that suits you
    CLLocationDistance d = GMSGeometryDistance(startLocation, endLocation);
    float h = GMSGeometryHeading(startLocation , endLocation);

    //Midpoint position
    CLLocationCoordinate2D p = GMSGeometryOffset(startLocation, d * 0.5, h);
    //Apply some mathematics to calculate position of the circle center
    float x = (1-k*k)*d*0.5/(2*k);
    float r = (1+k*k)*d*0.5/(2*k);
    CLLocationCoordinate2D c = GMSGeometryOffset(p, x, h + -90.0);

    //Polyline options
    //Calculate heading between circle center and two points
    float h1 =  GMSGeometryHeading(c, startLocation);
    float h2 = GMSGeometryHeading(c, endLocation);
    //Calculate positions of points on circle border and add them to polyline options
    float numpoints = 100;
    float step = ((h2 - h1) / numpoints);
    for (int i = 0; i < numpoints; i++) {
        CLLocationCoordinate2D pi = GMSGeometryOffset(c, r, h1 + i * step);
        [path addCoordinate:pi];
    }

    //Draw polyline
    GMSPolyline * polyline = [GMSPolyline polylineWithPath:path];
    polyline.map = self.objMapVW;
    polyline.strokeWidth = 5.0;
    NSArray *styles = @[[GMSStrokeStyle solidColor:[UIColor greenColor]],
                        [GMSStrokeStyle solidColor:[UIColor clearColor]]];

    NSArray *lengths = @[@5, @5];

    polyline.spans = GMSStyleSpans(polyline.path, styles, lengths, kGMSLengthRhumb);

//    GMSCoordinateBounds * bounds = [[GMSCoordinateBounds alloc]initWithCoordinate:startLocation coordinate:endLocation];
//    UIEdgeInsets insets = UIEdgeInsetsMake(20, 20, 20, 20);
//    GMSCameraPosition * camera = [self.objMapVW cameraForBounds:bounds insets:insets ];
   // [self.objMapVW animateToCameraPosition:camera];

}





-(void)viewWillAppear:(BOOL)animated{
    
    
    //[self DriverLocationGet];
    
//    [SVProgressHUD showWithStatus:@"Loading..."];
//             dispatch_async(dispatch_get_main_queue(), ^{
//
//
//
//                 [self DriverLocationGet];
//                // [self.objTbl reloadData];
//             });
//
    
}
-(void)showAlert
{
    [self showMessage:@"check your internet connection"
            withTitle:@"Trucky Ducky"];
}

-(void)showMessage:(NSString*)message withTitle:(NSString *)title
{
    UIAlertController * alert =[UIAlertController
                                alertControllerWithTitle:title
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^( UIAlertAction *action )
                               {
                                   // do something when click button
                               }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}








-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

    NSString *CurrentLocatoin  = [NSString stringWithFormat:@"%f,%f", manager.location.coordinate.latitude, manager.location.coordinate.longitude];
    NSLog(@"Current Locaiton is: %@",CurrentLocatoin);
    
    
    // 18Feb
    [CLlocationManger startUpdatingHeading];


    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: manager.location.coordinate.latitude
                                                            longitude:manager.location.coordinate.longitude
                                                                 zoom:16];
    self.objMapVW.camera = camera;

    self.objMapVW .settings.compassButton = YES;
    self.objMapVW .settings.myLocationButton = YES;
    self.objMapVW.myLocationEnabled = YES;
    self.objMapVW .delegate=self;

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



-(void)CurrentLocationCall
{
    CLlocationManger = [[CLLocationManager alloc] init];
    [CLlocationManger requestAlwaysAuthorization];
    [CLlocationManger requestWhenInUseAuthorization];
    CLlocationManger.delegate=self;
    CLlocationManger.distanceFilter = kCLDistanceFilterNone;
    CLlocationManger.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [CLlocationManger startUpdatingLocation];
    
       
    
}


- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark webService Call 
-(void)DriverLocationGet
{

    NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]GetDriverLocationForTracking:self.StrPassDriverID];
    NSLog(@"Data is %@",arrLogin);
    
    
     [SVProgressHUD dismiss];
    if (arrLogin.count==0)
    {
            [self showMessage:@"Server is busy. Please wait."
                    withTitle:@"Trucky Ducky"];
    }
    else
    {
        
        if ([[[arrLogin  objectAtIndex:0] valueForKey:@"status"] isEqualToString:@"success"])
        {
            
            NSArray *arrTemp;
            arrTemp = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            arrResponse = [arrTemp  valueForKey:@"response"];
            
            strDriverLattitude = [[arrResponse valueForKey:@"Latitude"]objectAtIndex:0];
            strDriverLongitude = [[arrResponse valueForKey:@"Longitude"]objectAtIndex:0];
            
            [self ShowDriverMarker];
            
           

        }
        else
        {
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            strAlert = [arrResponse valueForKey:@"msg"];
          
                [self showMessage:strAlert
                        withTitle:@"Trucky Ducky"];
                
           
        }
    }
}


-(void)ShowDriverMarker
{
    
    DriverMarker.map = nil;
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:2.0];
    
    GMSCameraPosition *cameraPosition = [GMSCameraPosition cameraWithLatitude:[strDriverLattitude doubleValue]
                                                                    longitude:[strDriverLongitude doubleValue]
                                                                         zoom:18.0];

    // Creates a marker in the Current LOCATION of the map.
     DriverMarker = [[GMSMarker alloc] init];
    
     DriverMarker.position = CLLocationCoordinate2DMake( [strDriverLattitude doubleValue], [strDriverLongitude doubleValue]);
    
     CLLocationCoordinate2D position = CLLocationCoordinate2DMake( [strDriverLattitude doubleValue],[strDriverLongitude doubleValue]);
       CLLocationDegrees degrees = 90;
       DriverMarker= [GMSMarker markerWithPosition:position];
       DriverMarker.groundAnchor = CGPointMake(0.5, 0.5);
       DriverMarker.rotation = degrees;
       
       DriverMarker.icon = [UIImage imageNamed:@"duck_track_icon.png"];
       DriverMarker.map = self.objMapVW;

       [self.objMapVW animateToCameraPosition:cameraPosition];
    
    
    
    
     [CATransaction commit];
    
    
     
}





-(void)drawPathFrom
{
    
    
    NSString    *baseUrl    = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@,%@&destination=%@,%@&sensor=true&key=AIzaSyADyDKWRpepDv2l00WJ4EVvEFmS3IlzPVc", strLat,  strLong, strPassLat,strPassLong];
    NSLog(@"%@",baseUrl);
    
    NSURL       *url            = [NSURL URLWithString:[baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if(!connectionError)
         {
             NSDictionary       *result                 = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             NSLog(@"%@",result);
             NSArray               *routes              = [result objectForKey:@"routes"];
             NSDictionary       *firstRoute             = [routes objectAtIndex:0];
             
            
             NSString                 *encodedPath         = [firstRoute[@"overview_polyline"] objectForKey:@"points"];
             GMSPolyline              *polyPath            = [GMSPolyline polylineWithPath:[GMSPath pathFromEncodedPath:encodedPath]];
             polyPath.strokeColor                          = [UIColor blueColor];
             polyPath.strokeWidth                          = 4.5f;
             polyPath.map                                  = self.objMapVW;
             
         }
     }];
    
}









-(void)MoveMarker
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:2.0];
   // marker.position = coordindates;
    [CATransaction commit];
}




// 18Feb
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
  DriverMarker.rotation =  (manager.heading.trueHeading) * M_PI / 180.0f; }








@end
