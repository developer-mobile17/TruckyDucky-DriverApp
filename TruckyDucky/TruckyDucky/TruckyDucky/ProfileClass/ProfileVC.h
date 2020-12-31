//
//  ProfileVC.h
//  TruckyDucky
//
//  Created by anil kumar on 16/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *vwTopProfile;
@property (weak, nonatomic) IBOutlet UIScrollView *objScroll;
@property (weak, nonatomic) IBOutlet UIImageView *imgCurrentRating;



@property (weak, nonatomic) IBOutlet UILabel *lblDriverName;
@property (weak, nonatomic) IBOutlet UITextView *txvDesciption;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblDelivery;
@property (weak, nonatomic) IBOutlet UILabel *lblRating;

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
@property (strong, nonatomic) IBOutlet UIButton *btnTruckListing;
@property (strong, nonatomic) IBOutlet UIButton *btnEditProfile;


@property (weak, nonatomic) IBOutlet UITextField *txtTruckLoad;





@end

NS_ASSUME_NONNULL_END
