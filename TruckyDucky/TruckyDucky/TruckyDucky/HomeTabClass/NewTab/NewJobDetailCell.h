//
//  NewJobDetailCell.h
//  TruckyDucky
//
//  Created by anil kumar on 07/02/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewJobDetailCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *backVW;
@property (strong, nonatomic) IBOutlet UIImageView *imgProfile;
@property (strong, nonatomic) IBOutlet UILabel *lblDriverName;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblComingNow;
@property (strong, nonatomic) IBOutlet UILabel *lblDistance;
@property (strong, nonatomic) IBOutlet UIButton *btnAccept;
@end

NS_ASSUME_NONNULL_END
