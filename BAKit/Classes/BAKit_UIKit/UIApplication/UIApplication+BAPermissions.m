//
//  UIApplication-BAPermissions.m
//  BAKit
//
//  Created by boai on 2017/6/10.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UIApplication+BAPermissions.h"

// Import required frameworks
#import <AddressBook/AddressBook.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <EventKit/EventKit.h>

#import "BAKit_DefineCommon.h"


typedef void (^BAKit_LocationManagerSuccessBlock)();
typedef void (^BAKit_LocationManagerFailureBlock)();

@interface UIApplication () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *ba_locationManager;
@property (nonatomic, copy) BAKit_LocationManagerSuccessBlock ba_locationSuccessBlock;
@property (nonatomic, copy) BAKit_LocationManagerFailureBlock ba_locationFailureBlock;

@end


@implementation UIApplication (Permissions)


#pragma mark - Check permissions

/**
 BluetoothLE 权限状态

 @return BAKit_PermissionAccess
 */
- (BAKit_PermissionAccess)ba_hasAccessToBluetoothLE
{
    switch ([[[CBCentralManager alloc] init] state]) {
        case CBCentralManagerStateUnsupported:
            return BAKit_PermissionAccessUnsupported;
            break;
            
        case CBCentralManagerStateUnauthorized:
            return BAKit_PermissionAccessDenied;
            break;
            
        default:
            return BAKit_PermissionAccessGranted;
            break;
    }
}

/**
 Calendar 权限状态

 @return BAKit_PermissionAccess
 */
- (BAKit_PermissionAccess)ba_hasAccessToCalendar
{
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent]) {
        case EKAuthorizationStatusAuthorized:
            return BAKit_PermissionAccessGranted;
            break;
            
        case EKAuthorizationStatusDenied:
            return BAKit_PermissionAccessDenied;
            break;
            
        case EKAuthorizationStatusRestricted:
            return BAKit_PermissionAccessRestricted;
            break;
            
        default:
            return BAKit_PermissionAccessUnknown;
            break;
    }
}

/**
 Contacts 权限状态
 
 @return BAKit_PermissionAccess
 */
- (BAKit_PermissionAccess)ba_hasAccessToContacts
{
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized:
            return BAKit_PermissionAccessGranted;
            break;
            
        case kABAuthorizationStatusDenied:
            return BAKit_PermissionAccessDenied;
            break;
            
        case kABAuthorizationStatusRestricted:
            return BAKit_PermissionAccessRestricted;
            break;
            
        default:
            return BAKit_PermissionAccessUnknown;
            break;
    }
}

/**
 Location 权限状态
 
 @return BAKit_PermissionAccess
 */
- (BAKit_PermissionAccess)ba_hasAccessToLocation
{
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusAuthorizedAlways:
            return BAKit_PermissionAccessGranted;
            break;
            
        case kCLAuthorizationStatusDenied:
            return BAKit_PermissionAccessDenied;
            break;
            
        case kCLAuthorizationStatusRestricted:
            return BAKit_PermissionAccessRestricted;
            break;
            
        default:
            return BAKit_PermissionAccessUnknown;
            break;
    }
    return BAKit_PermissionAccessUnknown;
}

/**
 Photos 权限状态
 
 @return BAKit_PermissionAccess
 */
- (BAKit_PermissionAccess)ba_hasAccessToPhotos
{
    switch ([ALAssetsLibrary authorizationStatus]) {
        case ALAuthorizationStatusAuthorized:
            return BAKit_PermissionAccessGranted;
            break;
            
        case ALAuthorizationStatusDenied:
            return BAKit_PermissionAccessDenied;
            break;
            
        case ALAuthorizationStatusRestricted:
            return BAKit_PermissionAccessRestricted;
            break;
            
        default:
            return BAKit_PermissionAccessUnknown;
            break;
    }
}

/**
 Reminders 权限状态
 
 @return BAKit_PermissionAccess
 */
- (BAKit_PermissionAccess)ba_hasAccessToReminders
{
    switch ([EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder]) {
        case EKAuthorizationStatusAuthorized:
            return BAKit_PermissionAccessGranted;
            break;
            
        case EKAuthorizationStatusDenied:
            return BAKit_PermissionAccessDenied;
            break;
            
        case EKAuthorizationStatusRestricted:
            return BAKit_PermissionAccessRestricted;
            break;
            
        default:
            return BAKit_PermissionAccessUnknown;
            break;
    }
    return BAKit_PermissionAccessUnknown;
}


#pragma mark - Request permissions

/**
 Calendar 权限监测

 @param successBlock successBlock description
 @param failureBlock failureBlock description
 */
- (void)ba_requestAccessToCalendarWithSuccessBlock:(void(^)())successBlock
                                      failureBlock:(void(^)())failureBlock
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted)
            {
                successBlock();
            }
            else
            {
                failureBlock();
            }
        });
    }];
}

/**
 Contacts 权限监测
 
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 */
- (void)ba_requestAccessToContactsWithSuccessBlock:(void(^)())successBlock
                                      failureBlock:(void(^)())failureBlock
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    if(addressBook)
    {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted)
                {
                    successBlock();
                }
                else
                {
                    failureBlock();
                }
            });
        });
    }
}

/**
 Microphone 权限监测
 
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 */
- (void)ba_requestAccessToMicrophoneWithSuccessBlock:(void(^)())successBlock
                                        failureBlock:(void(^)())failureBlock
{
    AVAudioSession *session = [[AVAudioSession alloc] init];
    [session requestRecordPermission:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted)
            {
                successBlock();
            }
            else
            {
                failureBlock();
            }
        });
    }];
}

/**
 Motion 运动权限监测
 
 @param successBlock successBlock description
 */
- (void)ba_requestAccessToMotionWithSuccessBlock:(void(^)())successBlock
{
    CMMotionActivityManager *motionManager = [[CMMotionActivityManager alloc] init];
    NSOperationQueue *motionQueue = [[NSOperationQueue alloc] init];
    [motionManager startActivityUpdatesToQueue:motionQueue withHandler:^(CMMotionActivity *activity) {
        successBlock();
        [motionManager stopActivityUpdates];
    }];
}

/**
 Photos 权限监测
 
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 */
- (void)ba_requestAccessToPhotosWithSuccessBlock:(void(^)())successBlock
                                    failureBlock:(void(^)())failureBlock
{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        successBlock();
    } failureBlock:^(NSError *error) {
        failureBlock();
    }];
}

/**
 Reminders 权限监测
 
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 */
- (void)ba_requestAccessToRemindersWithSuccessBlock:(void(^)())successBlock
                                       failureBlock:(void(^)())failureBlock {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted)
            {
                successBlock();
            }
            else
            {
                failureBlock();
            }
        });
    }];
}

#pragma mark - Needs investigating
/**
 Location 权限监测
 
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 */
- (void)ba_requestAccessToLocationWithDelegate:(id<CLLocationManagerDelegate>)delegate
                                 successBlock:(void(^)())successBlock
                                 failureBlock:(void(^)())failureBlock
{
    self.ba_locationManager = [[CLLocationManager alloc] init];
    self.ba_locationManager.delegate = delegate;
    
    self.ba_locationSuccessBlock = successBlock;
    self.ba_locationFailureBlock = failureBlock;
    [self.ba_locationManager startUpdatingLocation];
}

#pragma mark - Location manager injection


- (void)setBa_locationManager:(CLLocationManager *)ba_locationManager
{
    BAKit_Objc_setObj(@selector(ba_locationManager), ba_locationManager);
}

- (CLLocationManager *)ba_locationManager
{
    return BAKit_Objc_getObj;
}

- (void)setBa_locationSuccessBlock:(BAKit_LocationManagerSuccessBlock)ba_locationSuccessBlock
{
    BAKit_Objc_setObj(@selector(ba_locationSuccessBlock), ba_locationSuccessBlock);
}

- (BAKit_LocationManagerSuccessBlock)ba_locationSuccessBlock
{
    return BAKit_Objc_getObj;
}

- (void)setBa_locationFailureBlock:(BAKit_LocationManagerFailureBlock)ba_locationFailureBlock
{
    BAKit_Objc_setObj(@selector(ba_locationFailureBlock), ba_locationFailureBlock);
}

- (BAKit_LocationManagerFailureBlock)ba_locationFailureBlock
{
    return BAKit_Objc_getObj;
}

#pragma mark - Location manager delegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways)
    {
        self.ba_locationSuccessBlock();
    }
    else if (status != kCLAuthorizationStatusNotDetermined)
    {
        self.ba_locationFailureBlock();
    }
}

@end
