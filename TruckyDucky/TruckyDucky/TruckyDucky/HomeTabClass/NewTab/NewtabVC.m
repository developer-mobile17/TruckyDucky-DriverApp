//
//  NewtabVC.m
//  TruckyDucky
//k
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "NewtabVC.h"
#import "NewTabCell.h"
#import "BookedtabVC.h"
#import "NewTabDetailinfoVC.h"
#import "ListingArchiveVC.h"

#import "JobConfirmationByCustomerVC.h"
#import "NewJobFullDetailsVC.h"

#import "ProfileVC.h"
#import "RequestForCarVC.h"
#import "SVProgressHUD.h"
#import "webServicesSingulton.h"
#import "checkInternet.h"

@interface NewtabVC ()
{
    NSArray *arrNewBooking;
    NSArray *arrHeaderTitle;
    NSArray *arrResponse;
    
    
    NSString * StrIDSave;
    NSString * StrDriveIDSave;
    NSString *BtnSelect;
    NSString *srBidAmount;
    
    NSString *strSetPrefrenceCheck;
    UIAlertController *forgotalertController;
    
    
    
     NSString *strLoginAsCheck;
     NSString *strCheckCompID;
    
    NSString *strLat;
    NSString *strLong;
    
    
    NSString *strPassLat;
    NSString *strPassLong;
    
    
    CLLocation *startLocation;
    CLLocation *endLocation;
    
    
    
    
    
    
    NSArray *arrActivity;
    
    NSString *strDriverConfirmation;
    
    
    
    
    
    
    
    
    
    NSString *stPickup_Lat;
    NSString *strPickup_Long;
    
    NSString *strDropoff_Lat;
    NSString *strDropoff_Long;
    
    
    GMSMarker * PickupMarker;
    GMSMarker * DropoffMarker;
    
    
    
}

@end

@implementation NewtabVC

- (void)viewDidLoad {
    [super viewDidLoad];
       
    [self setNeedsStatusBarAppearanceUpdate];
    
    // Check First Time login for direct home UI
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"GotoHomeUI" forKey:@"Already Login"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    
   // NSString *startingPoint = CLLocationCoordinate2DMake([strLat doubleValue], [strLong doubleValue]);
    
    
       self.tabBarController.tabBar.translucent = YES;
       self.tabBarController.tabBar .layer.cornerRadius = 18;
       self.tabBarController.tabBar .layer.masksToBounds = YES;
       self.tabBarController.tabBar .clipsToBounds = YES;
    
    
    

    
    
    self.lblRequestForCar.layer.cornerRadius = 22;
    self.lblRequestForCar.clipsToBounds = YES;
    
    [self.objTbl setBackgroundColor:[UIColor whiteColor]];
    self.imgBackCounter.layer.cornerRadius = self.imgBackCounter.frame.size.width/2;
    
    self.vwNoData.layer.cornerRadius = 5;
    self.vwNoData.hidden = YES;
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    
    
    [SVProgressHUD showWithStatus:@"Loading..."];
                     
                            
    [self performSelector:@selector(checkinternet) withObject:nil afterDelay:0.2];
         
    
    
 
    
        
}


-(void)checkinternet
{
    BOOL checkInternetbool1=[checkInternet connectedToNetwork];
    
    if (checkInternetbool1 == NO)
    {
       [SVProgressHUD dismiss];
        [self showAlert];
        
    }
    else
    {
       
            
        [SVProgressHUD showWithStatus:@"Loading..."];
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
        [self calledGetListingWebService];
                     });
       
    }
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDarkContent;
}




-(void)showAlert
{
    [self showMessage:@"Check your internet connection"
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


#pragma mark webService Call 
-(void)calledGetListingWebService
{

   
    NSArray *arrLogin = [[webServicesSingulton sharedManager]GetCarsById:[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"]];
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
            
            self.vwNoData.hidden = YES;
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            
            arrActivity = [[arrResponse objectAtIndex:0] valueForKey:@"Activity"];
            
            arrNewBooking =  arrResponse;
            
            
            
            [self.objTbl reloadData];
            

        }
        else
        {
            
            // Status  = Error
            arrNewBooking = nil;
            [self.objTbl reloadData];
            NSString *strNoData;
            strNoData = [[arrLogin objectAtIndex:0] valueForKey:@"msg"];
            
          
            self.vwNoData.hidden = NO;
            self.lblNoData.text = strNoData;
           
        }
        

        }
    }


#pragma mark: UITableView 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  [arrNewBooking count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"NewTabCell";
    NewTabCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[NewTabCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:MyIdentifier] ;
}
    
  
  
    
    [cell.objMapVW clear];
    
    
    
    cell.lblPickupLocation.text =  [[arrNewBooking objectAtIndex:indexPath.row] valueForKey:@"Pickup_Address"];
    cell.lblDropoffLocation.text =  [[arrNewBooking objectAtIndex:indexPath.row] valueForKey:@"Dropoff_Address"];
    
    cell.lblDistance.text = [NSString stringWithFormat:@"%@km",[[arrNewBooking objectAtIndex:indexPath.row]valueForKey:@"Distance"]];
    cell.lblVehicles.text =  [[arrNewBooking objectAtIndex:indexPath.row] valueForKey:@"Total_Vehicle"];
    cell.lblBrand.text =  [[arrNewBooking objectAtIndex:indexPath.row] valueForKey:@"Car_Make"];
    cell.lblModel.text =  [[arrNewBooking objectAtIndex:indexPath.row] valueForKey:@"Car_Model"];
    cell.lblRegoNo.text =  [[arrNewBooking objectAtIndex:indexPath.row] valueForKey:@"Car_Rego"];
    cell.lblColour.text =  [[arrNewBooking objectAtIndex:indexPath.row] valueForKey:@"Car_Colour"];
    
    strDriverConfirmation = [[arrNewBooking objectAtIndex:indexPath.row]valueForKey:@"Driver_Confirm"];
    NSLog(@"%@", strDriverConfirmation);
    if (strDriverConfirmation == nil || strDriverConfirmation == (id)[NSNull null])
      {
          [cell.btnOffers setTitle:@"OFFER" forState:UIControlStateNormal];
          [cell.btnOffers setBackgroundColor:[UIColor blackColor]];
          [cell.btnOffers setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     }
    
    else  if ([strDriverConfirmation isEqualToString:@"Pending"])
    {
        [cell.btnOffers setTitle:@"Pending" forState:UIControlStateNormal];
        [cell.btnOffers setBackgroundColor:[UIColor whiteColor]];
        [cell.btnOffers setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
    }
    
    else
    {
        
        [cell.btnOffers setTitle:@"Successful" forState:UIControlStateNormal];
        [cell.btnOffers setBackgroundColor:[UIColor whiteColor]];
        [cell.btnOffers setTitleColor:[UIColor colorWithRed: 31/255.0f green:181/255.0f blue:95/255.0f alpha:1] forState:UIControlStateNormal];
    }
  
    
    
    // sbi.50778@sbi.co.in
    
    
     [cell setBackgroundColor:[UIColor whiteColor]];
     cell.bckView.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.2].CGColor;
     cell.bckView.layer.shadowOffset = CGSizeMake(3.0, 3.0);
     cell.bckView.layer.shadowOpacity = 17.0;
     cell.bckView.layer.shadowRadius = 7.0;
     cell.bckView.layer.cornerRadius = 10;

    
    
    
    
   
    
    
     cell.btnOffers.layer.cornerRadius = 5;
    // cell.btnOffers.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    // cell.btnOffers.layer.borderWidth = 1;
     cell.btnOffers.tag = indexPath.row;
    
    
    cell.btnDeailsCheck.tag = indexPath.row;
    
    [cell.btnDeailsCheck addTarget:self action:@selector(btnDeailsCheckClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [cell.btnOffers addTarget:self action:@selector(btnOffersClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
      
        #pragma mark: Getting Coordinate location here for route Draw
                
             stPickup_Lat = [[arrNewBooking objectAtIndex:indexPath.row] valueForKey:@"Pickup_Lat"];
             strPickup_Long = [[arrNewBooking objectAtIndex:indexPath.row]  valueForKey:@"Pickup_Long"];
             strDropoff_Lat = [[arrNewBooking objectAtIndex:indexPath.row]  valueForKey:@"Dropoff_Lat"];
             strDropoff_Long = [[arrNewBooking objectAtIndex:indexPath.row]  valueForKey:@"Dropoff_Long"];
    
    
       
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[stPickup_Lat doubleValue]
                                                                longitude:[strPickup_Long doubleValue]
                                                                     zoom:7];
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
        
    
    
    
    
    
    
        GMSMutablePath *path = [GMSMutablePath path];
        [path addCoordinate:CLLocationCoordinate2DMake([stPickup_Lat doubleValue], [strPickup_Long doubleValue])];
        [path addCoordinate:CLLocationCoordinate2DMake([strDropoff_Lat doubleValue], [strDropoff_Long doubleValue])];

        GMSPolyline *line = [GMSPolyline polylineWithPath:path];
       line.strokeColor                          = [UIColor blueColor];
       line.strokeWidth                          = 4.5f;
       line.map = cell.objMapVW;
        
        
    
    
    
    return cell;
}





-(void)btnDeailsCheckClicked: (UIButton *)sender

{
     NewJobFullDetailsVC *Details = [self.storyboard instantiateViewControllerWithIdentifier:@"NewJobFullDetailsVC"];
    Details.self.arrNewJobDetialDataPass = [arrNewBooking objectAtIndex:sender.tag];
    
     [self.navigationController pushViewController:Details animated:YES];
   
}




-(void)btnOffersClicked: (UIButton *)sender

{
     NewTabDetailinfoVC *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"NewTabDetailinfoVC"];
    
    
     [self.navigationController pushViewController:Login animated:YES];
   
}










- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionNotificationClicked:(id)sender {
   
    JobConfirmationByCustomerVC *jobConfirmation = [self.storyboard instantiateViewControllerWithIdentifier:@"JobConfirmationByCustomerVC"];
       [self.navigationController pushViewController:jobConfirmation animated:YES];
    
}

- (IBAction)actionListingArchive:(id)sender{
    
    ListingArchiveVC*Login = [self.storyboard instantiateViewControllerWithIdentifier:@"ListingArchiveVC"];
    [self.navigationController pushViewController:Login animated:YES];
}

- (IBAction)actionRequestForCar:(id)sender {
    RequestForCarVC *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"RequestForCarVC"];
       [self.navigationController pushViewController:Login animated:YES];
}












@end
