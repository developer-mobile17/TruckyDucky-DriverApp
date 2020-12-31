//
//  checkInternet.m
//  ChakshuMinkMe
//
//  Created by Abhishek Gupta on 14/02/14.
//  Copyright (c) 2014 Abhishek Gupta. All rights reserved.
//

#import "checkInternet.h"
#import "Reachability.h"

@implementation checkInternet


+(BOOL)checkInternet
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus ==NotReachable)
    {
        return NO;
    }
    else
    {
        return YES;
    }

}
+(BOOL) connectedToNetwork
{
    const char *host_name = "www.google.com";
    BOOL _isDataSourceAvailable = NO;
    Boolean success;
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL,host_name);
    SCNetworkReachabilityFlags flags;
    success = SCNetworkReachabilityGetFlags(reachability, &flags);
    _isDataSourceAvailable = success &&
    (flags & kSCNetworkFlagsReachable) &&
    !(flags & kSCNetworkFlagsConnectionRequired);
    
    CFRelease(reachability);
    
    return _isDataSourceAvailable;
}


@end
