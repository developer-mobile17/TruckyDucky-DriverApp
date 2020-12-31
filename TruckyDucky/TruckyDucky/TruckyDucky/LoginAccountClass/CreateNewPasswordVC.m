//
//  CreateNewPasswordVC.m
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "CreateNewPasswordVC.h"
#import "ResetPasswordVC.h"
#import "LoginVC.h"
#import "webServicesSingulton.h"


@interface CreateNewPasswordVC ()
{
    NSArray *arrResponse;
    NSString *strEmailID;
}

@end

@implementation CreateNewPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    strEmailID=[[NSUserDefaults standardUserDefaults]valueForKey:@"EmailPASS"];
    NSLog(@"%@", strEmailID);
    
     self.btnSubmit.layer.cornerRadius = 5;

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
-(void)calledCreateNWPasswordWebService
{

    NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]CreateNewAccount:strEmailID :self.txfOTP.text :self.txfNewPassword.text];
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
            
            
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            NSString *strOTPCODE = [arrResponse valueForKey:@"Validation_Code"];
            

            [[NSUserDefaults standardUserDefaults] setObject:strOTPCODE forKey:@"OTPCODEPASS"];
                   [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            NSLog(@"The Code is..%@",strOTPCODE);
            strAlert = [arrResponse valueForKey:@"msg"];
            
                  
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Trucky Ducky OTP " message:strAlert preferredStyle:UIAlertControllerStyleActionSheet];

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
          
                [self showMessage:strAlert
                        withTitle:@"Trucky Ducky"];
                
           
        }
    }
}

-(void)NextClass
{
     LoginVC *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
     [self.navigationController pushViewController:Login animated:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)actionSubmit:(id)sender {
    [self calledCreateNWPasswordWebService];
   
}
@end
