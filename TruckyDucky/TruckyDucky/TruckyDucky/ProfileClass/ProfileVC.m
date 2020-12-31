//
//  ProfileVC.m
//  TruckyDucky
//
//  Created by anil kumar on 16/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ProfileVC.h"
#import "editProfieVc.h"
#import "SVProgressHUD.h"
#import "webServicesSingulton.h"


@interface ProfileVC ()<UIScrollViewDelegate>

@end

@implementation ProfileVC
{
    NSArray *arrResponse;
    NSString *strUserID;
    NSString *strBaseURL;
    
    
    
    
    NSString *strLoginAsCheck;
    NSString *strCheckCompID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    strBaseURL=[[NSUserDefaults standardUserDefaults]valueForKey:@"BaseURLPass"];
    NSLog(@" UserID of Logged in User is..%@", strBaseURL);


    strUserID=[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"];
    NSLog(@" UserID of Logged in User is..%@", strUserID);
    
    
    
   // self.objScroll.contentSize = CGSizeMake(self.objScroll.frame.size.width, 1000);
    self.imgCurrentRating.layer.cornerRadius = self.imgCurrentRating.frame.size.height/2;
    
    self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.height/2;
    self.imgProfile.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.imgProfile.layer.borderWidth = 4;
    
 
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                
                 
                 [self GetUserInfoWebService];
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
-(void)GetUserInfoWebService
{
    NSString *strKey =@"User_Id" ;
    NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]GetUserInfo:strKey :strUserID];
   // NSLog(@"Data is %@",arrLogin);
    
    
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
           // arrTemp = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            arrResponse = [[arrLogin  objectAtIndex:0]valueForKey:@"UserInfo"];
            
            self.lblDriverName.text = [arrResponse  valueForKey:@"Full_Name"];
            self.txtPhoneNumber.text = [arrResponse  valueForKey:@"Mobile"];
            self.txtEmail.text = [arrResponse  valueForKey:@"Email"];
           // self.txfAddress.text = [arrResponse  valueForKey:@"Address"];
            
            
//            NSString *strUserDesc =  [arrResponse  valueForKey:@"User_Description"];
//            
//            if (strUserDesc == nil || strUserDesc == (id)[NSNull null])
//            {
//                  self.txvDesciption.text = @"NO DATA";
//             }
//            else {
//              self.txvDesciption.text = [arrResponse  valueForKey:@"User_Description"];
//            }
            
            NSString *strImgKey = [arrResponse  valueForKey:@"Profile_Image"];
                
            if (strImgKey == nil || strImgKey == (id)[NSNull null]) {
                  // nil branch
                } else {
                  
                    NSString *imgProfileURL = [strBaseURL stringByAppendingString:strImgKey];
                    NSURL *url = [NSURL URLWithString:imgProfileURL];

                    NSData *data = [NSData dataWithContentsOfURL:url];
                    UIImage *image = [UIImage imageWithData:data];

                    [self.imgProfile setImage:image];
                    
                    
                    [[NSUserDefaults standardUserDefaults] setObject:imgProfileURL forKey:@"ProfileImgPASS"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    
                }
                
              
                
                NSString *strTruckName = [arrResponse  valueForKey:@"Truck_Name"];
                if (strTruckName == nil || strTruckName == (id)[NSNull null])
                {
                        
                    self.txtTruckName.text = @"NO DATA";
                    
                 }
                else {
                    self.txtTruckName.text = [arrResponse  valueForKey:@"Truck_Name"];
                         
                }
                
                
                
                NSString *strTruckType =  [arrResponse  valueForKey:@"Truck_Make"];
                
                if (strTruckType == nil || strTruckType == (id)[NSNull null])
                {
                      self.txtTruckType.text = @"NO DATA";
                 }
                else {
                  self.txtTruckType.text = [arrResponse  valueForKey:@"Truck_Make"];
                }
                
            
            NSString *strTruckLoad =  [arrResponse  valueForKey:@"Truck_Load"];
            
            if (strTruckLoad == nil || strTruckLoad == (id)[NSNull null])
            {
                  self.txtTruckLoad.text = @"NO DATA";
             }
            else {
              self.txtTruckLoad.text = [arrResponse  valueForKey:@"Truck_Load"];
            }
                
                
                
                
                
                NSString *strTruckNumber = [arrResponse  valueForKey:@"Truck_Number"];
                
                if (strTruckNumber == nil || strTruckNumber == (id)[NSNull null])
                {
                      self.txtTruckNumber.text = @"NO DATA";
                 }
                else
                {
                     self.txtTruckNumber.text = [arrResponse  valueForKey:@"Truck_Number"];
                }
                
                
                NSString *strTruckDesc = [arrResponse  valueForKey:@"Truck_Color"];
                
                
                if (strTruckDesc == nil || strTruckDesc == (id)[NSNull null]){
                           self.txvTruckDesc.text = @"NO DATA";
                 }
                else {
                    self.txvTruckDesc.text = [arrResponse  valueForKey:@"Truck_Color"];
                }
            }
        else{
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            strAlert = [arrResponse valueForKey:@"msg"];
            NSLog(@"%@", strAlert);
          
                [self showMessage:strAlert
                        withTitle:@"Trucky Ducky"];
        }
    }
}



- (IBAction)actoinBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (IBAction)actionEditButtonClicked:(id)sender {
        editProfieVc *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"editProfieVc"];
                     [self.navigationController pushViewController:Login animated:NO];
}






@end
