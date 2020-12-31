//
//  editProfieVc.m
//  TruckyDucky
//
//  Created by anil kumar on 17/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "editProfieVc.h"
#import "checkInternet.h"
#import "SVProgressHUD.h"
#import "webServicesSingulton.h"

#import "KPDropMenu.h"

@interface editProfieVc ()<KPDropMenuDelegate>
{
    NSString *strUserID;
    NSString *strBaseURL;
    NSArray *arrResponse;
    NSData *SelectedimgData1;
    NSData *ProfileImgData;
    
    NSString *strCheckCompID;
    NSString *strLoginAsCheck;
    
    
    NSData *DataImgFromAPI;
    NSString*strTruckLoad;
    
}

@end

@implementation editProfieVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
 
    
    
     strBaseURL=[[NSUserDefaults standardUserDefaults]valueForKey:@"BaseURLPass"];
     NSLog(@" UserID of Logged in User is..%@", strBaseURL);
    
    
     strUserID=[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"];
     NSLog(@" UserID of Logged in User is..%@", strUserID);
    
    
    
    
    self.objScroll.contentSize = CGSizeMake(self.objScroll.frame.size.width, 1000);
    self.btnCancel.layer.cornerRadius = 5;
    self.btnSave.layer.cornerRadius = 5;
    
    
    self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.height/2;
    self.imgProfile.layer.borderColor = [[UIColor whiteColor]CGColor];
    self.imgProfile.layer.borderWidth = 2;
    self.imgProfile.clipsToBounds = YES;
    
    
    
    
 
}



-(void)viewWillAppear:(BOOL)animated{
    
    
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                
                 
                 [self GetUserInfoWebService];
             });
    
    
    
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
        
        
        
        [SVProgressHUD showWithStatus:@"Updating Profile..." maskType:SVProgressHUDMaskTypeBlack];
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
                        
                         
                         [self editUserInforAPI];
                     });
        
        
       
       
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

#pragma mark Get USerINFO webService Call 
-(void)GetUserInfoWebService
{
    NSString *strKey =@"User_Id";
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
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"UserInfo"];
            
            self.txtFullName.text = [arrResponse  valueForKey:@"Full_Name"];
    
            self.txtPhoneNumber.text = [arrResponse  valueForKey:@"Mobile"];
            self.txtEmail.text = [arrResponse  valueForKey:@"Email"];

            NSString *strImgKey = [arrResponse  valueForKey:@"Profile_Image"];
   
            if (strImgKey == nil || strImgKey == (id)[NSNull null]) {
              // nil branch
            } else {
              
                NSString *imgProfileURL = [strBaseURL stringByAppendingString:strImgKey];
                           NSURL *url = [NSURL URLWithString:imgProfileURL];

                           DataImgFromAPI = [NSData dataWithContentsOfURL:url];
                
                           UIImage *image = [UIImage imageWithData:DataImgFromAPI];

                           [self.imgProfile setImage:image];
                
                           ProfileImgData = DataImgFromAPI;
    
            }
            
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

#pragma mark webService Call 
-(void)editUserInforAPI
{
    
    NSString *strAlert;
    
    NSArray *arrLogin = [[webServicesSingulton sharedManager]editUser:strUserID :self.txtFullName.text :self.txtEmail.text :self.txtPhoneNumber.text :self.txfAddress.text :ProfileImgData];
    

    
    
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
            
           arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"UserInfo"];
                      strAlert = [[arrLogin  objectAtIndex:0]valueForKey:@"msg"];
                      NSLog(@"%@", strAlert);
         
           
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Trucky Ducky " message:strAlert preferredStyle:UIAlertControllerStyleAlert];

                                      UIAlertAction *Verification = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                         [self MoveToNextClass];
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
-(void)MoveToNextClass{
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)actoinBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)actoinCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)actoinSave:(id)sender {
  
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    ProfileImgData = [[NSUserDefaults standardUserDefaults] objectForKey:@"imagedata1"];
    if (ProfileImgData == nil) {
        ProfileImgData  = DataImgFromAPI;
    }
    
    if ([self.txtFullName.text length]== 0)
       {
           [self showMessage:@"Please Enter Full Name"
                   withTitle:@"Trucky Ducky"];
       }
    
    else if ([ProfileImgData length]== 0)
    {
        [self showMessage:@"Please Choose your Profile Picture"
                withTitle:@"Trucky Ducky"];
    }
    
       else if ([self.txtPhoneNumber.text length]== 0)
       {
           [self showMessage:@"Please Enter Phone Number"
                   withTitle:@"Trucky Ducky"];
       }

       
       else if ([self.txtEmail.text length]== 0)
       {
           [self showMessage:@"Please Enter Your Email"
                   withTitle:@"Trucky Ducky"];
       }
    
    else if ([emailTest evaluateWithObject:self.txtEmail.text] == NO)
    {
       [self showMessage:@"Email not in proper format"
        withTitle:@"Trucky Ducky"];
    }
    


    else
       {
       
       dispatch_async(dispatch_get_main_queue(), ^{
           [SVProgressHUD showWithStatus:@"Updating Profile..."];
           [self checkinternet];
       });
       }
}


- (IBAction)actionCamera:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Trucky Ducky" message:@"Choose Your Profile Photo" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *Camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self Camera];
                        }];
    
    
    UIAlertAction *Gallary = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseFromLibrary];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancel];
    [alert addAction:Camera];
    [alert addAction:Gallary];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark OpenCamera
-(void)Camera{
     if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                         
                                         //Step 1: Create a UIAlertController
                                         UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:@"Trucky Ducky"
                                                                                                                    message: @"Device has no camera"
                                                                                                             preferredStyle:UIAlertControllerStyleAlert];
                                         
                                         //Step 2: Create a UIAlertAction that can be added to the alert
                                         UIAlertAction* ok = [UIAlertAction
                                                              actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action)
                                                              {
                                                                  //Do some thing here, eg dismiss the alertwindow
                                                                  [myAlertController dismissViewControllerAnimated:YES completion:nil];
                                                                  
                                                              }];
                                         
                                         //Step 3: Add the UIAlertAction ok that we just created to our AlertController
                                         [myAlertController addAction: ok];
                                         
                                         //Step 4: Present the alert to the user
                                         [self presentViewController:myAlertController animated:YES completion:nil];
                                         
                                     }
    else{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
}

}

#pragma mark open Gallery

-(void)chooseFromLibrary{
    
    [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}


#pragma mark: UIImagePicker
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    
    
       UIGraphicsBeginImageContext(CGSizeMake(480,320));
       UIGraphicsGetCurrentContext();
       [[editingInfo objectForKey:@"UIImagePickerControllerOriginalImage"] drawInRect: CGRectMake(0, 0, 480, 320)];
       UIImage  *smallImage = UIGraphicsGetImageFromCurrentImageContext();
       UIGraphicsEndImageContext();
       SelectedimgData1 = UIImageJPEGRepresentation(smallImage,0);
    
    
    [[NSUserDefaults standardUserDefaults]setObject:SelectedimgData1 forKey:@"imagedata1"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
    
    UIImage *chosenImage = [UIImage imageWithData:SelectedimgData1];
    self.imgProfile.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}





@end
