//
//  NewTabDetailinfoVC.h
//  TruckyDucky
//
//  Created by anil kumar on 07/02/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewTabDetailinfoVC : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *objTbl;
@property (strong, nonatomic) IBOutlet UIView *vwHeaderTop;

@property (weak, nonatomic) IBOutlet UILabel *lblHeadetTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDistanceKM;

@property (weak, nonatomic) IBOutlet UILabel *lblSenderTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSenderLocationPickup;

@property (weak, nonatomic) IBOutlet UILabel *lblReceiverTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblReceiverLocationDropoff;

@property (weak, nonatomic) IBOutlet UILabel *lblDeliveredStatus;



@property (weak, nonatomic) NSArray *arrActivitysPass;
@end

NS_ASSUME_NONNULL_END
