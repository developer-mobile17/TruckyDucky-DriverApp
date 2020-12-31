//
//  editProfieVc.h
//  TruckyDucky
//
//  Created by anil kumar on 17/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPDropMenu.h"

NS_ASSUME_NONNULL_BEGIN

@interface editProfieVc : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *objScroll;
@property (weak, nonatomic) IBOutlet UIImageView  *imgProfile;



@property (weak, nonatomic) IBOutlet UITextField *txtFullName;
@property (weak, nonatomic) IBOutlet UITextView  *txvUser_Description;
@property (weak, nonatomic) IBOutlet UITextField *txtPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txfAddress;







@property (weak, nonatomic) IBOutlet UITextField *txtTruckName;
@property (weak, nonatomic) IBOutlet UITextField *txtTruckType;
@property (weak, nonatomic) IBOutlet UITextField *txtTruckNumber;
@property (weak, nonatomic) IBOutlet UITextView  *txvTruckDesc;



@property (weak, nonatomic) IBOutlet UIView  *vwAddTruckMore;
@property (strong, nonatomic) IBOutlet UILabel *lblAddmoreTrucks;
@property (strong, nonatomic) IBOutlet UIButton *btnAddMoreTrucks;



@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UITextField *txtTruckLoad;
@property (nonatomic, weak) IBOutlet KPDropMenu *drop;


- (IBAction)actionCamera:(id)sender;


@end

NS_ASSUME_NONNULL_END
