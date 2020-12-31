//
//  JobConfirmationByCustomerVC.m
//  TruckyDucky
//
//  Created by anil kumar on 11/02/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import "JobConfirmationByCustomerVC.h"
#import "JobConfirmationCell.h"
#import "jobConfirmationDetailsVc.h"


#import "SVProgressHUD.h"
#import "webServicesSingulton.h"
#import "checkInternet.h"

@interface JobConfirmationByCustomerVC ()
{
    NSArray *arrResponse;
    NSMutableArray *arrAcceptedData;
    NSMutableArray *arrDriverinFOdData;
    NSMutableArray *arrJobinFOData;
    
    
    NSArray *arrCar_Bids_Request;
    NSArray *arrcar_Request;
    NSArray *arrSegmenttbleData;
    NSDictionary*tempjobinfo;
    NSDictionary*tempDriverinfo;
    NSString *StrListingID;
    NSString *strDriverID;
    NSString *BtnSelect;
    
    
    NSArray *arrConfirmData;
//    NSMutableArray *arrSegmenttbleData;
    
   
    NSString *strUserID;
    NSString *strCheckBIDPrice;
    NSString *strBIDPrice;
    NSString *strCompanyID;
    NSString *chkhidebute;
}

@end

@implementation JobConfirmationByCustomerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrConfirmData = [[NSArray alloc]initWithObjects:@"jflkasjfasfja",@"jflkasjfasfja", nil];
    
    
    tempjobinfo = [[NSDictionary alloc] init];
    tempDriverinfo = [[NSDictionary alloc] init];
    
    
    arrAcceptedData = [[NSMutableArray alloc]init];
    arrJobinFOData = [[NSMutableArray alloc]init];
    arrDriverinFOdData = [[NSMutableArray alloc]init];
    
    
    CGRect frame= self.objsegment.frame;
    [self.objsegment setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 40)];
    [self.objTbl setBackgroundColor:[UIColor whiteColor]];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateSelected];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    
    
    self.objsegment.layer.borderWidth = 1;
    self.objsegment.layer.borderColor = [[UIColor blackColor]CGColor];
    
    
    [self checkinternet];
    
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
     [self GetCarsRequestWebService];
       
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDarkContent;
}


-(void)viewWillAppear:(BOOL)animated{
    

     [SVProgressHUD showWithStatus:@"Loading..."];
             dispatch_async(dispatch_get_main_queue(), ^{

                [self checkinternet];
             });
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
-(void)GetCarsRequestWebService
{

    NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]jobConfirmationListing:[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"]];
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
            arrCar_Bids_Request = [arrResponse valueForKey:@"Confirmed"];
            arrcar_Request = [arrResponse valueForKey:@"Tender"];
            
            
             arrSegmenttbleData = arrCar_Bids_Request;
            
            if (self.objsegment.selectedSegmentIndex == 0){
                   
                strCheckBIDPrice = @"NO";
                arrSegmenttbleData = arrcar_Request;
                   [self.objTbl reloadData];
               
                          
               }
               else if(self.objsegment.selectedSegmentIndex == 1) {
                   
                   
                   strCheckBIDPrice = @"YES";
                   arrSegmenttbleData =   arrCar_Bids_Request;
                   [self.objTbl reloadData];
                   
               }
            
            

           
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


#pragma mark: UITableView 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arrSegmenttbleData count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"JobConfirmationCell";
    JobConfirmationCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[JobConfirmationCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:MyIdentifier] ;
    }
    
    
    
     [cell setBackgroundColor:[UIColor whiteColor]];
    
    
    
    
    NSLog(@"Selected Array is....%@",arrSegmenttbleData);
    
    
    tempjobinfo = [[arrSegmenttbleData objectAtIndex:indexPath.row]valueForKey:@"Job_Info"];
    tempDriverinfo = [[arrSegmenttbleData objectAtIndex:indexPath.row]valueForKey:@"Driver_Info"];
   
    
    cell.lblHeaderTitle.text = [tempjobinfo valueForKey:@"Title"];
    
    if ([chkhidebute isEqualToString:@"show"])
    {
                   cell.btnConfirm.hidden = NO;
                   cell.btnReject.hidden = NO;
    }
    else  if ([chkhidebute isEqualToString:@"no"])
    {
        cell.btnConfirm.hidden = YES;
        cell.btnReject.hidden = YES;
    }
    
    
   
    
    
    NSString *strCheckStatus;
    strCheckStatus = [[arrSegmenttbleData  valueForKey:@"Status"]objectAtIndex:indexPath.row];
    if ([strCheckStatus isEqualToString:@"Bid"]) {
        
        strBIDPrice = [[arrSegmenttbleData  valueForKey:@"Bid_Price"]objectAtIndex:indexPath.row];
         cell.lblPrice.text = [NSString stringWithFormat:@"$%@",strBIDPrice] ;
         cell.lblBIDPrice.text = @"BID Price";
        
        // bid //
        
    }
    
    else{
        NSString *strPrice = [tempjobinfo  valueForKey:@"Price"];
           cell.lblPrice.text = [NSString stringWithFormat:@"$%@",strPrice] ;
           cell.lblBIDPrice.text = @"Price";

    }
    
    
    
    NSString *strDrivertruck = [tempDriverinfo valueForKey:@"Truck_Name"];
    NSString *strDrivertruckRego = [tempDriverinfo valueForKey:@"Truck_Number"];
    
    
    
    cell.lblPickupAddress.text =         [tempjobinfo valueForKey:@"Sender_Address"];
    cell.lblPickDate.text =              [tempjobinfo valueForKey:@"Pickup_Date"];
    cell.lblPickupWindow.text =          [tempjobinfo valueForKey:@"Pickup_Time"];
    
    cell.lblDriverName.text =            [tempDriverinfo valueForKey:@"Full_Name"];
    
    cell.lblDriverLocation.text =    [NSString stringWithFormat:@"%@ - %@",strDrivertruck,strDrivertruckRego];    //[tempDriverinfo valueForKey:@"Email"];
    
    cell.lblPhoneNumber.text =          [tempDriverinfo valueForKey:@"Mobile"];
    
    
//
//
    
    
    cell.btnConfirm.layer.cornerRadius = 5;
    cell.btnReject.layer.cornerRadius = 5;
    
    
    // Custome Button for ACCPET|| REJECT || RIGHT ARROW
       
       cell.btnConfirm.tag = indexPath.row;
       cell.btnReject.tag = indexPath.row;
       cell.btnDetailInfo.tag = indexPath.row;
      
       
       
       
       [cell.btnConfirm addTarget:self action:@selector(btnConfirmClicked:) forControlEvents:UIControlEventTouchUpInside];
       
       [cell.btnReject addTarget:self action:@selector(btnRejectClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
     [cell.btnDetailInfo addTarget:self action:@selector(btnDetailInfo:) forControlEvents:UIControlEventTouchUpInside];
       
    
    
    
    
    cell.bckView.layer.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.2].CGColor;
    cell.bckView.layer.shadowOffset = CGSizeMake(3.0, 3.0);
    cell.bckView.layer.shadowOpacity = 17.0;
    cell.bckView.layer.shadowRadius = 7.0;

   
    return cell;
}







-(void)btnConfirmClicked: (UIButton *)sender

{
    BtnSelect = @"Accepted";
    NSLog(@"Job  is %@",BtnSelect);
    
   StrListingID = [[arrSegmenttbleData  valueForKey:@"Listing_Id"]objectAtIndex:sender.tag];
   NSLog(@" The Listing is...%@",StrListingID);
    
    
    strDriverID = [[arrSegmenttbleData  valueForKey:@"Driver_Id"]objectAtIndex:sender.tag];
    NSLog(@" The Driver ID is...%@",strDriverID);
    
    
    
    strCompanyID = [[arrSegmenttbleData  valueForKey:@"Company_Id"]objectAtIndex:sender.tag];
    NSLog(@"The Company ID is... %@",strCompanyID);
    
    
    [self calledCustomerJOBConfirmation];

    
}


-(void)btnRejectClicked: (UIButton *)sender

{
     BtnSelect = @"Rejected";
    NSLog(@"Job is %@",BtnSelect);
    
    
    
    
    StrListingID = [[arrResponse  valueForKey:@"Listing_Id"]objectAtIndex:sender.tag];
    NSLog(@" The Listing is...%@",StrListingID);
     
     
     strDriverID = [[arrResponse  valueForKey:@"Driver_Id"]objectAtIndex:sender.tag];
     NSLog(@" The Driver ID is...%@",strDriverID);
     
     
     [self calledCustomerJOBConfirmation];
    

       
}


-(void)btnDetailInfo: (UIButton *)sender
{
    NSMutableArray *arrTmpToSend = [[NSMutableArray alloc]init];
       
    arrTmpToSend = [arrSegmenttbleData objectAtIndex:sender.tag];
    
    jobConfirmationDetailsVc *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"jobConfirmationDetailsVc"];
    
     Login.self.arrJobDetailsPass = arrTmpToSend;
    
    [self.navigationController pushViewController:Login animated:YES];
}

#pragma mark webService Call 
-(void)calledCustomerJOBConfirmation
{

    
    
    if (strCompanyID == nil || strCompanyID == (id)[NSNull null]) {
         // nil branch
           
        strCompanyID = @"null";
    }
       
    NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]CustomerJOBConfirmation:StrListingID :BtnSelect :strDriverID :strBIDPrice :[[NSUserDefaults standardUserDefaults]valueForKey:@"Full_NamePass"]:strCompanyID];
    NSLog(@"Data is %@",arrLogin);
        
//    [self hideloader];
    
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
                            
            // After Customer Confirmation List will be refresh ...
            
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Trucky Ducky " message:@"You've Confirmed the Driver Request..." preferredStyle:UIAlertControllerStyleAlert];

                                      UIAlertAction *Verification = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                         [self GetCarsRequestWebService];
                                                          }];
                                      
                                      
                                      [alert addAction:Verification];

            [self presentViewController:alert animated:YES completion:nil];
            
            
            
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)actoinBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)actionSegment:(id)sender {

    if (self.objsegment.selectedSegmentIndex == 0){
        
        strCheckBIDPrice = @"NO";
      arrSegmenttbleData = arrcar_Request;
        chkhidebute = @"show";
        [self.objTbl reloadData];
    
               
    }
    else if(self.objsegment.selectedSegmentIndex == 1) {
    
        strCheckBIDPrice = @"YES";
        arrSegmenttbleData =   arrCar_Bids_Request;
        chkhidebute = @"no";
        [self.objTbl reloadData];
        
    }
}

@end
