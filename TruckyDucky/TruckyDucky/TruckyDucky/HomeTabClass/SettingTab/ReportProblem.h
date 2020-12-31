//
//  ReportProblem.h
//  TruckyDucky
//
//  Created by anil kumar on 11/03/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReportProblem : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *objTbl;
@property (weak, nonatomic) IBOutlet UIView *vwCategory;
@property (weak, nonatomic) IBOutlet UIView *vwMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblSelectedCategory;
@property (weak, nonatomic) IBOutlet UITextView *txvMessage;



@property (weak, nonatomic) IBOutlet UIButton *btnSelectedMenuItem;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@end

NS_ASSUME_NONNULL_END
