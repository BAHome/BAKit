//
//  BADefine_APPVersion.h
//  BAKit
//
//  Created by 孙博岩 on 2019/1/31.
//  Copyright © 2019 boai. All rights reserved.
//

#ifndef BADefine_APPVersion_h
#define BADefine_APPVersion_h

#define BADefine_APPVersion_VersionString  [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]

#define BADefine_APPVersion_BuildString  [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey]

#define BADefine_APPVersion_VersionBuildString [NSString stringWithFormat:@"%@-%@", BADefine_APPVersion_VersionString, BADefine_APPVersion_BuildString]

//#define BADefine_APPVersion_BranchStr
//
//#define BADefine_APPVersion_UserEvnStr
//
//#define BADefine_APPVersion_FullStr


#endif /* BADefine_APPVersion_h */
