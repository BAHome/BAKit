//
//  BAKit_MGJRouterHerder.h
//  BAKit
//
//  Created by 孙博岩 on 2018/9/3.
//  Copyright © 2018 boai. All rights reserved.
//

#ifndef BAKit_MGJRouterHerder_h
#define BAKit_MGJRouterHerder_h

#import "BAKit_MGJRouter_Url.h"
#import "BAKit_MGJRouter_Manager.h"
#import "BAKit_MGJRouter_ModuleManager.h"
#import "BAKit_MGJRouter_Protocol.h"


/**
 * 注意：由于我们的路由遵循URL协议规范，不区分大小写，请使用小写定义路由路径: pagea_b_c
 * 有两种注册路由路径的方式：
 * 1、全路径：scheme://src/module/path
 *    对于非app来源及应用外路由，需要按照全路径格式注册路由
 *    如，H5路由：BAKit://h5
 * 2、模块路径：module/path
 *    对于app内模块路由，直接声明模块+页面路径，会自动使用默认schem和src补全路由路径
 *    如，通用组件扫一扫：common/scan，会补全为 BAKit://app/common/scan进行注册
 *
 */

#define BAKit_MGJRouter_Scheme_BAKit               @"BAKit"
#define BAKit_MGJRouter_Src_App                    @"app"
#define BAKit_MGJRouter_Src_H5                     @"h5"

#define BAKit_MGJRouter_Scheme_Default             BAKit_MGJRouter_Scheme_BAKit
#define BAKit_MGJRouter_Src_Default                BAKit_MGJRouter_Src_App
#define BAKit_MGJRouter_Module_Default             @""


#endif /* BAKit_MGJRouterHerder_h */
