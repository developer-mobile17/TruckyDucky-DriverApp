//
//  ResetPasswordVC.m
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ResetPasswordVC.h"
#import "webServicesSingulton.h"
@interface ResetPasswordVC ()
{
    NSArray *arrResponse;
    NSString *strUserID;
}

@end

@implementation ResetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnSubmit.layer.cornerRadius = 5;
    strUserID=[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"];
    NSLog(@" UserID of Logged in User is..%@", strUserID);
    
    

    [self setNeedsStatusBarAppearanceUpdate];
}



- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDarkContent;
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
-(void)calledResetYourPasswordWebService
{

    NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]ResetYourPassword:strUserID :self.txfCurrentPassword.text :self.txfNewPassword.text];
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
            
            
            arrResponse = [arrLogin objectAtIndex:0];
            strAlert = [arrResponse valueForKey:@"msg"];
            
                  [self showMessage:strAlert
                          withTitle:@"Trucky Ducky"];

        }
        else
        {
            arrResponse = [arrLogin objectAtIndex:0];
            strAlert = [arrResponse valueForKey:@"msg"];
          
                [self showMessage:strAlert
                        withTitle:@"Trucky Ducky"];
                
           
        }
    }
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)actionSubmit:(id)sender {
    
    
    if ([self.txfCurrentPassword.text length]== 0)
    {
       [self showMessage:@"Please Enter Your  Current Password"
               withTitle:@"Trucky Ducky"];
    }
    else if ([self.txfNewPassword.text length]==0)
    {
        [self showMessage:@"Please Enter Your  New Password"
        withTitle:@"Trucky Ducky"];
    }
    
    else {
        [self calledResetYourPasswordWebService];
    }
    
    
}
@end
