//
//  SignUPVC.h
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUPVC : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *objsegment;
@property (strong, nonatomic) IBOutlet UIScrollView *objScroll;

@property (strong, nonatomic) IBOutlet UITextField *txfYourname;
@property (strong, nonatomic) IBOutlet UITextField *txfEmail;
@property (strong, nonatomic) IBOutlet UITextField *txfPhoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *txfCompanyName;
@property (strong, nonatomic) IBOutlet UITextField *txfCompanyAddress;
@property (strong, nonatomic) IBOutlet UITextField *txfPassword;
@property (strong, nonatomic) IBOutlet UITextField *txfConfirmPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnCreateAccount;
- (IBAction)actionCreateAccount:(id)sender;
- (IBAction)actionSignIN:(id)sender;

@end
