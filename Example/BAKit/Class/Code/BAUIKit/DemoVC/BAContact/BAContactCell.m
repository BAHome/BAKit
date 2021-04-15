//
//  BAContactCell.m
//  BAKit_Example
//
//  Created by 孙博岩 on 2019/3/13.
//  Copyright © 2019 boai. All rights reserved.
//

#import "BAContactCell.h"
#import "BAContactsModel.h"
#import "UIImage+BARender.h"


@interface BAContactCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPhoneLabel;

@end

@implementation BAContactCell

- (void)setModel:(BAContactsModel *)model {
    _model = model;
    
    
    if (model.attributedUser_Name.length) {
        self.userNameLabel.attributedText = model.attributedUser_Name;
    } else if (model.user_Name.length) {
        self.userNameLabel.text = model.user_Name;
    }
    
    if (model.user_Image_url) {
        self.userImageView.image = [UIImage imageNamed:model.user_Image_url];
    } else if (model.user_Image) {
        self.userImageView.image = model.user_Image;
    }
    if (model.user_PhoneNumber) {
        self.userPhoneLabel.text = model.user_PhoneNumber;
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.userImageView ba_viewSetSystemCornerRadius:20];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
