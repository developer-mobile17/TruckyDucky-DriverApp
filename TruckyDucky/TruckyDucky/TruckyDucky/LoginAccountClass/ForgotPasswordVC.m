//
//  ForgotPasswordVC.m
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ForgotPasswordVC.h"
#import "CreateNewPasswordVC.h"

#import "SVProgressHUD.h"
#import "webServicesSingulton.h"
@interface ForgotPasswordVC ()
{
    NSArray *arrResponse;
}

@end

@implementation ForgotPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.btnSend.layer.cornerRadius = 5;
    
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
-(void)calledForgotPasswordWebService
{

    NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]ForgotPassword:@"prachi@yopmail.com"];
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
            
            
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            
            NSString *strOTPCODE = [arrResponse valueForKey:@"Validation_Code"];
            NSString *code = [NSString stringWithFormat:@"%@",strOTPCODE];

            [[NSUserDefaults standardUserDefaults] setObject:self.txfEmail.text forKey:@"EmailPASS"];
                   [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            NSLog(@"The Code is..%@",code);

            
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Trucky Ducky OTP" message:code preferredStyle:UIAlertControllerStyleActionSheet];

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
    CreateNewPasswordVC *home = [self.storyboard instantiateViewControllerWithIdentifier:@"CreateNewPasswordVC"];
    [self.navigationController pushViewController:home animated:YES];
    
}


- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionSend:(id)sender {
    
    
    if ([self.txfEmail.text length]== 0)
        {
           [self showMessage:@"Please Enter Your  Registered Email"
                   withTitle:@"Trucky Ducky"];
        }
       
       
          else
          {
          
          [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
          dispatch_async(dispatch_get_main_queue(), ^{
              
             
              
             [self calledForgotPasswordWebService];
          });
          }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
