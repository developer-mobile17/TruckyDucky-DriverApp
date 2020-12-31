//
//  webServicesSingulton.h
//  SAS
//
//  Created by Abhishek Gupta on 29/09/14.
//  Copyright (c) 2014 Abhishek Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface webServicesSingulton : NSObject
+ (webServicesSingulton *) sharedManager;


#pragma mark : Login & SignUP API 
-(NSArray *)Login : (NSString *) FieldType : (NSString *) Mobile : (NSString *) Password :(NSString *)Device_Token :(NSString *)Role :(NSString *)MobileType ;


-(NSArray *)signup : (NSString *) Full_Name : (NSString *) Email :(NSString *)Mobile :(NSString *)Password :(NSString *)Role :(NSString *)Device_Token ;


-(NSArray *)ForgotPassword : (NSString *) Email ;

-(NSArray *)VerifyNewAccount : (NSString *) Mobile : (NSString *) Code ;

-(NSArray *)CreateNewAccount : (NSString *) Email : (NSString *) OTP : (NSString *) Password ;


-(NSArray *)ResetYourPassword : (NSString *) User_Id : (NSString *) oldPassword : (NSString *) newPassword ;


#pragma mark : Home API Calling 




-(NSArray *)GetCarsById :(NSString *)Posted_By ;

// Offer  Accept API
-(NSArray *)GetCarsRequest :(NSString *)Posted_By ;


-(NSArray *)RequestAgain :(NSString *)Listing_Id ;


-(NSArray *)Booking :(NSString *)Listing_Id :(NSString *)Status :(NSString *)Driver_Id :(NSString *)Customer_Name ;

-(NSArray *)CancelByCustomer :(NSString *)Listing_Id :(NSString *)Driver_Id ;



-(NSArray *)ListingBID :(NSString *)Id :(NSString *)Driver_Id :(NSString *)Message ;




//    00008030000249912E52802E

#pragma mark : Setting API Calling 

-(NSArray *)Terms_conditionAPI;
-(NSArray *)SubmitReportrInfo :(NSString *)User_Id :(NSString *)Category :(NSString *)Message;


#pragma mark : Profile API Calling 

-(NSArray *)GetUserInfo :(NSString *)key :(NSString *)Value ;



#pragma mark : Company Login API 

-(NSArray *)GetTruckListing :(NSString *)Key :(NSString *)Value ;





#pragma mark : Add Car 





-(NSArray *)AddCar:(NSString *)Posted_By :(NSString *)Car_Model :(NSString *)Car_Make :(NSString *)Car_Rego :(NSString *)Car_Colour :(NSString *)Total_Vehicle : (NSString *)Distance : (NSString *)Pickup_Name :(NSString *)Pickup_Address :(NSString *)Pickup_Lat :(NSString *)Pickup_Long :(NSString *)Dropoff_Name :(NSString *)Dropoff_Address :(NSString *)Dropoff_Lat :(NSString *)Dropoff_Long ;





#pragma mark : Customer ACCEPTED | REJECTED  API 

-(NSArray *)jobConfirmationListing :(NSString *)Posted_By ;

-(NSArray *)CustomerJOBConfirmation:(NSString *)Listing_Id :(NSString *)Status :(NSString *)Driver_Id :(NSString *)Bid_Price :(NSString *)Customer_Name :(NSString *)Company_Id ;




-(NSArray *)CustomerOrdersHistory :(NSString *)Posted_By ;


-(NSArray *)BookedHistory :(NSString *)Posted_By ;

-(NSArray *)GetHistotyByDate :(NSString *)Posted_By :(NSString *)Delivered_Date;





-(NSArray *)GetDriverLocationForTracking :(NSString *)User_Id ;



-(NSArray *)PushNotificationSET :(NSString *)User_Id :(NSString *)Push_Notification;


#pragma mark : Edit-Profile API Calling 

-(NSArray *)editUser :(NSString *)User_Id :(NSString *)Full_Name :(NSString *)Email :(NSString *)Mobile  :(NSString *)Address :(NSData *)Profile_Image ;



@end
