//
//  ReportProblem.m
//  TruckyDucky
//
//  Created by anil kumar on 11/03/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import "ReportProblem.h"
#import "webServicesSingulton.h"
#import "checkInternet.h"
#import "SVProgressHUD.h"

@interface ReportProblem ()<UITextViewDelegate>
{
    bool isPlaceholder;
    NSString *placeholderText;
    NSArray *arrResponse;
    NSArray *arrListOfReport;
    NSString *strSelectedData;
    
    
}


@end

@implementation ReportProblem

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    isPlaceholder = YES;
    placeholderText = @"Write issue here.";
    self.txvMessage.text = placeholderText;
    self.txvMessage.textColor = [UIColor lightGrayColor];
    [self.txvMessage setSelectedRange:NSMakeRange(0, 0)];
    
    
    self.txvMessage.delegate = self;
    self.txvMessage.backgroundColor = [UIColor whiteColor];
    
    
    self.vwCategory.layer.borderColor = [(UIColor.lightGrayColor)CGColor];
    self.vwCategory.layer.borderWidth = 1;
    self.vwCategory.layer.cornerRadius = 5;
    
    
    self.vwMessage.layer.borderColor = [(UIColor.lightGrayColor)CGColor];
    self.vwMessage.layer.borderWidth = 1;
    self.vwMessage.layer.cornerRadius = 5;
    
     self.btnSubmit.layer.cornerRadius = 5;
    
    
    arrListOfReport = [[NSArray alloc]initWithObjects:@"Payment",@"Address issue",@"Proof of Delivery",@"Damage issue",@"Other", nil];
    self.objTbl.hidden = YES;
    self.objTbl.backgroundColor = [UIColor whiteColor];
    
    self.objTbl.layer.borderColor = [(UIColor.lightGrayColor)CGColor];
    self.objTbl.layer.borderWidth = 1;
    self.objTbl.layer.cornerRadius = 5;
    
    
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
         [SVProgressHUD showWithStatus:@"Loading..."];
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                       [self SubmitReportrInfo];
                 });
       
       
       
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



#pragma mark webService Call 
-(void)SubmitReportrInfo
{
   // NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]SubmitReportrInfo:[[NSUserDefaults standardUserDefaults]valueForKey:@"UserIDD"] :strSelectedData :self.txvMessage.text];
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
            
            NSString *strMsg;
            strMsg = [[arrLogin objectAtIndex:0] valueForKey:@"msg"];

            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"Feedback_Info"];
            
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Trucky Ducky " message:strMsg preferredStyle:UIAlertControllerStyleAlert];

                                      UIAlertAction *Verification = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                         [self MovetoSettingScreen];
                                                          }];
                                      
                                      
                                      [alert addAction:Verification];

            [self presentViewController:alert animated:YES completion:nil];
            
  
        }
        else
        {
            NSString *strError;
            strError = [[arrLogin objectAtIndex:0] valueForKey:@"msg"];
          

        
            
        }
    }
}


-(void)MovetoSettingScreen
{
    [self.navigationController popViewControllerAnimated:YES];
}




- (IBAction)actoinBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}





- (IBAction)actionsubmitReport:(id)sender {

    
    if ([self.txvMessage.text length]==0) {
        
        [self showMessage:@"Enter your message."
        withTitle:@"Trucky Ducky"];
    }
    
    
    if ([self.txvMessage.text isEqualToString:@"Write issue here."]) {
           
           [self showMessage:@"Enter your message."
           withTitle:@"Trucky Ducky"];
       }
       
    
    
   if ([strSelectedData length]==0) {
       
        [self showMessage:@"Select your category."
               withTitle:@"Trucky Ducky"];
    }
    
    else{
        
   
    
    
   [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
   dispatch_async(dispatch_get_main_queue(), ^{
      [self checkinternet];
   });
         }
}




- (void) textViewDidChange:(UITextView *)textView{

    if (textView.text.length == 0){
        textView.textColor = [UIColor lightGrayColor];
        textView.text = placeholderText;
        [textView setSelectedRange:NSMakeRange(0, 0)];
        isPlaceholder = YES;

    } else if (isPlaceholder && ![textView.text isEqualToString:placeholderText]) {
        textView.text = [textView.text substringToIndex:1];
        textView.textColor = [UIColor blackColor];
        isPlaceholder = NO;
    }

}

- (IBAction)actionMenuClicked:(id)sender {
    self.objTbl.hidden = NO;
    self.vwMessage.hidden = YES;
}

#pragma mark: UITableView 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [arrListOfReport count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];

    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    }

    cell.textLabel.text=[arrListOfReport objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    [cell setBackgroundColor:[UIColor whiteColor]];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {

     strSelectedData = [arrListOfReport objectAtIndex:indexPath.row];
     NSLog(@"%@",strSelectedData);
     [self.btnSelectedMenuItem setTitle:strSelectedData forState:UIControlStateNormal];
     [self.btnSelectedMenuItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     self.objTbl.hidden=YES;
     self.vwMessage.hidden = NO;
 }




@end
