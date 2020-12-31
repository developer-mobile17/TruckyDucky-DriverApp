//
//  HistoryListingDetailsVC.m
//  TruckyDucky
//
//  Created by anil kumar on 14/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "HistoryListingDetailsVC.h"
#import "HistoryListingDetailCell.h"
 #import <CoreLocation/CoreLocation.h>

@interface HistoryListingDetailsVC ()
{
   
       NSArray *arrDriverData;
    
    
       NSString *stPickup_Lat;
       NSString *strPickup_Long;
       
       NSString *strDropoff_Lat;
       NSString *strDropoff_Long;
       
       GMSMarker * PickupMarker;
       GMSMarker * DropoffMarker;
    
      NSString *StrDriverPhoneNumber;
    
    
    
}

@end

@implementation HistoryListingDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
      [self.objTbl setBackgroundColor:[UIColor whiteColor]];
    
       NSLog(@"%@",self.arrHistoryDataPass);
    
         arrDriverData = [self.arrHistoryDataPass valueForKey:@"Driver_Id"];
      
         StrDriverPhoneNumber =[arrDriverData valueForKey:@"Mobile"];
      
          #pragma mark: Getting Coordinate location here for route Draw
             
          stPickup_Lat = [self.arrHistoryDataPass  valueForKey:@"Pickup_Lat"];
          strPickup_Long = [self.arrHistoryDataPass  valueForKey:@"Pickup_Long"];
          strDropoff_Lat = [self.arrHistoryDataPass  valueForKey:@"Dropoff_Lat"];
          strDropoff_Long = [self.arrHistoryDataPass valueForKey:@"Dropoff_Long"];
                
               
      
     
    
}



//-(void) setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners
//{
//    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(10.0, 10.0)];
//
//    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
//    [shape setPath:rounded.CGPath];
//
//    view.layer.mask = shape;
//}

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
   
    return  1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"HistoryListingDetailCell";
    HistoryListingDetailCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[HistoryListingDetailCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:MyIdentifier] ;
    }
    
    
    
        cell.lblDriverName.text = @"Driver name";
    
    
   
     
       cell.lblPickup_Address.text = [self.arrHistoryDataPass valueForKey:@"Pickup_Address"];
       cell.lblDropoff_Address.text = [self.arrHistoryDataPass valueForKey:@"Dropoff_Address"];
    
    
      cell.lblCompanyX.text = [self.arrHistoryDataPass valueForKey:@"Pickup_Name"];
      cell.lblCompanyY.text = [self.arrHistoryDataPass valueForKey:@"Dropoff_Name"];
    
    
       cell.lblDistance.text = [NSString stringWithFormat:@"%@km",[self.arrHistoryDataPass valueForKey:@"Distance"]];
       cell.lblVehicle.text = [self.arrHistoryDataPass valueForKey:@"Total_Vehicle"];
       cell.lblBrand.text = [self.arrHistoryDataPass valueForKey:@"Car_Make"];
       cell.lblModel.text = [self.arrHistoryDataPass valueForKey:@"Car_Model"];
       cell.lblRego.text = [self.arrHistoryDataPass valueForKey:@"Car_Rego"];
       cell.lblColor.text = [self.arrHistoryDataPass valueForKey:@"Car_Colour"];

    
    
    
     //  cell.lblDriverName.text = [[arrDriverData objectAtIndex:indexPath.row]valueForKey:@"Full_Name"];
   //  cell.lblDriverCompany.text = [arrDriverData valueForKey:@"Full_Name"]; //@"Driver Company XYZ";
    //[[arrDriverData objectAtIndex:indexPath.row]valueForKey:@"Price"];
       cell.lblPrice.text = [NSString stringWithFormat:@"Price $%@",[self.arrHistoryDataPass valueForKey:@"Price"]];
    
    
    
    
    
     
      
       cell.btnClickToCall.tag = indexPath.row;
       [cell.btnClickToCall addTarget:self action:@selector(btnCallClicked:) forControlEvents: UIControlEventTouchUpInside];
    
   
    [cell setBackgroundColor:[UIColor whiteColor]];
    cell.bckView.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.2].CGColor;
    cell.bckView.layer.shadowOffset = CGSizeMake(3.0, 3.0);
    cell.bckView.layer.shadowOpacity = 17.0;
    cell.bckView.layer.shadowRadius = 7.0;
    cell.bckView.layer.cornerRadius = 10;
    
    
     
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[stPickup_Lat doubleValue]
                                                                longitude:[strPickup_Long doubleValue]
                                                                     zoom:8];
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
    

   
   
    



-(void)btnCallClicked: (UIButton *)sender

{
       NSString *phoneStr = [NSString stringWithFormat:@"tel:%@",StrDriverPhoneNumber];
        NSURL *phoneURL = [NSURL URLWithString:phoneStr];
        [[UIApplication sharedApplication] openURL:phoneURL];
   
}





@end
