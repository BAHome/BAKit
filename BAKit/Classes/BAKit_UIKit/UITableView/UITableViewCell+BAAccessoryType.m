
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


#import "UITableViewCell+BAAccessoryType.h"
#import "UIView+BAFrame.h"

@implementation UITableViewCell (BAAccessoryType)

- (void)ba_cellSetAccessoryImage:(UIImage *)image frame:(CGRect)frame
{
    if (image)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = frame;

//            imageView.frame = CGRectMake(BAKit_SCREEN_WIDTH - 40, 0, 20, 20);
        imageView.centerY = self.centerY;
        imageView.image = image;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.accessoryView = imageView;
    }
}

- (void)ba_cellSetAccessorySwitchWithIndexPath:(NSIndexPath *)indexPath
                                         frame:(CGRect)frame
                                   actionBlock:(BAKit_UITableViewCell_AccessoryTypeActionBlock)actionBlock
{
    [self.accessoryView removeFromSuperview];
    UISwitch *switcher;
    BOOL switcherOn = NO;
    if ([self.accessoryView isKindOfClass:[UISwitch class]])
    {
        switcher = (UISwitch *)self.accessoryView;
    }
    else
    {
        switcher = [[UISwitch alloc] init];
        switcher.frame = frame;
        switcher.tag = indexPath.row;
    }
    switcher.on = switcherOn;
    [switcher removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    self.accessoryView = switcher;
    if (actionBlock)
    {
        actionBlock(switcher);
    }
}

@end
