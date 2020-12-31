//
//  ForgotPasswordVC.h
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordVC : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txfEmail;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;
- (IBAction)actionSend:(id)sender;
@end
