//
//  SettingtabVC.m
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "SettingtabVC.h"
#import "SettingCell.h"

#import "editProfieVc.h"
#import "ProfileVC.h"
#import "ResetPasswordVC.h"
#import "Terms&ConditionVC.h"
#import "ReportProblem.h"
#import "HelpCenterVC.h"
#import "SVProgressHUD.h"
#import "webServicesSingulton.h"

@interface SettingtabVC ()
{
    NSArray *arrMainData;
    NSArray *arrSupportData;
    NSArray *arrSection;
    NSArray *arrTempImg;
    NSArray *arrMainImg;
    NSArray *arrSupportImg;
    
    NSString *strBaseURL;
    NSArray *arrResponse;
    
    NSString *strPushNotificationSet;
    UISwitch *mySwitch;
}


@end

@implementation SettingtabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.objTbl setBackgroundColor:[UIColor whiteColor]];
    
  
    
    arrSupportImg = [[NSArray alloc]initWithObjects:@"privacy-policy@3x.png",@"terms and conditions@3x.png",@"help-center@3x.png",@"report-problem@3x.png", nil];
    
    
    
    arrMainImg = [[NSArray alloc]initWithObjects:@"password-reset@3x.png",@"notification@3x.png", nil];
    
    
    
    arrSection = [[NSArray alloc]initWithObjects:@"",@"Support", nil];
    arrMainData = [[NSArray alloc]initWithObjects:@"Reset Password",@"Push Notification", nil];
    arrSupportData = [[NSArray alloc]initWithObjects:@"Privacy Policy", @"Terms and Conditions",@"Help Center",@"Report a Problem", nil];
    
    
    // This will set the corner radius of Logout button
        self.btnlogout.layer.cornerRadius = 5;
    
    // This will remove extra separators from tableview
    self.objTbl.tableFooterView = [UIView new];
    


    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
        
    
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



#pragma mark Get USerINFO webService Call 
-(void)GetUserInfoWebService
{
    NSString *strKey =@"User_Id" ;
    NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]GetUserInfo:strKey :[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"]];
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
            

            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"UserInfo"];
            
            
            
            NSString *CheckNotificationStatus;
            CheckNotificationStatus = [arrResponse  valueForKey:@"Push_Notification"];
            if ([CheckNotificationStatus isEqualToString:@"ON"]) {
                
                
                [mySwitch setOn:YES animated:YES];
            }
            else
            {
                [mySwitch setOn:NO animated:YES];
                //[mySwitch setOn:NO];
            }
            
            
           // [switchName setOn:YES animated:YES];
            
               self.lblName.text =  [arrResponse  valueForKey:@"Full_Name"];
               self.lblEmail.text = [arrResponse  valueForKey:@"Email"];
               self.lblPhoneNumber.text = [arrResponse  valueForKey:@"Mobile"];
               
               
               NSString *strImgKey = [arrResponse  valueForKey:@"Profile_Image"];
               
               strBaseURL=[[NSUserDefaults standardUserDefaults]valueForKey:@"BaseURLPass"];
               NSLog(@" UserID of Logged in User is..%@", strBaseURL);
               
               
               if (strImgKey == nil || strImgKey == (id)[NSNull null]) {
                 // nil branch
               } else {
                 
                   NSString *imgProfileURL = [strBaseURL stringByAppendingString:strImgKey];
                   NSURL *url = [NSURL URLWithString:imgProfileURL];

                   NSData *data = [NSData dataWithContentsOfURL:url];
                   UIImage *image = [UIImage imageWithData:data];

                   [self.imgVWProfile setImage:image];
                   
                   
                   self.imgVWProfile.layer.borderColor = [UIColor.lightGrayColor CGColor];
                      
                   self.imgVWProfile.layer.cornerRadius = self.imgVWProfile.frame.size.width/2;
                   
                   
               }
            
            
            
       

        }
        else
        {
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            strAlert = [arrResponse valueForKey:@"msg"];
            NSLog(@"%@", strAlert);
          
//                [self showMessage:strAlert
//                        withTitle:@"Trucky Ducky"];
            
            
           
        }
    }
}





#pragma mark: UITableView 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [arrMainData count];
    }
    else{
        return [arrSupportData count];
    }
   // return [arrMainData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"SettingCell";
    SettingCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[SettingCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:MyIdentifier] ;
    }
    
    
    
    if (indexPath.section == 0) {
        cell.lblTitle.text =  [arrMainData objectAtIndex:indexPath.row];
        cell.ImgVW.image = [UIImage imageNamed:[arrMainImg objectAtIndex:indexPath.row]];
    }
    else if (indexPath.section == 1){
        cell.lblTitle.text =  [arrSupportData objectAtIndex:indexPath.row];
        cell.ImgVW.image = [UIImage imageNamed:[arrSupportImg objectAtIndex:indexPath.row]];
    }
       
    
    if (indexPath.section == 0) {
        if(indexPath.row == 1)
        {
            mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(100, 9, 50, 50)];
            [mySwitch addTarget: self action: @selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
            
            mySwitch.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
            
            cell.accessoryView =  mySwitch;
            [cell.contentView addSubview:mySwitch];

            [[UISwitch appearance] setOnTintColor:[UIColor blackColor]];
            
        }
    }
    
    
    [cell setBackgroundColor:[UIColor whiteColor]];
   // cell.ImgVW.image = [UIImage imageNamed:[arrTempImg objectAtIndex:indexPath.row]];
    
    
   
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ResetPasswordVC *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"ResetPasswordVC"];
            [self.navigationController pushViewController:Login animated:YES];
        }
    }
    
    
    if (indexPath.section == 1) {
        
        
    if (indexPath.row == 0 || indexPath.row == 1) {
        NSString *strSelectedClass =  [arrSupportData objectAtIndex:indexPath.row];
         Terms_ConditionVC *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"Terms_ConditionVC"];
        Login.self.StrCheckClick = strSelectedClass;
               [self.navigationController pushViewController:Login animated:YES];
        }
        
        
       
        
    if (indexPath.row == 2) {
         HelpCenterVC *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpCenterVC"];
           [self.navigationController pushViewController:Login animated:YES];
    }
        
        
        if (indexPath.row == 3) {
                ReportProblem *report = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportProblem"];
                  [self.navigationController pushViewController:report animated:YES];
           }
        
        
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    if ( section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 80)];
        /* Create custom view to display section header... */
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, tableView.frame.size.width, 40)];
        [label setFont:[UIFont boldSystemFontOfSize:16]];
       // label.textAlignment =  NSTextAlignmentLeft;
         NSString *string =[arrSection objectAtIndex:section];
        /* Section header is in 0th index... */
        [label setText:string];
        label.textColor = [UIColor blackColor];
        [view addSubview:label];
        if (@available(iOS 13.0, *)) {
//            [view setBackgroundColor:[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0]];
        } else {
            // Fallback on earlier versions
        } //your background color...
        return view;
    }

     if (section ==  1)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 180)];
        /* Create custom view to display section header... */
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, tableView.frame.size.width, 40)];
        [label setFont:[UIFont boldSystemFontOfSize:16]];
        //label.textAlignment =  NSTextAlignmentCenter;
         NSString *string =[arrSection objectAtIndex:section];
        /* Section header is in 0th index... */
        [label setText:string];
        label.textColor = [UIColor blackColor];
        [view addSubview:label];
        if (@available(iOS 13.0, *)) {
            [view setBackgroundColor:[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0]];
        } else {
            // Fallback on earlier versions
        }
         //[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]]; //your background color...
        return view;
    }
    return nil;



}



- (void)switchChanged:(id)sender {
    UISwitch *switchControl = sender;
    
    if (switchControl.on) {
        
        strPushNotificationSet = @"ON";
        [self PushNotificatonSet];
        
    }
    
    else{
         strPushNotificationSet = @"OFF";
        [self PushNotificatonSet];
    }
    
}


#pragma mark SET PushNotificatoin webService Call 
-(void)PushNotificatonSet
{
    
    NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]PushNotificationSET:[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"]:strPushNotificationSet];
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
            arrTemp = [[arrLogin objectAtIndex:0] valueForKey:@"response"];
            arrResponse = [arrTemp  valueForKey:@"response"];
            
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)actionProfileClicked:(id)sender
{
    ProfileVC *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileVC"];
   
    [self.navigationController pushViewController:Login animated:YES];
}

- (IBAction)actionLogout:(id)sender {
    
    NSString *appDomain = NSBundle.mainBundle.bundleIdentifier;
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
