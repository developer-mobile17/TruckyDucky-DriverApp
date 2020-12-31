//
//  SingleBookListingDetailsVC.m
//  TruckyDucky
//
//  Created by anil kumar on 18/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "SingleBookListingDetailsVC.h"
#import "BookingDetailsCell.h"
#import <CoreLocation/CoreLocation.h>

#import "SingleBookListingDetailsVC.h"
#import "webServicesSingulton.h"
#import "SVProgressHUD.h"
#import "checkInternet.h"
#import "UIImageView+WebCache.h"


@interface SingleBookListingDetailsVC ()
{
      
    NSArray *arrDriverData;
    
    NSString *stPickup_Lat;
    NSString *strPickup_Long;
    
    NSString *strDropoff_Lat;
    NSString *strDropoff_Long;
    
    GMSMarker * PickupMarker;
    GMSMarker * DropoffMarker;
    
    NSArray *arrResponse;
    
    NSString *strListingID;
    NSString *strDriverID;
    NSString *StrDriverPhoneNumber;
    NSString *strBaseURL;
    
    
}

@end

@implementation SingleBookListingDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
        NSLog(@"%@",self.arrBookDetailsPass);
    

        arrDriverData = [self.arrBookDetailsPass valueForKey:@"Driver_Id"];
    
       strDriverID = [arrDriverData  valueForKey:@"User_Id"];
       StrDriverPhoneNumber = [arrDriverData  valueForKey:@"Mobile"];
       strListingID = [self.arrBookDetailsPass  valueForKey:@"Id"];
      
    
    
    
        #pragma mark: Getting Coordinate location here for route Draw
           
        stPickup_Lat = [self.arrBookDetailsPass  valueForKey:@"Pickup_Lat"];
        strPickup_Long = [self.arrBookDetailsPass  valueForKey:@"Pickup_Long"];
        strDropoff_Lat = [self.arrBookDetailsPass  valueForKey:@"Dropoff_Lat"];
        strDropoff_Long = [self.arrBookDetailsPass  valueForKey:@"Dropoff_Long"];
              
             
    
    
    
        #pragma mark: Setup google map here
    
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[stPickup_Lat doubleValue]
                                                                longitude:[strPickup_Long doubleValue]
                                                                     zoom:12];
        self.objMapVW.camera = camera;
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
    
    
      
    
       PickupMarker = [[GMSMarker alloc] init];
       PickupMarker.position = CLLocationCoordinate2DMake([stPickup_Lat doubleValue], [strPickup_Long doubleValue]);
      
       PickupMarker.icon = [UIImage imageNamed:@"duck_track_icon.png"];
       PickupMarker.map = self.objMapVW;
       
    
         DropoffMarker = [[GMSMarker alloc] init];
         DropoffMarker.position = CLLocationCoordinate2DMake([strDropoff_Lat doubleValue], [strDropoff_Long doubleValue]);
              
         DropoffMarker.icon = [UIImage imageNamed:@"pin.png"];
         DropoffMarker.map = self.objMapVW;
    
    
    
          [self drawPathFrom];
    
    
    // ******************************************************************************
    
    
      [self.objMapVW addSubview:_btnClose];
      [self.vwFooterTbl addSubview:_btnCall];
      [self setNeedsStatusBarAppearanceUpdate];
      self.objTbl.tableHeaderView = self.vwHeaderTop;
      self.objTbl.tableFooterView = self.vwFooterTbl;
      [self.objTbl setBackgroundColor:[UIColor whiteColor]];

      
   
}





-(void)drawPathFrom
{
    

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
             polyPath.map                                  = self.objMapVW;
             
         }
     }];
    
}





-(void)checkinternet
{
    BOOL checkInternetbool1=[checkInternet connectedToNetwork];
    
    if (checkInternetbool1 == NO)
    {
        [self hideloader];
        [self showAlert];
        
    }
    else
    {
         [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                       [self CancelledByCustomer];
                        });
       
        
       
    }
}
-(void)loaderback
{
    [SVProgressHUD show];
}
-(void)hideloader
{
    [SVProgressHUD dismiss];
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
    static NSString *MyIdentifier = @"BookingDetailsCell";
    BookingDetailsCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[BookingDetailsCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:MyIdentifier] ;
    }
    
    
  

       cell.lblPickup_Address.text = [self.arrBookDetailsPass valueForKey:@"Pickup_Address"];
       cell.lblDropoff_Address.text = [self.arrBookDetailsPass valueForKey:@"Dropoff_Address"];
    
      cell.lblCompanyX.text = [self.arrBookDetailsPass valueForKey:@"Pickup_Name"];
      cell.lblCompanyY.text = [self.arrBookDetailsPass valueForKey:@"Dropoff_Name"];
    
    
       cell.lblDistance.text = [NSString stringWithFormat:@"%@km",[self.arrBookDetailsPass valueForKey:@"Distance"]];
       cell.lblVehicle.text = [self.arrBookDetailsPass valueForKey:@"Total_Vehicle"];
       cell.lblBrand.text = [self.arrBookDetailsPass valueForKey:@"Car_Make"];
       cell.lblModel.text = [self.arrBookDetailsPass valueForKey:@"Car_Model"];
       cell.lblRego.text = [self.arrBookDetailsPass valueForKey:@"Car_Rego"];
       cell.lblColor.text = [self.arrBookDetailsPass valueForKey:@"Car_Colour"];




       cell.lblDriverName.text = [arrDriverData valueForKey:@"Full_Name"];
       cell.lblDriverCompany.text = [self.arrBookDetailsPass valueForKey:@"Pickup_Name"];  //[[arrDriverData objectAtIndex:indexPath.row]valueForKey:@"Price"];
       cell.lblPrice.text = [NSString stringWithFormat:@"Price $%@",[self.arrBookDetailsPass valueForKey:@"Price"]];

    
    
    
    NSString *url_Img_FULL = [arrDriverData valueForKey:@"Profile_Image"];
    
    strBaseURL=[[NSUserDefaults standardUserDefaults]valueForKey:@"BaseURLPass"];
    NSLog(@" UserID of Logged in User is..%@", strBaseURL);
    
    
    if (url_Img_FULL == nil || url_Img_FULL == (id)[NSNull null]) {
      // nil branch
    } else {
      
        NSString *imgProfileURL = [strBaseURL stringByAppendingString:url_Img_FULL];
       
       [cell.self.imgProfile sd_setImageWithURL:[NSURL URLWithString:imgProfileURL]
                                placeholderImage:[UIImage imageNamed:@"NoImage.png"] options:(0) == 0 ? SDWebImageRefreshCached : 0];
        cell.imgProfile.layer.borderColor = [UIColor.lightGrayColor CGColor];
           
        cell.imgProfile.layer.cornerRadius = cell.imgProfile.frame.size.width/2;
        
        
    }
    
    
    
    
   
   
      
    
    // cell.imgProfile.text = [[self.arrBookDetailsPass objectAtIndex:indexPath.row]valueForKey:@"Price"];
      
    
    
    
    
       
       
    
    
    
    
    
    
    

   // cell.imgVWIcons.image = [UIImage imageNamed:[arrTempImage objectAtIndex:indexPath.row]];
    
    
    
//
//     cell.btnOffers.layer.cornerRadius = 5;
//      cell.btnOffers.layer.borderColor = [[UIColor lightGrayColor]CGColor];
//     cell.btnOffers.layer.borderWidth = 2;
//     cell.btnOffers.tag = indexPath.row;
//
//    [cell.btnOffers addTarget:self action:@selector(btnOffersClicked:) forControlEvents:UIControlEventTouchUpInside];
//
    
    
  
    
    [cell setBackgroundColor:[UIColor whiteColor]];
    cell.btnCancelDriver.layer.cornerRadius = 5;
    cell.btnCancelDriver.tag = indexPath.row;
    [cell.btnCancelDriver addTarget:self action:@selector(btnCancelDriverClicked:) forControlEvents: UIControlEventTouchUpInside];
    
    return cell;
}


-(void)btnCancelDriverClicked: (UIButton *)sender

{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Trucky Ducky " message:@"Are you sure want to cancel the Driver ?" preferredStyle:UIAlertControllerStyleAlert];

                                         UIAlertAction *YesCancel = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                            [self checkinternet];
                                                             }];
    
    UIAlertAction *NOCancel = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                                              
                                                                }];
                                         
                                         
        [alert addAction:YesCancel];
        [alert addAction:NOCancel];
    
        [self presentViewController:alert animated:YES completion:nil];
   
}


#pragma mark webService Call 
-(void)CancelledByCustomer
{
   // NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]CancelByCustomer:strListingID :strDriverID];
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
            
            
           
            NSString *strMsg  = [[arrLogin objectAtIndex:0] valueForKey:@"msg"];
            
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Trucky Ducky " message:strMsg preferredStyle:UIAlertControllerStyleAlert];

                                      UIAlertAction *Verification = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                         [self backToBookingScreen];
                                                          }];
                                      
                                      
                                      [alert addAction:Verification];

            [self presentViewController:alert animated:YES completion:nil];
            
           
            
  
        }
        else
        {
             NSString *strErrorMsg = [[arrLogin objectAtIndex:0] valueForKey:@"msg"];
            [self showMessage:strErrorMsg
            withTitle:@"Trucky Ducky"];
          //  arrResponse = nil;
           
            
            
        }
    }
}


-(void)backToBookingScreen
{
   
    [self.navigationController popViewControllerAnimated:YES];
}




-(void)btnAnimateClicked: (UIButton *)sender

{
    [self tableViewScrollToBottomAnimated:YES];
   
}

- (void)tableViewScrollToBottomAnimated:(BOOL)animated {
    NSInteger numberOfRows = [self.objTbl numberOfRowsInSection:0];
    if (numberOfRows) {
        [self.objTbl scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:numberOfRows-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}



- (IBAction)actoinCall:(id)sender
{
    NSString *phoneStr = [NSString stringWithFormat:@"tel:%@",StrDriverPhoneNumber];
    NSURL *phoneURL = [NSURL URLWithString:phoneStr];
    [[UIApplication sharedApplication] openURL:phoneURL];
}



- (IBAction)actionChat:(id)sender {
}

@end
