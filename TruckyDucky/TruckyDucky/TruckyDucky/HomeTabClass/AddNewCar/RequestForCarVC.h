//
//  RequestForCarVC.h
//  TruckyDucky
//
//  Created by anil kumar on 30/01/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RequestForCarVC : UIViewController



@property (strong, nonatomic) NSArray *arrPassData;
@property (strong, nonatomic) NSString *EditAgainCheck;


@property (strong, nonatomic) IBOutlet UILabel *lblTab1;
@property (strong, nonatomic) IBOutlet UILabel *lblTab2;
@property (strong, nonatomic) IBOutlet UILabel *lblTab3;
@property (strong, nonatomic) IBOutlet UILabel *lblTab4;






// Pick up Location View
@property (strong, nonatomic) IBOutlet UIView *vwPickupLocation;
@property (strong, nonatomic) IBOutlet UIButton *btnPickupLocation;
@property (strong, nonatomic) IBOutlet UITextField *txfCompanyName;
@property (strong, nonatomic) IBOutlet UIButton *btnPickupNext;

- (IBAction)actionPickupLocation:(id)sender;
- (IBAction)actionPickupNext:(id)sender;



//  Drop off Location  View
@property (strong, nonatomic) IBOutlet UIView *vwDropOffLocation;
@property (strong, nonatomic) IBOutlet UIButton *btnDropOffLocation;
@property (strong, nonatomic) IBOutlet UITextField *txfDropOffCompanyName;
@property (strong, nonatomic) IBOutlet UIButton *btnDropOffNext;
@property (strong, nonatomic) IBOutlet UIButton *btnDropoffPrevious;


- (IBAction)actionDropoffLocation:(id)sender;
- (IBAction)actionDropoffNext:(id)sender;
- (IBAction)actionDropoffPrevious:(id)sender;



// Enter Amount View

@property (strong, nonatomic) IBOutlet UIView *vwEnterAmount;
@property (strong, nonatomic) IBOutlet UITextField *txfEnterAmount;

@property (strong, nonatomic) IBOutlet UIButton *btnAmountNext;
@property (strong, nonatomic) IBOutlet UIButton *btnAmountPrevious;

- (IBAction)actionAmountNext:(id)sender;
- (IBAction)actionAmountPrevious:(id)sender;











// Car Detail View

@property (strong, nonatomic) IBOutlet UIView *vwCarDetails;
@property (strong, nonatomic) IBOutlet UITextField *txfCarMake;
@property (strong, nonatomic) IBOutlet UITextField *txfCarModel;
@property (strong, nonatomic) IBOutlet UITextField *txfRegoNo;
@property (strong, nonatomic) IBOutlet UITextField *txfCarColor;


@property (strong, nonatomic) IBOutlet UIButton *bntDone;
- (IBAction)actionDone:(id)sender;
- (IBAction)actionClose:(id)sender;








// New Design work Here
@property (strong, nonatomic) IBOutlet UIView *vwAddCarCount;
@property (strong, nonatomic) IBOutlet UIButton *btnCar1;
@property (strong, nonatomic) IBOutlet UIButton *btnCar2;
@property (strong, nonatomic) IBOutlet UIButton *btnCar3;


@property (strong, nonatomic) IBOutlet UIImageView *imgCar1;
@property (strong, nonatomic) IBOutlet UIImageView *imgCar2;
@property (strong, nonatomic) IBOutlet UIImageView *imgCar3;

@property (strong, nonatomic) IBOutlet UIButton *btnCarNext;
@property (strong, nonatomic) IBOutlet UIButton *btnCarPrevious;




- (IBAction)actionAddCarRequestDone:(id)sender;
- (IBAction)actionCarDetailPrevious:(id)sender;

- (IBAction)actionCar1Clicked:(id)sender;
- (IBAction)actionCar2Clicked:(id)sender;
- (IBAction)actionCar3Clicked:(id)sender;

@end

NS_ASSUME_NONNULL_END
