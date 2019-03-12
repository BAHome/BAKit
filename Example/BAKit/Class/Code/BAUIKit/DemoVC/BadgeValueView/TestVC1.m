//
//  TestVC.m
//  BAKit
//
//  Created by boai on 2017/8/1.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "TestVC1.h"
#import "BAInfiniteRotationView.h"


@interface TestVC1 ()

@property(nonatomic, strong) UIView *testView;

@end

@implementation TestVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
//    _testView = [UIView new];
//    _testView.frame = CGRectMake(20, 100, 100, 100);
//    _testView.center = self.view.center;
//    _testView.backgroundColor = BAKit_Color_Translucent_3;
//    [self.view addSubview:_testView];
    
//    BAInfiniteRotationView *rotateView = [[BAInfiniteRotationView alloc] initWithFrame:_testView.bounds];
//    rotateView.speed                 = 0.95f;
//    rotateView.clockWise             = YES;
//    [rotateView startRotateAnimation];
//    [_testView addSubview:rotateView];
//
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
//    imageView.image        = [UIImage imageNamed:@"line"];
//    imageView.center       = rotateView.middlePoint;
//    [rotateView addSubview:imageView];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [rotateView reset];
//        [_testView ba_viewRemoveAllSubviews];
//        [_testView removeFromSuperview];
//    });
    
    BOOL isJailbroken = [self isJailbroken];

    NSLog(@"%s", isJailbroken);

}

- (BOOL)isJailbroken {
    if ([self isSimulator]) return NO; // Dont't check simulator
    
    // iOS9 URL Scheme query changed ...
    // NSURL *cydiaURL = [NSURL URLWithString:@"cydia://package"];
    // if ([[UIApplication sharedApplication] canOpenURL:cydiaURL]) return YES;
    
    NSArray *paths = @[@"/Applications/Cydia.app",
                       @"/private/var/lib/apt/",
                       @"/private/var/lib/cydia",
                       @"/private/var/stash"];
    for (NSString *path in paths) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) return YES;
    }
    
    FILE *bash = fopen("/bin/bash", "r");
    if (bash != NULL) {
        fclose(bash);
        return YES;
    }
    
    NSString *path = [NSString stringWithFormat:@"/private/%@", [self stringWithUUID]];
    if ([@"test" writeToFile : path atomically : YES encoding : NSUTF8StringEncoding error : NULL]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        return YES;
    }
    
    return NO;
}

- (NSString *)stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

- (BOOL)isSimulator {
    static dispatch_once_t one;
    static BOOL simu;
    dispatch_once(&one, ^{
        simu = NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location;
    });
    return simu;
}

@end
