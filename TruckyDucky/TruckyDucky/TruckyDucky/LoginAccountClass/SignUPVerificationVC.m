//
//  SignUPVerificationVC.m
//  TruckyDucky
//
//  Created by anil kumar on 23/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "SignUPVerificationVC.h"
#import "MainTabVC.h"


#import "LoginVC.h"
#import "webServicesSingulton.h"
#import "checkInternet.h"
#import "SVProgressHUD.h"

@interface SignUPVerificationVC ()
{
    NSArray *arrResponse;
    NSString *strMobile ;
}

@end

@implementation SignUPVerificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.btnSubmit.layer.cornerRadius = 5;
    

    [self setNeedsStatusBarAppearanceUpdate];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDarkContent;
}



-(void)checkinternet{
    BOOL checkInternetbool1=[checkInternet connectedToNetwork];
    
    if (checkInternetbool1 == NO)
    {
        [self showAlert];
    }
    else
    {
        // [self loaderback];
       // [self performSelectorInBackground:@selector(loaderback) withObject:nil];
        [self CalledAccountVerify];
        // [self performSelectorInBackground:@selector(calledLoginWebService) withObject:nil];
    }
}
-(void)loaderback
{
   // [SVProgressHUD show];
}
-(void)hideloader
{
    //[SVProgressHUD dismiss];
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
-(void)CalledAccountVerify
{
    
    strMobile=[[NSUserDefaults standardUserDefaults]valueForKey:@"PassMobileNumber"];
       NSLog(@"%@", strMobile);
    NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]VerifyNewAccount:strMobile :self.txfOTP.text];
    NSLog(@"Data is %@",arrLogin);
    
    
//    [self hideloader];
    if (arrLogin.count==0)
    {
       
            
            [self showMessage:@"Server is busy. Please wait."
                    withTitle:@"Trucky Ducky"];
       
    }
    else{
        
        if ([[[arrLogin objectAtIndex:0] valueForKey:@"status"] isEqualToString:@"success"]){
            

            arrResponse = [[arrLogin valueForKey:@"response"] objectAtIndex:0];
            strAlert = [arrResponse valueForKey:@"msg"];

            
            
            MainTabVC *home = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabVC"];
            [self.navigationController pushViewController:home animated:YES];

        }
        else
        {
            strAlert = [arrResponse valueForKey:@"msg"];
            //
          
                [self showMessage:strAlert
                        withTitle:@"Trucky Ducky"];
                
           
        }
    }
}




- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionSubmit:(id)sender {
    [self checkinternet];
}

@end
