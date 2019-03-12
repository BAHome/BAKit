//
//  BAKit_DefineApp.h
//  BAKit
//
//  Created by boai on 2017/9/20.
//  Copyright © 2017年 boai. All rights reserved.
//

#ifndef BAKit_DefineApp_h
#define BAKit_DefineApp_h


//CG_INLINE NSString *
//BAKit_DeviceIsJailbroken(void) {
//    
//    if ([self isSimulator]) return NO; // Dont't check simulator
//    
//    // iOS9 URL Scheme query changed ...
//    // NSURL *cydiaURL = [NSURL URLWithString:@"cydia://package"];
//    // if ([[UIApplication sharedApplication] canOpenURL:cydiaURL]) return YES;
//    
//    NSArray *paths = @[@"/Applications/Cydia.app",
//                       @"/private/var/lib/apt/",
//                       @"/private/var/lib/cydia",
//                       @"/private/var/stash"];
//    for (NSString *path in paths) {
//        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) return YES;
//    }
//    
//    FILE *bash = fopen("/bin/bash", "r");
//    if (bash != NULL) {
//        fclose(bash);
//        return YES;
//    }
//    
//    NSString *path = [NSString stringWithFormat:@"/private/%@", [NSString stringWithUUID]];
//    if ([@"test" writeToFile : path atomically : YES encoding : NSUTF8StringEncoding error : NULL]) {
//        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
//        return YES;
//    }
//    
//    return NO;
//}

#endif /* BAKit_DefineApp_h */
