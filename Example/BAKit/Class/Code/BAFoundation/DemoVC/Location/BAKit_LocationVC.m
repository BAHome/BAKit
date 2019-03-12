//
//  BAKit_LocationVC.m
//  BAKit
//
//  Created by 孙博岩 on 2018/9/26.
//  Copyright © 2018 boai. All rights reserved.
//

#import "BAKit_LocationVC.h"

@interface BAKit_LocationVC ()

@property(nonatomic, strong)  BAKit_LocationManager *location;

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)handleButtonActions:(UIButton *)sender;

@end

@implementation BAKit_LocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)ba_base_setupUI
{
    self.location = BAKit_LocationManager.shared;
    BAKit_WeakSelf
    self.location.getCurrentLocationBlock = ^(CLPlacemark *place) {
        BAKit_StrongSelf
        NSString *msg = [NSString stringWithFormat:@"当前地址：\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n%@\n\n", place.country, place.administrativeArea, place.locality, place.subLocality, place.subThoroughfare, place.name];
        
        NSLog(msg);
        self.textView.text = msg;
    };
    self.location.refuseToUsePositioningSystemBlock = ^(NSString *message) {
        BAKit_StrongSelf
        NSString *msg = [NSString stringWithFormat:@"当前状态：%@", message];
        
        NSLog(msg);
        self.textView.text = msg;
    };
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.location ba_loaction_start];
}


- (IBAction)handleButtonActions:(UIButton *)sender
{
    if (sender.tag == 0)
    {
        [self.location ba_loaction_start];
    }
    else if (sender.tag == 1)
    {
        [self.location ba_loaction_stop];
    }
}
@end
