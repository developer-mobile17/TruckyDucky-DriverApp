//
//  NewTabDetailinfoVC.m
//  TruckyDucky
//
//  Created by anil kumar on 07/02/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import "NewTabDetailinfoVC.h"
#import "NewJobDetailCell.h"
#import <CoreLocation/CoreLocation.h>


#import "SVProgressHUD.h"
#import "webServicesSingulton.h"
#import "checkInternet.h"

@interface NewTabDetailinfoVC ()
{

    NSArray *arrResponse;
    NSString *strStatus;
    NSString *strListing_Id;
    NSString *strDriver_Id;
    NSString *strCustomer_Name;
    NSString *strISStop;
}

@end

@implementation NewTabDetailinfoVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   // NSLog(@"%@", _arrActivitysPass);
    [self.objTbl setBackgroundColor:[UIColor whiteColor]];
  
    [self checkinternet];
    
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDarkContent;
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
        [self calledGetCarsRequest];
       
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
-(void)calledGetCarsRequest
{

   
    NSArray *arrLogin = [[webServicesSingulton sharedManager]GetCarsRequest:[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"]];
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
            
           
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"CarsRequest"];
            
          
            
            [self.objTbl reloadData];
            

        }
        else
        {
            
           
           
        }
        
//
//
//           // arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
//            [self.objTbl reloadData];
//            strAlert = [arrResponse valueForKey:@"msg"];
//            arrNewBooking = nil;
//            NSLog(@"%@", strAlert);
//             [self.objTbl reloadData];
          
          //      [self showMessage:@"No current carrys pending."
            //            withTitle:@"Trucky Ducky"];
           //
        }
    }







- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark: UITableView 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  [arrResponse count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"NewJobDetailCell";
    NewJobDetailCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[NewJobDetailCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:MyIdentifier] ;
    }
    

    cell.lblDriverName.text = [[[arrResponse objectAtIndex:indexPath.row]valueForKey:@"Driver_Info"]valueForKey:@"Full_Name"];
    cell.lblPrice.text = [NSString stringWithFormat:@"$ %@",[[arrResponse objectAtIndex:indexPath.row]valueForKey:@"Bid_Price"]];
    
    strISStop = [[arrResponse objectAtIndex:indexPath.row]valueForKey:@"IsStop"];
    
    
    if (strISStop == nil || strISStop == (id)[NSNull null])
     {
         cell.lblComingNow.text = @"0 Stop";
    }
    
     
   else if ([strISStop isEqualToString:@"NO"])
    {
        cell.lblComingNow.text = @"0 Stop";
    }
    
    else
    {
       cell.lblComingNow.text = @"1 Stop";
    }
    
    
    cell.lblDistance.text = [NSString stringWithFormat:@"%@km",[[[arrResponse objectAtIndex:indexPath.row]valueForKey:@"Job_Info"]valueForKey:@"Distance"]];
    //[[self.arrActivitysPass objectAtIndex:indexPath.row]valueForKey:@"Distance"];
    
   
    
    
    
    
    cell.btnAccept.tag = indexPath.row;
    
    [cell.btnAccept addTarget:self action:@selector(btnAcceptClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    cell.btnAccept.layer.cornerRadius = 15;
    cell.lblDistance.layer.cornerRadius = 15;
    cell.lblDistance.clipsToBounds = YES;
    cell.lblComingNow.layer.cornerRadius = 15;
    cell.lblComingNow.clipsToBounds = YES;
    return cell;
    
    
    
}



-(void)btnAcceptClicked: (UIButton *)sender
{
    strStatus = @"Accepted";
    strListing_Id = [[arrResponse valueForKey:@"Listing_Id"]objectAtIndex:sender.tag];
    strDriver_Id = [[arrResponse valueForKey:@"Driver_Id"]objectAtIndex:sender.tag];
   
    
    [self AcceptDriverRequest];
   
}



#pragma mark webService Call 
-(void)AcceptDriverRequest
{
    
    NSString *strAlert;
    
    NSArray *arrLogin = [[webServicesSingulton sharedManager]Booking: strListing_Id :strStatus :strDriver_Id :[[NSUserDefaults standardUserDefaults]valueForKey:@"Full_NamePass"]];
    

    
    
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
            
           arrResponse = [arrLogin objectAtIndex:0];
                      strAlert = [arrResponse valueForKey:@"msg"];
                      NSLog(@"%@", strAlert);
         
           
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Trucky Ducky " message:strAlert preferredStyle:UIAlertControllerStyleAlert];

                                      UIAlertAction *Verification = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                         [self MovetoHomeScreen];
                                                          }];
                                      
                                      
                                      [alert addAction:Verification];

            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            arrResponse = [arrLogin objectAtIndex:0];
            strAlert = [arrResponse valueForKey:@"msg"];
            NSLog(@"%@", strAlert);
          
                [self showMessage:strAlert
                        withTitle:@"Trucky Ducky"];
   
        }
    }
}


-(void)MovetoHomeScreen
{
    [self.navigationController popViewControllerAnimated:YES];
}



     

@end
