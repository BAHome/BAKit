
/*!
 *  @header BAKit.h
 *          BABaseProject
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright    Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 在使用BAKit的过程中如果出现bug请及时以以下任意一种方式联系我，我会及时修复bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * 博客    : http://boaihome.com
 
 *********************************************************************************
 
 */


#import "BAKit_LocationManager.h"

//#import "BAKit_DefineCommon.h"

@interface BAKit_LocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation BAKit_LocationManager
BAKit_SingletonM()

- (void)ba_loaction_start
{
    // 如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
//    else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
//    {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestAlwaysAuthorization ];
        [self.locationManager  requestWhenInUseAuthorization];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;//精准度
        //    定位精度，枚举类型：
        //    kCLLocationAccuracyBest：最精确定位
        //    CLLocationAccuracy kCLLocationAccuracyNearestTenMeters：十米误差范围
        //kCLLocationAccuracyHundredMeters:百米误差范围
        //kCLLocationAccuracyKilometer:千米误差范围
        //kCLLocationAccuracyThreeKilometers:三千米误差范围
        //    位置信息更新最小距离，只有移动大于这个距离才更新位置信息，默认为kCLDistanceFilterNone：不进行距离限制
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 8.0)
        {
            // 以下方法选择其中一个
            // 请求始终授权   无论app在前台或者后台都会定位
            //  [locationManager requestAlwaysAuthorization];
            // 当app使用期间授权    只有app在前台时候才可以授权
            [self.locationManager requestWhenInUseAuthorization];
        }
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)
        {
            // 一定要勾选后台模式 location updates 否者程序奔溃, 注意:只要是想后台获取用户的位置,就必须开启后台模式 项目->TARGETS->Capabilities-> Background Modes 勾线 Location updates
            //                self.locationManager.allowsBackgroundLocationUpdates = YES;
        }
//    }
    
    if ([CLLocationManager locationServicesEnabled])
    {
        NSLog(@"定位服务已经打开!");
        //    位置信息更新最小距离，只有移动大于这个距离才更新位置信息，默认为kCLDistanceFilterNone：不进行距离限制
        [BAKit_LocationManager.shared.locationManager startUpdatingLocation];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}

- (void)ba_loaction_stop
{
    [self.locationManager stopUpdatingLocation];
    [self.locationManager stopMonitoringSignificantLocationChanges];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - CLLocationManagerDelegate
#pragma mark 位置发生改变后执行
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations
{
    /*
     经纬度
     @property(readonly, nonatomic) CLLocationCoordinate2D coordinate;
     海拔
     @property(readonly, nonatomic) CLLocationDistance altitude;
     航向
     @property(readonly, nonatomic) CLLocationAccuracy course;
     速度
     @property(readonly, nonatomic) CLLocationSpeed speed
     */
    CLLocation *location = locations.firstObject;
    NSLog(@"%f  %f",location.coordinate.latitude, location.coordinate.longitude);

//    BAKit_WeakSelf

//    if (self.locatingBlock)
//    {
//        self.locatingBlock();
//    }
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
//        BAKit_StrongSelf
        
        CLPlacemark *placemark = [placemarks firstObject];
        NSString *address = [NSString stringWithFormat:@"cityName:%@,longitude:%f,latitude:%f",placemark.locality, placemark.location.coordinate.longitude, placemark.location.coordinate.latitude];
        NSLog(address);
//        CLLocation *location = placemark.location;//位置
//        CLRegion *region = placemark.region;//区域
//        NSDictionary *addressDic = placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
//        //        CLPlacemark *placemark = [placemarks firstObject];
//        //        placemark.addressDictionary
//        NSString *name = placemark.name;//地名
//        NSString *thoroughfare = placemark.thoroughfare;//街道
//        NSString *subThoroughfare = placemark.subThoroughfare; //街道相关信息，例如门牌等
//        NSString *locality = placemark.locality; // 城市
//        NSString *subLocality = placemark.subLocality; // 城市相关信息，例如标志性建筑
//        NSString *administrativeArea = placemark.administrativeArea; // 州
//        NSString *subAdministrativeArea = placemark.subAdministrativeArea; //其他行政区域信息
//        NSString *postalCode = placemark.postalCode; //邮编
//        NSString *ISOcountryCode = placemark.ISOcountryCode; //国家编码
//        NSString *country = placemark.country; //国家
//        NSString *inlandWater = placemark.inlandWater; //水源、湖泊
//        NSString *ocean = placemark.ocean; // 海洋
//        NSArray *areasOfInterest = placemark.areasOfInterest; //关联的或利益相关的地标
        
        if (BAKit_LocationManager.shared.getCurrentLocationBlock)
        {
            BAKit_LocationManager.shared.getCurrentLocationBlock(placemark);
        }
        
//        for (CLPlacemark * placemark in placemarks)
//        {
////            NSDictionary *location = [placemark addressDictionary];
////            static dispatch_once_t onceToken;
////            dispatch_once(&onceToken, ^{
//                if (self.getCurrentLocationBlock)
//                {
//                    self.getCurrentLocationBlock(placemark);
//                }
////            });
//        }
    }];
    [BAKit_LocationManager.shared ba_loaction_stop];
}

#pragma mark 导航方向发生变化后执行
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    
}

#pragma mark 进入某个区域
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    
}

#pragma mark 走出某个区域之后执行
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied)
    {
        if (BAKit_LocationManager.shared.refuseToUsePositioningSystemBlock)
        {
            BAKit_LocationManager.shared.refuseToUsePositioningSystemBlock(@"已拒绝使用系统定位！");
        }
    }
    else if ([error code] == kCLErrorLocationUnknown)
    {
        if (BAKit_LocationManager.shared.locateFailureBlock)
        {
            BAKit_LocationManager.shared.locateFailureBlock(@"无法获取位置信息！");
        }
    }
    [BAKit_LocationManager.shared ba_loaction_stop];
}

#pragma mark 授权状态发生改变时调用
// 第一次弹出请求定位权限会执行该代码块 用户如果点击 "不允许"  执行"定位开启，但被拒", 若点击 "允许" 执行 获取前后台定位授权 或者 获取前后台定位授权 如果在设置 设置隐私 定位服务 "永不" 则执 "行定位开启，但被拒"
// 注意:在设置点击了"永不"之后不返回应用在切换后台跟前台选项是不会执行该代理方法的 当返回应用之后 才会对做出的改变执行代理方法
// 关闭定位服务会执行 定位关闭，"不可用" 系统默认弹出弹框 提示用户去设置中打开定位服务选项
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
            // 用户还未决定
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定");
            
            break;
        }
            // 访问受限
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
            // 定位关闭时和对此APP授权为never时调用
        case kCLAuthorizationStatusDenied:
        {
            // 定位是否可用（是否支持定位或者定位是否开启）
            if([CLLocationManager locationServicesEnabled])
            {
                NSLog(@"定位开启，但被拒");
            }
            else
            {
                NSLog(@"定位关闭，不可用, 请在设置中打开定位服务选项");
            }
            //            NSLog(@"被拒");
            break;
        }
            // 获取前后台定位授权
        case kCLAuthorizationStatusAuthorizedAlways:
            //        case kCLAuthorizationStatusAuthorized: // 失效，不建议使用
        {
            NSLog(@"获取前后台定位授权");
            break;
        }
            // 获得前台定位授权
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台定位授权");
            break;
        }
    }
}

//#pragma mark - setter, getter
//- (CLLocationManager *)locationManager
//{
//    if (!_locationManager) {
//
//        if ([CLLocationManager locationServicesEnabled])
//        {
//            NSLog(@"定位服务已经打开!");
//        }
//        // 如果没有授权则请求用户授权
//        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
//        {
//            [self.locationManager requestWhenInUseAuthorization];
//        }
//        else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
//        {
//            self.locationManager = [[CLLocationManager alloc] init];
//            [self.locationManager requestAlwaysAuthorization ];
//            [self.locationManager  requestWhenInUseAuthorization];
//            self.locationManager.delegate = self;
//            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;//精准度
//            //    定位精度，枚举类型：
//            //    kCLLocationAccuracyBest：最精确定位
//            //    CLLocationAccuracy kCLLocationAccuracyNearestTenMeters：十米误差范围
//            //kCLLocationAccuracyHundredMeters:百米误差范围
//            //kCLLocationAccuracyKilometer:千米误差范围
//            //kCLLocationAccuracyThreeKilometers:三千米误差范围
//            //    位置信息更新最小距离，只有移动大于这个距离才更新位置信息，默认为kCLDistanceFilterNone：不进行距离限制
//            self.locationManager.distanceFilter = kCLDistanceFilterNone;
//
//            if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 8.0)
//            {
//                // 以下方法选择其中一个
//                // 请求始终授权   无论app在前台或者后台都会定位
//                //  [locationManager requestAlwaysAuthorization];
//                // 当app使用期间授权    只有app在前台时候才可以授权
//                [self.locationManager requestWhenInUseAuthorization];
//            }
//
//            if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)
//            {
//                // 一定要勾选后台模式 location updates 否者程序奔溃, 注意:只要是想后台获取用户的位置,就必须开启后台模式 项目->TARGETS->Capabilities-> Background Modes 勾线 Location updates
////                self.locationManager.allowsBackgroundLocationUpdates = YES;
//            }
//        }
//    }
//    return _locationManager;
//}

- (void)dealloc
{
    BAKit_LocationManager.shared.locationManager = nil;
    [BAKit_LocationManager.shared ba_loaction_stop];
}

@end
