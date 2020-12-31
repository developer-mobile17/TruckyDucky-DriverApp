//
//  NewJobFullDetailsVC.m
//  TruckyDucky
//
//  Created by anil kumar on 30/04/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import "NewJobFullDetailsVC.h"
#import "NewJobfullDetailsCell.h"
#import <GoogleMaps/GoogleMaps.h>
@interface NewJobFullDetailsVC ()
{
    NSString *stPickup_Lat;
    NSString *strPickup_Long;
    
    NSString *strDropoff_Lat;
    NSString *strDropoff_Long;
    
    GMSMarker * PickupMarker;
    GMSMarker * DropoffMarker;
}

@end

@implementation NewJobFullDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.arrNewJobDetialDataPass);
    [self setNeedsStatusBarAppearanceUpdate];
    
    
    
    #pragma mark: Getting Coordinate location here for route Draw
                
             stPickup_Lat = [self.arrNewJobDetialDataPass  valueForKey:@"Pickup_Lat"];
             strPickup_Long = [self.arrNewJobDetialDataPass  valueForKey:@"Pickup_Long"];
             strDropoff_Lat = [self.arrNewJobDetialDataPass  valueForKey:@"Dropoff_Lat"];
             strDropoff_Long = [self.arrNewJobDetialDataPass valueForKey:@"Dropoff_Long"];
                   
    
    
}



- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDarkContent;
}



- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark: UITableView 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"NewJobfullDetailsCell";
    NewJobfullDetailsCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[NewJobfullDetailsCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:MyIdentifier] ;
    }
    
    
  

       cell.lblPickupLocation.text = [self.arrNewJobDetialDataPass valueForKey:@"Pickup_Address"];
       cell.lblDropoffLocation.text = [self.arrNewJobDetialDataPass valueForKey:@"Dropoff_Address"];
    
      
       cell.lblDistance.text = [NSString stringWithFormat:@"%@km",[self.arrNewJobDetialDataPass valueForKey:@"Distance"]];
       cell.lblVehicles.text = [self.arrNewJobDetialDataPass valueForKey:@"Total_Vehicle"];
       cell.lblBrand.text = [self.arrNewJobDetialDataPass valueForKey:@"Car_Make"];
       cell.lblModel.text = [self.arrNewJobDetialDataPass valueForKey:@"Car_Model"];
       cell.lblRegoNo.text = [self.arrNewJobDetialDataPass valueForKey:@"Car_Rego"];
       cell.lblRegoNo.text = [self.arrNewJobDetialDataPass valueForKey:@"Car_Colour"];



    
       [cell setBackgroundColor:[UIColor whiteColor]];
       cell.bckView.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.2].CGColor;
       cell.bckView.layer.shadowOffset = CGSizeMake(3.0, 3.0);
       cell.bckView.layer.shadowOpacity = 17.0;
       cell.bckView.layer.shadowRadius = 7.0;
       cell.bckView.layer.cornerRadius = 10;
    
       
    
    
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[stPickup_Lat doubleValue]
                                                                longitude:[strPickup_Long doubleValue]
                                                                     zoom:12];
        cell.objMapVW.camera = camera;
        cell.objMapVW.myLocationEnabled = YES;

        NSBundle *mainBundle = [NSBundle mainBundle];
        NSURL *styleUrl = [mainBundle URLForResource:@"mapstyle-night" withExtension:@"json"];
        NSError *error;

        // Set the map style by passing the URL for style.json.
        GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL:styleUrl error:&error];

        if (!style) {
          NSLog(@"The style definition could not be loaded: %@", error);
        }

         cell.objMapVW.mapStyle = style;


        
           PickupMarker = [[GMSMarker alloc] init];
           PickupMarker.position = CLLocationCoordinate2DMake([stPickup_Lat doubleValue], [strPickup_Long doubleValue]);
          
           PickupMarker.icon = [UIImage imageNamed:@"duck_track_icon.png"];
           PickupMarker.map = cell.objMapVW;
           
        
             DropoffMarker = [[GMSMarker alloc] init];
             DropoffMarker.position = CLLocationCoordinate2DMake([strDropoff_Lat doubleValue], [strDropoff_Long doubleValue]);
                  
             DropoffMarker.icon = [UIImage imageNamed:@"pin.png"];
             DropoffMarker.map = cell.objMapVW;
        
        
        
        
        
        
        
        NSString    *baseUrl    = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%@,%@&destination=%@,%@&sensor=true&key=AIzaSyADyDKWRpepDv2l00WJ4EVvEFmS3IlzPVc", stPickup_Lat,  strPickup_Long, strDropoff_Lat,strDropoff_Long];
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
                 polyPath.map                                  = cell.objMapVW;
    
             }
         }];
    

     
    return cell;
}

@end
