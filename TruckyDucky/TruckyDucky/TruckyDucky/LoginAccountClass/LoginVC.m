//
//  LoginVC.m
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "LoginVC.h"
#import "SignUPVC.h"
#import "ForgotPasswordVC.h"
#import "MainTabVC.h"
#import "webServicesSingulton.h"
#import "checkInternet.h"
#import "SVProgressHUD.h"

@interface LoginVC ()
{
    NSArray *arrResponse;
    NSArray *arrUserInfo;
    NSString *strRole_Type;
}

@end

@implementation LoginVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    self.objsegment.hidden = true;
    
    CGRect frame= self.objsegment.frame;
    [self.objsegment setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 40)];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
    
    
    self.objsegment.layer.borderWidth = 1;
    self.objsegment.layer.borderColor = [[UIColor blackColor]CGColor];
    self.btnLogin.layer.cornerRadius = 5;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    
    
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
        [self hideloader];
        [self showAlert];
        
    }
    else
    {
         [self loaderback];
       
        [self calledLoginWebService];
       
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



- (IBAction)actionLogin:(id)sender {
    
    
    
    if ([self.txfEmail.text length]== 0)
     {
        [self showMessage:@"Please Enter Your Email"
                withTitle:@"Trucky Ducky"];
     }
    
    
    
    else if ([self.txfPassword.text length]== 0)
        {
           [self showMessage:@"Please Enter Your Password"
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


- (IBAction)actionSignUP:(id)sender {
    
    [self ShowSignupAlert];
}


-(void)ShowSignupAlert
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"\n\n\n\n\n" preferredStyle:UIAlertControllerStyleAlert];
    
    NSString *myString = @"Please go to www.truckyducky.com to register as a Commercial Car Transport Operator";

    //Create mutable string from original one
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:myString];

    NSRange range = [myString rangeOfString:@"www.truckyducky.com"];
    if (@available(iOS 13.0, *)) {
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor linkColor] range:range];
    } else {
        // Fallback on earlier versions
    }

    
    [alert setValue:attString forKey:@"attributedMessage"];
    
   UIAlertAction *Verification = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                      
         [self GotoSignupURL];
                          
                   }];
        
          
          [alert addAction:Verification];
          [self presentViewController:alert animated:YES completion:nil];
                  
}


-(void)GotoSignupURL
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://apple.com"] options:@{} completionHandler:nil];
}


- (IBAction)actionForgotPassword:(id)sender {
    ForgotPasswordVC *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordVC"];
    [self.navigationController pushViewController:Login animated:YES];
}

#pragma Mark -  UISegment Controll 
- (IBAction)actionSegment:(id)sender {

    if (self.objsegment.selectedSegmentIndex == 0){
        
        strRole_Type = @"Company";
        NSLog(@"Login as a %@ ",strRole_Type);
        
    
               
    }
    else if(self.objsegment.selectedSegmentIndex == 1) {
        
        strRole_Type = @"Driver";
        NSLog(@"Login as a %@ ",strRole_Type);
        
        
        
    }
}


#pragma mark webService Call 
-(void)calledLoginWebService
{
    NSString *strFieldType = @"Mobile";
   // NSString *strDevice_Token = @"dfgdfty45y645ytgdfg";
    NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]Login:strFieldType :self.txfEmail.text :self.txfPassword.text:[[NSUserDefaults standardUserDefaults]valueForKey:@"device_token"]:@"Customer":@"iOS"];
    NSLog(@"Data is %@",arrLogin);
    
    

    
//    [self hideloader];
    if (arrLogin.count==0)
    {
            [SVProgressHUD dismiss];
            
            [self showMessage:@"Server is busy. Please wait."
                    withTitle:@"Trucky Ducky"];
       
    }
    else
    {
        
        if ([[[arrLogin  objectAtIndex:0] valueForKey:@"status"] isEqualToString:@"success"])
        {
            
             
          //  arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            arrUserInfo = [[arrLogin objectAtIndex:0]  valueForKey:@"UserInfo"];
            
            NSString *strBaseURL = [[arrLogin objectAtIndex:0]  valueForKey:@"base_url"];
            NSString *strUserID = [arrUserInfo valueForKey:@"User_Id"];
            
            
            
            [[NSUserDefaults standardUserDefaults] setObject:strBaseURL forKey:@"BaseURLPass"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [[NSUserDefaults standardUserDefaults] setObject:strUserID forKey:@"UserIDD"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
            [[NSUserDefaults standardUserDefaults] setObject:[arrUserInfo valueForKey:@"Full_Name"] forKey:@"Full_NamePass"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
            [[NSUserDefaults standardUserDefaults] setObject:[arrUserInfo valueForKey:@"Email"] forKey:@"EmailPass"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
            [[NSUserDefaults standardUserDefaults] setObject:[arrUserInfo valueForKey:@"Mobile"] forKey:@"MobilePass"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
            //*******Check Login as a Driver/Company ***********//
            
            [[NSUserDefaults standardUserDefaults] setObject:[arrUserInfo valueForKey:@"Role"] forKey:@"LoginRolePass"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
            
            NSString *strIMGProfile = [arrUserInfo valueForKey:@"Profile_Image"];
            
            
            if (strIMGProfile == nil || strIMGProfile == (id)[NSNull null])
            {
                NSLog(@"No DATA OF Profile Image");
             }
            else {
              [[NSUserDefaults standardUserDefaults] setObject:strIMGProfile forKey:@"ProfileImgPASS"];
              [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
        
            
             [SVProgressHUD dismiss];
            
                            
            MainTabVC *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"MainTabVC"];
            
            [self.navigationController pushViewController:Login animated:YES];

        }
        else
        {
             [SVProgressHUD dismiss];
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
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

@end
