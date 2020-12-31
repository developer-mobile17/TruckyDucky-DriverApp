//
//  Terms&ConditionVC.m
//  TruckyDucky
//
//  Created by anil kumar on 26/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "Terms&ConditionVC.h"
#import "SVProgressHUD.h"
#import "webServicesSingulton.h"
@interface Terms_ConditionVC ()
{
    NSArray *arrResponse;
}

@end

@implementation Terms_ConditionVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.StrCheckClick);
    
    if ([self.StrCheckClick isEqualToString:@"Privacy Policy"])
    {
        
        self.lblHeaderTitle.text = @"Privacy Policy";
        
    } else
        
    {
        self.lblHeaderTitle.text = @"Terms & Conditions";
        
    }
    
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 [SVProgressHUD showWithStatus:@"Loading..."];
                 
                 [self calledTerms_conditionAPI];
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
-(void)calledTerms_conditionAPI
{

    NSString *strAlert;
    NSArray *arrLogin = [[webServicesSingulton sharedManager]Terms_conditionAPI];
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
            
            NSArray *arrTemp;
         //   arrTemp = [[arrLogin objectAtIndex:0] valueForKey:@"Pages"];
            arrResponse = [[arrLogin objectAtIndex:0] valueForKey:@"Pages"];
            
            NSString *strTitle = [[arrResponse objectAtIndex:0]valueForKey:@"title"];
            NSLog(@"%@",strTitle);
            NSString *strDescription = [[arrResponse objectAtIndex:0]valueForKey:@"description"];
            
            
            NSString *strTitle1 = [[arrResponse objectAtIndex:1]valueForKey:@"title"];
            NSLog(@"%@",strTitle1);
            NSString *strDescription1 = [[arrResponse objectAtIndex:1]valueForKey:@"description"];
            
            
            
           // NSLog(@"%@",strDescription);
            
            if ([self.StrCheckClick isEqualToString:@"Privacy Policy"]) {
                
                 NSAttributedString *attributedStringPolicy = [[NSAttributedString alloc]
                                                                          initWithData: [strDescription dataUsingEncoding:NSUnicodeStringEncoding]
                                                                          options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                                          documentAttributes: nil
                                                                          error: nil
                                                                          ];
                self.objTxv.attributedText = attributedStringPolicy;
                
            }
            
                        
            else{
                
                
                NSAttributedString *attributedStringTerms = [[NSAttributedString alloc]
                           initWithData: [strDescription1 dataUsingEncoding:NSUnicodeStringEncoding]
                           options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                           documentAttributes: nil
                           error: nil
                           ];
                           
                           self.objTxv.attributedText = attributedStringTerms;
                
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

- (IBAction)actoinBack:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}


@end
