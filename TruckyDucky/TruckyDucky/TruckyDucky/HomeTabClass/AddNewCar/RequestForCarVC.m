//
//  RequestForCarVC.m
//  TruckyDucky
//
//  Created by anil kumar on 30/01/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import "RequestForCarVC.h"

#import "webServicesSingulton.h"
#import "checkInternet.h"
#import "SVProgressHUD.h"

#import <GooglePlaces/GooglePlaces.h>

@interface RequestForCarVC () <GMSAutocompleteViewControllerDelegate,GMSAutocompleteResultsViewControllerDelegate>

{
           GMSAutocompleteFilter *_filter;
           GMSAutocompleteResultsViewController *_resultsViewController;
           UISearchController *_searchController;
           NSString *strCheck;
           NSString *strPickUpAddress;
           NSString *strDropoffAddress;
    
    
           NSString *strPickup_Lat;
           NSString *strPickup_Long;
              
              
           NSString *strDropoff_Lat;
           NSString *strDropoff_Long;
    
          NSString *strDistanceKM;
    
           NSArray *arrResponse;
    
          NSArray *arrSelectedPickerDate;
    
       
}




@end

@implementation RequestForCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
  
    
    
    self.lblTab1.layer.cornerRadius = 4;
    self.lblTab1.clipsToBounds = YES;
    
    self.lblTab2.layer.cornerRadius = 4;
    self.lblTab2.clipsToBounds = YES;
    
    self.lblTab3.layer.cornerRadius = 4;
    self.lblTab3.clipsToBounds = YES;
    
    self.lblTab4.layer.cornerRadius = 4;
    self.lblTab4.clipsToBounds = YES;
    
    
    
    
    self.btnPickupNext.layer.cornerRadius = 5;
    
    self.btnDropOffNext.layer.cornerRadius = 5;
    self.btnDropoffPrevious.layer.cornerRadius = 5;
    
    
    self.btnAmountNext.layer.cornerRadius = 5;
    self.btnAmountPrevious.layer.cornerRadius = 5;
    
    
    self.btnCarNext.layer.cornerRadius = 5;
    self.btnCarPrevious.layer.cornerRadius = 5;
    
    
    
    self.vwDropOffLocation.hidden = YES;
    self.vwEnterAmount.hidden = YES;
    self.vwAddCarCount.hidden = YES;
    self.vwCarDetails.hidden = YES;
    
    
    self.imgCar1.hidden = YES;
    self.imgCar2.hidden = YES;
    self.imgCar3.hidden = YES;
    
    
    
    
    self.btnCar1.layer.borderColor = [[UIColor blackColor]CGColor];
    self.btnCar1.layer.borderWidth = 1;
    self.btnCar1.layer.cornerRadius = 10;
    
    
    self.btnCar2.layer.borderColor = [[UIColor blackColor]CGColor];
    self.btnCar2.layer.borderWidth = 1;
    self.btnCar2.layer.cornerRadius = 10;
    
    
    self.btnCar3.layer.borderColor = [[UIColor blackColor]CGColor];
    self.btnCar3.layer.borderWidth = 1;
    self.btnCar3.layer.cornerRadius = 10;
    
    
    self.vwCarDetails.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.vwCarDetails.layer.borderWidth = 1;
    self.vwCarDetails.layer.cornerRadius = 10;
    
//    [self.btnPickupLocation setTitle:@"Enter PickupLocation" forState:UIControlStateNormal];
//    [self.btnPickupLocation setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    
    
   
    
    NSLog(@"%@",self.arrPassData);
    [self SetPlaceHolderColor];
    
    
    NSLog(@"Check EditAgain? %@",self.EditAgainCheck);
    if ([self.EditAgainCheck isEqualToString:@"Yes"])
    {
        [self AutoFillData];
    }
    
    
    
    
     [self setNeedsStatusBarAppearanceUpdate];
    
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDarkContent;
    
}






-(void)SetPlaceHolderColor
{
     UIColor *color = [UIColor blackColor];
    

    
    self.txfCompanyName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Company Name" attributes:@{NSForegroundColorAttributeName:color}];
    
    
     self.txfDropOffCompanyName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Company Name" attributes:@{NSForegroundColorAttributeName:color}];
    
    
    self.txfEnterAmount.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Enter Number of Cars you want to transport" attributes:@{NSForegroundColorAttributeName:color}];
    
    self.txfCarMake.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Car Make" attributes:@{NSForegroundColorAttributeName:color}];
    
    
     self.txfCarModel.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Car Model" attributes:@{NSForegroundColorAttributeName:color}];
    
      self.txfRegoNo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Registration Number" attributes:@{NSForegroundColorAttributeName:color}];
    
    
    self.txfCarColor.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@" Car Color" attributes:@{NSForegroundColorAttributeName:color}];
}




-(void)AutoFillData
{
    [self.btnPickupLocation setTitle:[[self.arrPassData objectAtIndex:0] valueForKey:@"Pickup_Address"] forState:UIControlStateNormal];
    
    
    strPickUpAddress = [[self.arrPassData objectAtIndex:0] valueForKey:@"Pickup_Address"];
    NSLog(@"%@",[[self.arrPassData objectAtIndex:0] valueForKey:@"Pickup_Address"]);
    
    
    
    self.txfCompanyName.text = [[self.arrPassData objectAtIndex:0] valueForKey:@"Pickup_Name"];
    
    [self.btnDropOffLocation setTitle:[[self.arrPassData objectAtIndex:0] valueForKey:@"Dropoff_Address"] forState:UIControlStateNormal];
    
    
    strDropoffAddress = [[self.arrPassData objectAtIndex:0] valueForKey:@"Dropoff_Address"];
    NSLog(@"%@",[[self.arrPassData objectAtIndex:0] valueForKey:@"Dropoff_Address"]);
    
    
    self.txfDropOffCompanyName.text= [[self.arrPassData objectAtIndex:0] valueForKey:@"Dropoff_Name"];
    self.txfEnterAmount.text = [[self.arrPassData objectAtIndex:0] valueForKey:@"Total_Vehicle"];
    

    self.txfCarMake.text= [[self.arrPassData objectAtIndex:0] valueForKey:@"Car_Make"];
    self.txfCarModel.text = [[self.arrPassData objectAtIndex:0] valueForKey:@"Car_Model"];
    self.txfRegoNo.text= [[self.arrPassData objectAtIndex:0] valueForKey:@"Car_Rego"];
    self.txfCarColor.text = [[self.arrPassData objectAtIndex:0] valueForKey:@"Car_Colour"];


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


-(void)showAlert
{
    [self showMessage:@"Check your internet connection"
            withTitle:@"Trucky Ducky"];
}

-(void)checkinternet
{
    BOOL checkInternetbool1=[checkInternet connectedToNetwork];
    
    if (checkInternetbool1 == NO)
    {
        [self showAlert];
        
    }
    else
    {
        
        [SVProgressHUD showWithStatus:@"Loading..."];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
              [self AddCarAPI ];
         });
        
       
    }
}


- (IBAction)actoinBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}






#pragma mark Action Button PickUP Location 



- (IBAction)actionPickupLocation:(id)sender {
    
    strCheck = @"PickupLocation";
    [self autocompleteClicked];
    
   
}


- (IBAction)actionPickupNext:(id)sender {
    

    NSLog(@"%@", strPickUpAddress);

       if ([strPickUpAddress length]==0) {

           [self showMessage:@"Enter Pickup location."
           withTitle:@"Trucky Ducky"];
       }


    if ([self.txfCompanyName.text length] == 0) {

        NSLog(@"Enter Company Name.");

        [self showMessage:@"Enter Company Name."
        withTitle:@"Trucky Ducky"];
    }

    else
    {
        self.vwPickupLocation.hidden = YES;
        self.vwDropOffLocation.hidden = NO;

    }

    
    
   
}

#pragma mark Action Button Drop off Location 



- (IBAction)actionDropoffLocation:(id)sender
{
    
    strCheck = @"DropoffLocation";
    [self autocompleteClicked];
    
}


- (IBAction)actionDropoffNext:(id)sender {
    

    
    
    NSLog(@"%@", strDropoffAddress);

    if ([strDropoffAddress length]==0) {

        [self showMessage:@"Enter Dropoff location."
        withTitle:@"Trucky Ducky"];
    }

    if ([self.txfDropOffCompanyName.text length] == 0)
    {

        NSLog(@"Enter Company Name.");
        [self showMessage:@"Enter Company Name."
        withTitle:@"Trucky Ducky"];
    }
    else
    {
        self.vwPickupLocation.hidden = YES;
        self.vwDropOffLocation.hidden = YES;
        self.vwEnterAmount.hidden = NO;
    }

  
}

- (IBAction)actionDropoffPrevious:(id)sender {
    self.vwDropOffLocation.hidden = YES;
    self.vwPickupLocation.hidden = NO;
    
    
    
   
}


#pragma mark Action Button Enter Amount 



- (IBAction)actionAmountNext:(id)sender {
    
    

    
    
    if (self.txfEnterAmount.text.length > 0)
    {
        NSCharacterSet *nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        if ([self.txfEnterAmount.text rangeOfCharacterFromSet:nonNumbers].location == NSNotFound)
        {
            if ([self.txfEnterAmount.text doubleValue] > 0)
            {
                // Text Field contains a numeric value greater than 0
                NSLog(@"Good number.");

            }

            else
            {
                // If we make it to here, it does not meet your requirements.
                  NSLog(@"Bad Number.");
                [self showMessage:@"Enter Valid Number of Cars you want to transport."
                withTitle:@"Trucky Ducky"];
                return;
            }




            if ([self.txfEnterAmount.text doubleValue] > 3)
            {
                // Text Field contains a numeric value greater than 0
                NSLog(@"BAD number.");


                [self showMessage:@"Maximum 3 car allowed."
                withTitle:@"Trucky Ducky"];
                return;

            }





        }
    }





    if ([self.txfEnterAmount.text length]==0) {
        NSLog(@"Enter Amount");
        [self showMessage:@"Enter Number of Cars you want to transport."
        withTitle:@"Trucky Ducky"];
    }

    else
    {
          NSLog(@"Selected car No is..%@",self.txfEnterAmount.text);
        
        if ([self.txfEnterAmount.text isEqualToString:@"1"]) {
            self.btnCar2.hidden = YES;
            self.btnCar3.hidden = YES;
        }
        
        if ([self.txfEnterAmount.text isEqualToString:@"2"]) {
                   
            
            self.btnCar1.hidden = NO;
            self.btnCar2.hidden = NO;
            self.btnCar3.hidden = YES;
               }
               
        
        if ([self.txfEnterAmount.text isEqualToString:@"3"]) {
            
                   self.btnCar1.hidden = NO;
                   self.btnCar2.hidden = NO;
                   self.btnCar3.hidden = NO;
        }
               
        
          
        
        
           self.vwPickupLocation.hidden = YES;
           self.vwDropOffLocation.hidden = YES;
           self.vwEnterAmount.hidden = YES;
           self.vwCarDetails.hidden = YES;
           self.vwAddCarCount.hidden = NO;
    }




}

- (IBAction)actionAmountPrevious:(id)sender {
    
   self.vwEnterAmount.hidden = YES;
   self.vwPickupLocation.hidden = YES;
   self.vwDropOffLocation.hidden = NO;
    
}



#pragma mark Action Add Car Count 


- (IBAction)actionCar1Clicked:(id)sender{
    
     self.vwPickupLocation.hidden = YES;
     self.vwDropOffLocation.hidden = YES;
     self.vwEnterAmount.hidden = YES;
     self.vwAddCarCount.hidden = YES;
     self.vwCarDetails.hidden = NO;
             
    
}
- (IBAction)actionCar2Clicked:(id)sender
{
    
    self.vwPickupLocation.hidden = YES;
       self.vwDropOffLocation.hidden = YES;
       self.vwEnterAmount.hidden = YES;
       self.vwAddCarCount.hidden = YES;
       self.vwCarDetails.hidden = NO;
    
    
}
- (IBAction)actionCar3Clicked:(id)sender
{
    
    
    self.vwPickupLocation.hidden = YES;
       self.vwDropOffLocation.hidden = YES;
       self.vwEnterAmount.hidden = YES;
       self.vwAddCarCount.hidden = YES;
       self.vwCarDetails.hidden = NO;
    
}


#pragma mark Action Car Add Details 



- (IBAction)actionAddCarRequestDone:(id)sender
{
    
    
    if ([self.txfCarMake.text length]==0)
    {
        NSLog(@"Enter Car Make");
        [self showMessage:@"Enter Car Make."
        withTitle:@"Trucky Ducky"];
    }
    
   else if ([self.txfCarModel.text length]==0)
       {
           NSLog(@"Enter Car Model");
           [self showMessage:@"Enter Car Model."
           withTitle:@"Trucky Ducky"];
       }
    
  else if ([self.txfRegoNo.text length]==0)
       {
           NSLog(@"Enter Car Registration number");
           [self showMessage:@"Enter Car Registration number."
           withTitle:@"Trucky Ducky"];
       }
    
    
   else if ([self.txfCarColor.text length]==0)
       {
           NSLog(@"Enter Car colour");
           [self showMessage:@"Enter Car colour."
                     withTitle:@"Trucky Ducky"];
       }
    
    
   else
   {
       
       
       [self showMessage:@" Call your API Here to Request Car."
       withTitle:@"Trucky Ducky"];
       
       
//       [self GetDistanceinKM];
//
//       [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
//       dispatch_async(dispatch_get_main_queue(), ^{
//        [self performSelector:@selector(checkinternet) withObject:nil afterDelay:0.2];
//       });
//       NSLog(@"Car Request done");
       
   }
    
   
}



- (IBAction)actionDone:(id)sender{
    
    
    
    
     
        if ([self.txfCarMake.text length]==0)
        {
            NSLog(@"Enter Car Make");
            [self showMessage:@"Enter Car Make."
            withTitle:@"Trucky Ducky"];
        }
        
       else if ([self.txfCarModel.text length]==0)
           {
               NSLog(@"Enter Car Model");
               [self showMessage:@"Enter Car Model."
               withTitle:@"Trucky Ducky"];
           }
        
      else if ([self.txfRegoNo.text length]==0)
           {
               NSLog(@"Enter Car Registration number");
               [self showMessage:@"Enter Car Registration number."
               withTitle:@"Trucky Ducky"];
           }
        
        
       else if ([self.txfCarColor.text length]==0)
           {
               NSLog(@"Enter Car colour");
               [self showMessage:@"Enter Car colour."
                         withTitle:@"Trucky Ducky"];
           }
        
        
       else
       {
           
           
            
           self.vwPickupLocation.hidden = YES;
           self.vwDropOffLocation.hidden = YES;
           self.vwEnterAmount.hidden = YES;
           self.vwCarDetails.hidden = YES;
           self.vwAddCarCount.hidden = NO;
           
           
           //Set Car done Checmark Green Here.
           self.imgCar1.hidden = NO;
           
           
           
    //       [self GetDistanceinKM];
    //
    //       [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
    //       dispatch_async(dispatch_get_main_queue(), ^{
    //        [self performSelector:@selector(checkinternet) withObject:nil afterDelay:0.2];
    //       });
    //       NSLog(@"Car Request done");
           
       }
        
    
    
//
//   self.vwPickupLocation.hidden = YES;
//   self.vwDropOffLocation.hidden = YES;
//   self.vwEnterAmount.hidden = YES;
//   self.vwCarDetails.hidden = YES;
//   self.vwAddCarCount.hidden = NO;
       
    
}
- (IBAction)actionClose:(id)sender{
    
              self.vwPickupLocation.hidden = YES;
              self.vwDropOffLocation.hidden = YES;
              self.vwEnterAmount.hidden = YES;
              self.vwCarDetails.hidden = YES;
              self.vwAddCarCount.hidden = NO;
       
    
}




-(void)GetDistanceinKM
{
    CLLocation *Pickuploc = [[CLLocation alloc] initWithLatitude:[strPickup_Lat doubleValue] longitude:[strPickup_Long doubleValue]];

    CLLocation *Dropoffloc = [[CLLocation alloc] initWithLatitude:[strDropoff_Lat doubleValue] longitude:[strDropoff_Long doubleValue]];

    CLLocationDistance distance = [Pickuploc distanceFromLocation:Dropoffloc]/1000;
    strDistanceKM = [NSString stringWithFormat:@"% 0.01f",distance];
}


- (IBAction)actionCarDetailPrevious:(id)sender
{
    self.vwEnterAmount.hidden = NO;
    self.vwPickupLocation.hidden = YES;
    self.vwDropOffLocation.hidden = YES;
    self.vwCarDetails.hidden = YES;
     self.vwAddCarCount.hidden = YES;
   
}





#pragma mark webService Call 
-(void)AddCarAPI
{
    
    NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]AddCar:[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"] :self.txfCarModel.text :self.txfCarMake.text  :self.txfRegoNo.text :self.txfCarColor.text :self.txfEnterAmount.text :strDistanceKM :self.txfCompanyName.text :strPickUpAddress :strPickup_Lat :strPickup_Long:self.txfDropOffCompanyName.text :strDropoffAddress :strDropoff_Lat :strDropoff_Long];
    
    
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
            
           arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
                      strAlert = [arrResponse valueForKey:@"msg"];
                      NSLog(@"%@", strAlert);
         
           
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Trucky Ducky " message:@"Car Added Successfully." preferredStyle:UIAlertControllerStyleAlert];

                                      UIAlertAction *Verification = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                         [self backToHomeScreen];
                                                          }];
                                      
                                      
                                      [alert addAction:Verification];

            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            strAlert = [arrResponse valueForKey:@"msg"];
            NSLog(@"%@", strAlert);
          
                [self showMessage:strAlert
                        withTitle:@"Trucky Ducky"];
   
        }
    }
}

-(void)backToHomeScreen
{
    NSArray *array = [self.navigationController viewControllers];
    NSLog(@"%@",array);
    [self.navigationController popToViewController:[array objectAtIndex:1] animated:NO];
}







- (void)autocompleteClicked {


     _resultsViewController = [[GMSAutocompleteResultsViewController alloc] init];
      _resultsViewController.delegate = self;
    _resultsViewController.tableCellBackgroundColor = [UIColor darkGrayColor];
    _resultsViewController.primaryTextHighlightColor = [UIColor greenColor];
    
      _searchController = [[UISearchController alloc]
                           initWithSearchResultsController:_resultsViewController];
      _searchController.searchResultsUpdater = _resultsViewController;

      // Put the search bar in the navigation bar.
      [_searchController.searchBar sizeToFit];
      self.navigationItem.titleView = _searchController.searchBar;

      // When UISearchController presents the results view, present it in
      // this view controller, not one further up the chain.
        self.definesPresentationContext = YES;

      // Prevent the navigation bar from being hidden when searching.
      _searchController.hidesNavigationBarDuringPresentation = NO;

       [self presentViewController:_searchController animated:YES completion:nil];

}




// Handle the user's selection.
- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
  didAutocompleteWithPlace:(GMSPlace *)place {

    [self dismissViewControllerAnimated:YES completion:nil];

    _searchController.active = NO;

    
    
    if ([strCheck isEqualToString:@"PickupLocation"])
    {
        strPickUpAddress = [NSString stringWithFormat:@"%@ , %@",place.name,place.formattedAddress];
        
        self->strPickup_Lat = [NSString stringWithFormat:@"%f", place.coordinate.latitude];
        self->strPickup_Long = [NSString stringWithFormat:@"%f", place.coordinate.longitude];
        
        [self.btnPickupLocation setTitle:strPickUpAddress forState:UIControlStateNormal];
        
      
    }
    
    else
    {
        
        strDropoffAddress = [NSString stringWithFormat:@"%@ , %@",place.name,place.formattedAddress];
        
        self->strDropoff_Lat = [NSString stringWithFormat:@"%f", place.coordinate.latitude];
        self->strDropoff_Long = [NSString stringWithFormat:@"%f", place.coordinate.longitude];
        [self.btnDropOffLocation setTitle:strDropoffAddress forState:UIControlStateNormal];
    }
    
    
  
}


- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
didFailAutocompleteWithError:(NSError *)error {
  [self dismissViewControllerAnimated:YES completion:nil];
  // TODO: handle the error.
  NSLog(@"Error: %@", [error description]);
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictionsForResultsController:
    (GMSAutocompleteResultsViewController *)resultsController {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictionsForResultsController:
    (GMSAutocompleteResultsViewController *)resultsController {
  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}




@end
