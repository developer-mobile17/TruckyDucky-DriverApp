//
//  jobConfirmationDetailsVc.m
//  TruckyDucky
//
//  Created by anil kumar on 24/02/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import "jobConfirmationDetailsVc.h"
#import <CoreLocation/CoreLocation.h>

#import "jobConfirmationDetailCell.h"

@interface jobConfirmationDetailsVc ()
{
        NSArray *arrSenderTitle;
        NSArray *arrReceivertitle;
        NSArray *arrCarTitle;
    
    
        NSArray *arrTempImage;
    
    
        NSMutableArray *arrSenderData ;
        NSMutableArray *arrReceiverData ;
        NSMutableArray *arrCarData ;
}

@end

@implementation jobConfirmationDetailsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.objTbl.tableHeaderView = self.vwHeaderTop;
    
    NSLog(@"sdflajlsdfjlsjd  %@",self.arrJobDetailsPass);
    
    arrSenderTitle = [[NSArray alloc]initWithObjects:@"Name",@"Phone Number",@"Sender Address", nil];
    
    arrReceivertitle = [[NSArray alloc]initWithObjects:@"Name",@"receiver Address", nil];
    
    arrCarTitle = [[NSArray alloc]initWithObjects:@"Car Model",@"Car Registration Number ",@"Car Clor",@"Price Of transportation",@"Allow Bid ?", nil];
    
    arrTempImage = [[NSArray alloc]initWithObjects:@"user.png",@"mobile.png",@"location.png", @"location.png", @"location.png",@"price.png",@"payment_status.png", nil];
    
     NSLog(@"%@",self.arrJobDetailsPass);
    
    
    
    
       self.lblHeadetTitle.text = [[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Title"];
       self.lblSenderTitle.text = [[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Sender_Address"];
       self.lblReceiverTitle.text = [[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Receiver_Address"];
    
    
    
       
         arrSenderData = [[NSMutableArray alloc]init];
       
         [arrSenderData addObject: [[self.arrJobDetailsPass valueForKey:@"Job_Info"]valueForKey:@"Sender_Name"]];
         [arrSenderData addObject: [[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Sender_Phone"]];
         [arrSenderData addObject: [[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Sender_Address"]];
    
    
    
    
    
    
      arrSenderData = [[NSMutableArray alloc]init];
    
      [arrSenderData addObject: [[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Sender_Name"]];
      [arrSenderData addObject: [[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Sender_Phone"]];
      [arrSenderData addObject: [[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Sender_Address"]];
    
      NSLog(@"%@",arrSenderData);
    

    
    
       arrReceiverData = [[NSMutableArray alloc]init];
       
       
       [arrReceiverData addObject: [[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Receiver_Phone"]];
       [arrReceiverData addObject: [[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Receiver_Address"]];
    
      
    

       NSLog(@"%@",arrReceiverData);
    
    
    
    
         arrCarData = [[NSMutableArray alloc]init];
          
          [arrCarData addObject: [[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Car_Model"]];
          [arrCarData addObject: [[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Car_Rego"]];
          [arrCarData addObject: [[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Car_Colour"]];
          [arrCarData addObject: [NSString stringWithFormat:@"$ %@",[[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Price"]]];
          [arrCarData addObject: [[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Allow_Bids"]];
         
       

          NSLog(@"%@",arrCarData);
    
    [self GetDistanceinKM];
       
    
    
}

-(void)GetDistanceinKM
{
    
    CLLocation *startLocationchk = [[CLLocation alloc] initWithLatitude:[[[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Sender_Lat"] floatValue] longitude:[[[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Sender_Long"] floatValue]];
                   CLLocation *endLocationchk = [[CLLocation alloc] initWithLatitude:[[[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Receiver_Lat"] floatValue] longitude:[[[self.arrJobDetailsPass valueForKey:@"Job_Info"] valueForKey:@"Receiver_Long"] floatValue]];

     CLLocationDistance distancechk = [startLocationchk distanceFromLocation:endLocationchk] / 1000;
     self.lblDistanceKM.text = [NSString stringWithFormat:@"%.1f km",distancechk];
     self.lblDistanceKM.transform = CGAffineTransformMakeRotation(-89.55);
    
   //´ yourLabelName.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
    
}



- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDarkContent;
}


- (IBAction)actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark: UITableView 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
           return [arrCarData count];
       }
    
   else if (section == 1) {
        return [arrSenderData count];
    }
    else{
        return [arrReceiverData count];
    }
   // return [arrMainData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"jobConfirmationDetailCell";
    jobConfirmationDetailCell *cell = [tableView
                        dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[jobConfirmationDetailCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:MyIdentifier] ;
    }
    
    
    if (indexPath.section == 0) {
        cell.lblTitle.text =  [arrCarTitle objectAtIndex:indexPath.row];
        cell.lblName.text =  [arrCarData objectAtIndex:indexPath.row];
        NSLog(@"%@",cell.lblName.text);
        
    }
    
    
    if (indexPath.section == 1) {
        cell.lblTitle.text =  [arrSenderTitle objectAtIndex:indexPath.row];
        cell.lblName.text =  [arrSenderData objectAtIndex:indexPath.row];
        NSLog(@"%@",cell.lblName.text);
        
    }
    if (indexPath.section == 2)  {
        cell.lblTitle.text =  [arrReceivertitle objectAtIndex:indexPath.row];
         cell.lblName.text =  [arrReceiverData objectAtIndex:indexPath.row];
        
        NSLog(@"%@",cell.lblName.text);
    }
    
//    [cell setBackgroundColor:[UIColor whiteColor]];
//    cell.imgVWIcons.image = [UIImage imageNamed:[arrTempImage objectAtIndex:indexPath.row]];
    
    
   
    
    return cell;
}

     
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if ( section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
        /* Create custom view to display section header... */
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, tableView.frame.size.width, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        [label setFont:[UIFont boldSystemFontOfSize:16]];
         NSString *string =@"CAR DETAILS";
        /* Section header is in 0th index... */
        [label setText:string];
        label.textColor = [UIColor blackColor];
        [view addSubview:label];
        [view setBackgroundColor: [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0]]; //your background color...
        return view;
    }
    
    if ( section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
        /* Create custom view to display section header... */
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, tableView.frame.size.width, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        [label setFont:[UIFont boldSystemFontOfSize:16]];
         NSString *string =@"SENDER";
        /* Section header is in 0th index... */
        [label setText:string];
        label.textColor = [UIColor blackColor];
        [view addSubview:label];
        [view setBackgroundColor: [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0]]; //your background color...
        return view;
    }

     if (section ==  2)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
        /* Create custom view to display section header... */
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, tableView.frame.size.width, 40)];
        label.textAlignment =  NSTextAlignmentCenter;
        [label setFont:[UIFont boldSystemFontOfSize:16]];
         NSString *string =@"RECEIVER";
        /* Section header is in 0th index... */
        [label setText:string];
        label.textColor = [UIColor blackColor];
        [view addSubview:label];
        [view setBackgroundColor:[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0]]; //your background color...
        return view;
    }
    return nil;

}
@end
