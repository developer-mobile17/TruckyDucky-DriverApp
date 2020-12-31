//
//  TrackDriverCell.h
//  TruckyDucky
//
//  Created by anil kumar on 13/02/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrackDriverCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *bckView;
@property (strong, nonatomic) IBOutlet UILabel *lblHeaderTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnTrackDriverLocation;
@property (strong, nonatomic) IBOutlet UILabel *lblDrivername;
@property (strong, nonatomic) IBOutlet UILabel *lblDriverPhone;
@property (strong, nonatomic) IBOutlet UILabel *lblDriverTruckinfo;
@property (strong, nonatomic) IBOutlet UIImageView *lblDriverPhoto;
@property (strong, nonatomic) IBOutlet UILabel *lblSenderName;
@property (strong, nonatomic) IBOutlet UILabel *lblSenderPhone;


@end

NS_ASSUME_NONNULL_END
