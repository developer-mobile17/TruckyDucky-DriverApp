//
//  HistorytabCell.h
//  TruckyDucky
//
//  Created by bllss it sloutions on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.


#import <UIKit/UIKit.h>

@interface HistorytabCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *bckView;
@property (strong, nonatomic) IBOutlet UILabel *lblHeaderTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblPickup_Address;
@property (strong, nonatomic) IBOutlet UILabel *lblDropoff_Address;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lblDistance;
@end
