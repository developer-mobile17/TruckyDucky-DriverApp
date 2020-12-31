//
//  SettingtabVC.h
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingtabVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgVWProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UITableView *objTbl;
@property (strong, nonatomic) IBOutlet UIButton *btnlogout;
- (IBAction)actionProfileClicked:(id)sender;
- (IBAction)actionLogout:(id)sender;

@end
