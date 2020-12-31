//
//  LoginVC.h
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *objsegment;
@property (strong, nonatomic) IBOutlet UITextField *txfEmail;
@property (strong, nonatomic) IBOutlet UITextField *txfPassword;

@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
- (IBAction)actionLogin:(id)sender;

- (IBAction)actionSignUP:(id)sender;
- (IBAction)actionForgotPassword:(id)sender;
@end
