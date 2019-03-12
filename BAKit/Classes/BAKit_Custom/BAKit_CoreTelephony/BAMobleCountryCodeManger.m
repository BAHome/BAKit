//
//  BAMobleCountryCodeManger.m
//  BBB
//
//  Created by 孙博岩 on 2019/1/23.
//  Copyright © 2019 boai. All rights reserved.
//

#import "BAMobleCountryCodeManger.h"

@implementation BAMobleCountryCodeManger

+ (NSString *)serviceProvider
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    /*
     {
     0000000100000001 = "CTCarrier (0x282c8d530) {\n\tCarrier name: [\U4e2d\U56fd\U8054\U901a]\n\tMobile Country Code: [460]\n\tMobile Network Code:[01]\n\tISO Country Code:[cn]\n\tAllows VOIP? [YES]\n}\n";
     }
     */
    CTCarrier *carrier;
    if (@available(iOS 12.0, *)) {
        NSDictionary <NSString *, CTCarrier *>*dict = [info serviceSubscriberCellularProviders];
        
        if (dict.allKeys > 0)
        {
//            for (NSInteger i = 0; i < dict.allKeys.count; ++i)
//            {
//                NSString *key = dict.allKeys[i];
//
//                CTCarrier *carrier = dict[key];
//                NSString *name = carrier.carrierName;
//                NSLog(@"carrierName：%@", name);
//            }
            NSString *key = dict.allKeys[0];
            carrier = dict[key];
        }
        else
        {
            carrier = [info subscriberCellularProvider];
        }
    } else {
        
        carrier = [info subscriberCellularProvider];
        
    }
    NSString *name = carrier.carrierName;
    NSLog(@"carrierName：%@", name);
    
    if (carrier == nil)
    {
        carrier = nil;
        return nil;
    }

    // The mobile network code (MNC) for the user’s cellular service provider
    NSString *code = [carrier mobileNetworkCode];
    if (code == nil)
    {
        carrier = nil;
        return nil;
    }
    return code;
}

+ (CTCarrier *)serviceCarrier
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    // information about the user’s home cellular service provider
    
    /*
     {
     0000000100000001 = "CTCarrier (0x282c8d530) {\n\tCarrier name: [\U4e2d\U56fd\U8054\U901a]\n\tMobile Country Code: [460]\n\tMobile Network Code:[01]\n\tISO Country Code:[cn]\n\tAllows VOIP? [YES]\n}\n";
     }
     */
    CTCarrier *carrier;
    if (@available(iOS 12.0, *)) {
        NSDictionary <NSString *, CTCarrier *>*dict = [info serviceSubscriberCellularProviders];
        
        if (dict.allKeys > 0)
        {
            //            for (NSInteger i = 0; i < dict.allKeys.count; ++i)
            //            {
            //                NSString *key = dict.allKeys[i];
            //
            //                CTCarrier *carrier = dict[key];
            //                NSString *name = carrier.carrierName;
            //                NSLog(@"carrierName：%@", name);
            //            }
            NSString *key = dict.allKeys[0];
            carrier = dict[key];
        }
        else
        {
            carrier = [info subscriberCellularProvider];
        }
    }
    else
    {
        carrier = [info subscriberCellularProvider];
    }
    NSLog(@"\n\ncarrierName：%@\nmobileNetworkCode:%@\nmobileCountryCode：%@\nallowsVOIP：%@\n\n", carrier.carrierName, carrier.mobileNetworkCode, carrier.mobileCountryCode, carrier.allowsVOIP ? @"Y":@"N");

    if (carrier == nil)
    {
        carrier = nil;
        return nil;
    }
    
    return carrier;
}

@end
