//
//  SignUPVC.m
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "SignUPVC.h"
#import "SignUPVerificationVC.h"


#import "webServicesSingulton.h"
#import "checkInternet.h"
#import "SVProgressHUD.h"

@interface SignUPVC ()
{
    NSString *strRole;
    NSArray *arrResponse;
}

@end

@implementation SignUPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    CGRect frame= self.objsegment.frame;
    [self.objsegment setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 40)];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
    
    
    self.objsegment.layer.borderWidth = 1;
    self.objsegment.layer.borderColor = [[UIColor blackColor]CGColor];
    self.btnCreateAccount.layer.cornerRadius = 5;
    
    self.objScroll.contentSize = CGSizeMake(self.objScroll.frame.size.width, 1100);
    
    
    strRole = @"Company";
    // strRole = @"Driver";
    
    [self setNeedsStatusBarAppearanceUpdate];
}




- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDarkContent;
}




-(void)checkinternet
{
    BOOL checkInternetbool1=[checkInternet connectedToNetwork];
    //NSLog(@"%hhd",checkInternetbool1);
    if (checkInternetbool1 == NO)
    {
        [self showAlert];
    }
    else
    {
         [self loaderback];
       
        [self calledCreateAccouuntWebService];
       
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



#pragma Mark -  UISegment Controll 
- (IBAction)actionSegment:(id)sender {

    if (self.objsegment.selectedSegmentIndex == 0){
        
        strRole = @"Company";
        NSLog(@"Login as a %@ ",strRole);
    
               
    }
    else if(self.objsegment.selectedSegmentIndex == 1) {
        
        strRole = @"Driver";
        NSLog(@"Login as a %@ ",strRole);
        
        
        
    }
}



#pragma mark webService Call 
-(void)calledCreateAccouuntWebService
{
    
    NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]signup:self.txfYourname.text :self.txfEmail.text :self.txfPhoneNumber.text :self.txfPassword.text :@"Customer" :[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token"]];
    NSLog(@"Data is %@",arrLogin);
    
    
    [self hideloader];
    if (arrLogin.count==0)
    {
       
            
            [self showMessage:@"Server is busy. Please wait."
                    withTitle:@"Trucky Ducky"];
       
    }
    else
    {
        
        if ([[[arrLogin objectAtIndex:0] valueForKey:@"status"] isEqualToString:@"success"])
        {
           
           
            
            arrResponse = [[[arrLogin valueForKey:@"response"] objectAtIndex:0]valueForKey:@"sms_response"];
            
         
            
            [[NSUserDefaults standardUserDefaults] setObject:self.txfPhoneNumber.text forKey:@"PassMobileNumber"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
             strAlert = [arrResponse valueForKey:@"text"];
        
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Trucky Ducky" message:strAlert preferredStyle:UIAlertControllerStyleActionSheet];

                UIAlertAction *Verification = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self NextClass];
                       
                }];
                
                
               
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
                
                [alert addAction:cancel];
                [alert addAction:Verification];
               
                
                [self presentViewController:alert animated:YES completion:nil];
            

        }
        else
        {
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
                      
                       strAlert = [arrResponse valueForKey:@"msg"];
                     
                       NSLog(@"%@", strAlert);
            
//
//            strAlert = [arrLogin valueForKey:@"response"];
          
                [self showMessage:strAlert
                        withTitle:@"Trucky Ducky"];
                
           
        }
    }
}



-(void)NextClass {
    SignUPVerificationVC *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUPVerificationVC"];
    [self.navigationController pushViewController:Login animated:YES];
    
}




- (IBAction)actionCreateAccount:(id)sender {
   if ([self.txfYourname.text length]== 0)
     {
        [self showMessage:@"Please Enter Name"
                withTitle:@"Trucky Ducky"];
     }
    
    
    
//    else if ([self.txfEmail.text length]== 0)
//        {
//           [self showMessage:@"Please Enter Your Email"
//                   withTitle:@"Trucky Ducky"];
//        }
//
//
//
//    else if ([self.txfPhoneNumber.text length]== 0)
//           {
//              [self showMessage:@"Please Enter Your PhoneNumber"
//                      withTitle:@"Trucky Ducky"];
//           }
//
//
//
//
    else if ([self.txfPassword.text length]== 0)
           {
              [self showMessage:@"Please Enter Your Password"
                      withTitle:@"Trucky Ducky"];
           }



    else if ([self.txfConfirmPassword.text length]== 0)
              {
                 [self showMessage:@"Please Enter Confirm Password"
                         withTitle:@"Trucky Ducky"];
              }

 

    else if (![self.txfPassword.text isEqualToString:self.txfConfirmPassword.text])
                 {
                    [self showMessage:@"Your Password & Confirm Password Doesn't Match"
                            withTitle:@"Trucky Ducky"];
                 }
             
       
    
    
    
    
       else
       {
       
       [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
       dispatch_async(dispatch_get_main_queue(), ^{
           
          
           
           [self checkinternet];
       });
       }
    
    
    
}

- (IBAction)actionSignIN:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
