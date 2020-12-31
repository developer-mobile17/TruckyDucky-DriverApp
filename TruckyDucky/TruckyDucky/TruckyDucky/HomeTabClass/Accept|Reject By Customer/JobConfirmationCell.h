//
//  JobConfirmationCell.h
//  TruckyDucky
//
//  Created by anil kumar on 11/02/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JobConfirmationCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *bckView;
@property (strong, nonatomic) IBOutlet UILabel *lblHeaderTitle;


@property (strong, nonatomic) IBOutlet UILabel *lblBIDPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblDriverName;
@property (strong, nonatomic) IBOutlet UILabel *lblPhoneNumber;
@property (strong, nonatomic) IBOutlet UILabel *lblDriverLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblPickupAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblPickDate;
@property (strong, nonatomic) IBOutlet UILabel *lblPickupWindow;




@property (strong, nonatomic) IBOutlet UIButton *btnDetailInfo;
@property (strong, nonatomic) IBOutlet UIButton *btnConfirm;
@property (strong, nonatomic) IBOutlet UIButton *btnReject;



@end

NS_ASSUME_NONNULL_END
