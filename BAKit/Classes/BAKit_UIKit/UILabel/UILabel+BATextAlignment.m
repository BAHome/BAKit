//
//  UILabel+BATextAlignment.m
//  BAKit
//
//  Created by 孙博岩 on 2019/1/30.
//

#import "UILabel+BATextAlignment.h"
#import <CoreText/CoreText.h>

@implementation UILabel (BATextAlignment)

- (void)ba_textAlignmentLeftAndRight
{
    [self ba_textAlignmentLeftAndRightWithWidth:CGRectGetWidth(self.frame)];
}

- (void)ba_textAlignmentLeftAndRightWithWidth:(CGFloat)labelWidth
{
    if(self.text==nil||self.text.length==0)
    {
        return;
    }
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(labelWidth,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil].size;
    NSInteger length = (self.text.length-1);
    NSString* lastStr = [self.text substringWithRange:NSMakeRange(self.text.length-1,1)];
    if([lastStr isEqualToString:@":"]||[lastStr isEqualToString:@"："]) {
        length = (self.text.length-2);
    }
    CGFloat margin = (labelWidth - size.width)/length;
    NSNumber*number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attribute addAttribute:NSKernAttributeName value:number range:NSMakeRange(0,length)];
    self.attributedText= attribute;
}

@end
