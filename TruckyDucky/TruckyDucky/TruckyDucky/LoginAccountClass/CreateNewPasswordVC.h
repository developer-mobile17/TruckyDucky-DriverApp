//
//  CreateNewPasswordVC.h
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateNewPasswordVC : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txfOTP;
@property (strong, nonatomic) IBOutlet UITextField *txfNewPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
- (IBAction)actionSubmit:(id)sender;
@end
