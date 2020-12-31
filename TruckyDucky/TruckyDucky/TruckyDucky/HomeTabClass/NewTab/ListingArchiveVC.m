//
//  ListingArchiveVC.m
//  TruckyDucky
//
//  Created by anil kumar on 11/03/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import "ListingArchiveVC.h"
#import "ListingArchiveCell.h"

#import "RequestForCarVC.h"
#import "SVProgressHUD.h"
#import "webServicesSingulton.h"
#import "checkInternet.h"

@interface ListingArchiveVC ()
{
    UIDatePicker *DatePicker;
    
      NSString *strLat;
      NSString *strLong;
      
      
      NSString *strPassLat;
      NSString *strPassLong;
    
    NSArray *arrListingArchive;
    NSString *strListingID;
    
    
    
    NSString *stPickup_Lat;
    NSString *strPickup_Long;
    
    NSString *strDropoff_Lat;
    NSString *strDropoff_Long;
    
    
    GMSMarker * PickupMarker;
    GMSMarker * DropoffMarker;
    
    NSString *DeliveryDate;
    NSString *strNoData;
    NSArray *arrResponse;
    
    
     NSString *CurrentDate;
    
    
}


@end

@implementation ListingArchiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.objTbl setBackgroundColor:[UIColor whiteColor]];
}

-(void)viewWillAppear:(BOOL)animated{
self.vwNoData.hidden = YES;
    
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
       [dateFormatter setDateFormat:@"yyy-MM-dd"];
       // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
      // NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
       CurrentDate = [dateFormatter stringFromDate:[NSDate date]];
       
       
       
       
       
       NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
                          [dateFormatter1 setDateFormat:@"MMMM dd,  yyy"];
                          NSString *str1 = [dateFormatter1 stringFromDate:[NSDate date]];
                         NSLog(@"Formated date - %@", str1);//output -> 09-05-2013 09:30
       
       
       
       self.lblDate.text = str1;
       
    
    
[SVProgressHUD showWithStatus:@"Loading..."];
             dispatch_async(dispatch_get_main_queue(), ^{
                 
[self checkinternet];
             });
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
                         
         [self GetHistotyByCurrentDate];
                     });
        
       
       
    }
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


#pragma mark webService Call 
-(void)calledArchiveListingWebService
{
   // NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]BookedHistory:[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"]];
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
            arrListingArchive = [[arrLogin objectAtIndex:0] valueForKey:@"BookedHistory"];
            
            
            //*************************************************************************************
        
           
                   NSString *str = [[arrListingArchive objectAtIndex:0] valueForKey:@"Created_Date"];
                   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                   [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                   NSDate *dt = [dateFormatter dateFromString:str];

                   NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
                   [dateFormatter1 setDateFormat:@"MMMM dd,  yyy"];
                   NSString *str1 = [dateFormatter1 stringFromDate:dt];
                   NSLog(@"Formated date - %@", str1);//output -> 09-05-2013 09:30

                    self.lblDate.text = str1;
            
            
            //**************************************************************************************
            
            
            
            [self.objTbl reloadData];
            
  
        }
        else
        {
            arrListingArchive = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
          //  strAlert = [arrListingArchive valueForKey:@"msg"];
          
//                [self showMessage:strAlert
//                        withTitle:@"Trucky Ducky"];
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
    
    return   [arrListingArchive count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"ListingArchiveCell";
    ListingArchiveCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[ListingArchiveCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:MyIdentifier] ;
}
    

   
        
        cell.lblPickupLocation.text =  [[arrListingArchive objectAtIndex:indexPath.row] valueForKey:@"Pickup_Address"];
        cell.lblDropoffLocation.text =  [[arrListingArchive objectAtIndex:indexPath.row] valueForKey:@"Dropoff_Address"];
        cell.lblDistance.text =  [NSString stringWithFormat:@"%@km",[[arrListingArchive objectAtIndex:indexPath.row]valueForKey:@"Distance"]];
        cell.lblVehicles.text =  [[arrListingArchive objectAtIndex:indexPath.row] valueForKey:@"Total_Vehicle"];
        cell.lblBrand.text =  [[arrListingArchive objectAtIndex:indexPath.row] valueForKey:@"Car_Make"];
        cell.lblModel.text =  [[arrListingArchive objectAtIndex:indexPath.row] valueForKey:@"Car_Model"];
        cell.lblRegoNo.text =  [[arrListingArchive objectAtIndex:indexPath.row] valueForKey:@"Car_Rego"];
        cell.lblColour.text =  [[arrListingArchive objectAtIndex:indexPath.row] valueForKey:@"Car_Colour"];
    
       
        

    
    
    
    
     [cell setBackgroundColor:[UIColor whiteColor]];
     cell.bckView.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.2].CGColor;
     cell.bckView.layer.shadowOffset = CGSizeMake(3.0, 3.0);
     cell.bckView.layer.shadowOpacity = 17.0;
     cell.bckView.layer.shadowRadius = 7.0;
     cell.bckView.layer.cornerRadius = 10;

    
    
    
     cell.btnEdit.layer.cornerRadius = 5;
     cell.btnEdit.tag = indexPath.row;
    
    [cell.btnEdit addTarget:self action:@selector(btnEditClicked:) forControlEvents:UIControlEventTouchUpInside];
    
     cell.btnRequestAgain.layer.cornerRadius = 5;
     cell.btnRequestAgain.tag = indexPath.row;
    
    [cell.btnRequestAgain addTarget:self action:@selector(btnRequestAgainClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
           #pragma mark: Getting Coordinate location here for route Draw
                    
                 stPickup_Lat = [[arrListingArchive objectAtIndex:indexPath.row] valueForKey:@"Pickup_Lat"];
                 strPickup_Long = [[arrListingArchive objectAtIndex:indexPath.row]  valueForKey:@"Pickup_Long"];
                 strDropoff_Lat = [[arrListingArchive objectAtIndex:indexPath.row]  valueForKey:@"Dropoff_Lat"];
                 strDropoff_Long = [[arrListingArchive objectAtIndex:indexPath.row]  valueForKey:@"Dropoff_Long"];
        
        
           
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[stPickup_Lat doubleValue]
                                                                    longitude:[strPickup_Long doubleValue]
                                                                         zoom:11];
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




-(void)btnEditClicked: (UIButton *)sender

{
    NSString *strEditAgain = @"Yes";
     RequestForCarVC *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"RequestForCarVC"];
    
      Login.self.EditAgainCheck = strEditAgain;
      Login.arrPassData = arrListingArchive;
     [self.navigationController pushViewController:Login animated:YES];
   
}



-(void)btnRequestAgainClicked: (UIButton *)sender

{
   
    strListingID = [[arrListingArchive objectAtIndex:sender.tag] valueForKey:@"Id"];
    [self calledRequestAgainService];
   
}

#pragma mark webService Call 
-(void)calledRequestAgainService
{
   // NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]RequestAgain:strListingID];
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
            
           [self showMessage:@"Car Request Again Successfully Delivered" withTitle:@"Trucky Ducky"];
            
  
        }
        else
        {
            arrListingArchive = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
          //  strAlert = [arrListingArchive valueForKey:@"msg"];
          
//                [self showMessage:strAlert
//                        withTitle:@"Trucky Ducky"];
        }
    }
}



- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark : action Select Date & Time  Button
- (IBAction)actionSelectDate:(id)sender {
    
    [self ShowDatePicker];
}


-(void)ShowDatePicker
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];

       UIView *viewDatePicker = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,200)];
    
        [viewDatePicker setTintColor:[UIColor blackColor]];
        [viewDatePicker setBackgroundColor:[UIColor clearColor]];

       CGRect pickerFrame = CGRectMake(0, 0, self.view.frame.size.width, 200);
       DatePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
       DatePicker.datePickerMode = UIDatePickerModeDate;
      
       [viewDatePicker addSubview:DatePicker];

       [alertController.view addSubview:viewDatePicker];


       UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Select Date" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {

    
           [self SelectedDate];
           
        }];

        alertController.view.tintColor = [UIColor blackColor];
       [alertController addAction:defaultAction];
       [self presentViewController:alertController animated:YES completion:nil];
}




-(void)SelectedDate {
    
     
         NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
         NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
       
       
        
        [dateFormatter1 setDateFormat:@" MMMM dd,  yyy"];
        NSString *dateString = [dateFormatter1 stringFromDate:DatePicker.date];
         self.lblDate.text = dateString;
        
        
        [dateFormatter2 setDateFormat:@"yyy-MM-dd"];
        DeliveryDate = [dateFormatter2 stringFromDate:DatePicker.date];
        
        [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                             [self GetHistotyByDate];
                          });
        
    
}


#pragma mark webService Call 
-(void)GetHistotyByDate
{
   // NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]GetHistotyByDate:[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"] :DeliveryDate];
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
            self.lblNoData.text = strNoData;
            
            arrListingArchive = [[arrLogin objectAtIndex:0] valueForKey:@"BookedHistory"];
            [self.objTbl reloadData];
            
  
        }
        else
        {
            arrListingArchive = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            arrResponse = nil;
            [self.objTbl reloadData];
            
            
             strNoData = [[arrLogin objectAtIndex:0] valueForKey:@"msg"];
             self.vwNoData.hidden = NO;
             self.lblNoData.text = strNoData;

            
            
            
        }
    }
}



#pragma mark webService Call 
-(void)GetHistotyByCurrentDate
{
   // NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]GetHistotyByDate:[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"] :CurrentDate];
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
            self.lblNoData.text = strNoData;
            
            arrListingArchive = [[arrLogin objectAtIndex:0] valueForKey:@"BookedHistory"];
            [self.objTbl reloadData];
            
  
        }
        else
        {
            arrListingArchive = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            arrResponse = nil;
            [self.objTbl reloadData];
            
            
             strNoData = [[arrLogin objectAtIndex:0] valueForKey:@"msg"];
             self.vwNoData.hidden = NO;
             self.lblNoData.text = strNoData;

            
            
            
        }
    }
}






@end
