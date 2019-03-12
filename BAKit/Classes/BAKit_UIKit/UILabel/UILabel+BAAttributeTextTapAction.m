//
//  UILabel+BAAttributeTextTapAction.m
//  testDemo
//
//  Created by 博爱 on 2016/11/7.
//  Copyright © 2016年 DS-Team. All rights reserved.
//

#import "UILabel+BAAttributeTextTapAction.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>
#import <Foundation/Foundation.h>
#import "BAKit_DefineCommon.h"

@implementation BAAttributeModel

@end

@implementation UILabel (BAAttributeTextTapAction)

#pragma mark - AssociatedObjects

- (NSMutableArray *)attributeStrings
{
    return BAKit_Objc_getObj;
}

- (void)setAttributeStrings:(NSMutableArray *)attributeStrings
{
    BAKit_Objc_setObj(@selector(attributeStrings), attributeStrings);
}

- (NSMutableDictionary *)effectDic
{
    return BAKit_Objc_getObj;
}

- (void)setEffectDic:(NSMutableDictionary *)effectDic
{
    BAKit_Objc_setObj(@selector(effectDic), effectDic);
}

- (BOOL)isTapAction
{
    return [BAKit_Objc_getObj boolValue];
}

- (void)setIsTapAction:(BOOL)isTapAction
{
    BAKit_Objc_setObj(@selector(isTapAction), @(isTapAction));
}

- (void (^)(NSString *, NSRange, NSInteger))tapBlock
{
    return BAKit_Objc_getObj;
}

- (void)setTapBlock:(void (^)(NSString *, NSRange, NSInteger))tapBlock
{
    BAKit_Objc_setObjCOPY(@selector(tapBlock), tapBlock);
}

- (id<BAAttributeTapActionDelegate>)delegate
{
    return BAKit_Objc_getObj;
}

- (BOOL)enabledTapEffect
{
    return [BAKit_Objc_getObj boolValue];
}

- (void)setEnabledTapEffect:(BOOL)enabledTapEffect
{
    BAKit_Objc_setObj(@selector(enabledTapEffect), @(enabledTapEffect));

    self.isTapEffect = enabledTapEffect;
}

- (BOOL)isTapEffect
{
    return BAKit_Objc_getObj;
}

- (void)setIsTapEffect:(BOOL)isTapEffect
{
    BAKit_Objc_setObj(@selector(isTapEffect), @(isTapEffect));
}

- (void)setDelegate:(id<BAAttributeTapActionDelegate>)delegate
{
    BAKit_Objc_setObj(@selector(delegate), delegate);
}

#pragma mark - mainFunction
- (void)ba_labelAddAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                      tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick
{
    [self ba_getRangesWithStrings:strings];
    
    if (self.tapBlock != tapClick)
    {
        self.tapBlock = tapClick;
    }
}

- (void)ba_labelAddAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                        delegate:(id <BAAttributeTapActionDelegate> )delegate
{
    [self ba_getRangesWithStrings:strings];
    
    if (self.delegate != delegate)
    {
        self.delegate = delegate;
    }
}

#pragma mark - touchAction
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.isTapAction)
    {
        return;
    }
    
    if (objc_getAssociatedObject(self, @selector(enabledTapEffect)))
    {
        self.isTapEffect = self.enabledTapEffect;
    }
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    __weak typeof(self) weakSelf = self;
    
    [self ba_getTapFrameWithTouchPoint:point result:^(NSString *string, NSRange range, NSInteger index) {
        
        if (weakSelf.tapBlock) {
            weakSelf.tapBlock (string , range , index);
        }
        
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(ba_attributeTapReturnString:range:index:)]) {
            [weakSelf.delegate ba_attributeTapReturnString:string range:range index:index];
        }
        
        if (self.isTapEffect) {
            
            [self ba_saveEffectDicWithRange:range];
            
            [self ba_tapEffectWithStatus:YES];
        }
        
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.isTapAction) {
        if ([self ba_getTapFrameWithTouchPoint:point result:nil]) {
            return self;
        }
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - getTapFrame
- (BOOL)ba_getTapFrameWithTouchPoint:(CGPoint)point result:(void (^) (NSString *string , NSRange range , NSInteger index))resultBlock
{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributedText);
    
    CGMutablePathRef Path = CGPathCreateMutable();
    
    CGPathAddRect(Path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    
    CFRange range = CTFrameGetVisibleStringRange(frame);
    
    if (self.attributedText.length > range.length) {
        
        UIFont *font ;
        
        if ([self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:nil]) {
            
            font = [self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:nil];
            
        }else if (self.font){
            font = self.font;
            
        }else {
            font = [UIFont systemFontOfSize:17];
        }
        
        Path = CGPathCreateMutable();
        
        CGPathAddRect(Path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + font.lineHeight));
        
        frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    }
    
    CFArrayRef lines = CTFrameGetLines(frame);
    
    if (!lines) {
        return NO;
    }
    
    CFIndex count = CFArrayGetCount(lines);
    
    CGPoint origins[count];
    
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    
    CGAffineTransform transform = [self BA_transformForCoreText];
    
    CGFloat verticalOffset = 0;
    
    for (CFIndex i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        
        CGRect flippedRect = [self BA_getLineBounds:line point:linePoint];
        
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        
        rect = CGRectInset(rect, 0, 0);
        
        rect = CGRectOffset(rect, 0, verticalOffset);
        
        NSParagraphStyle *style = [self.attributedText attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:nil];
        
        CGFloat lineSpace;
        
        if (style) {
            lineSpace = style.lineSpacing;
        }else {
            lineSpace = 0;
        }
        
        CGFloat lineOutSpace = (self.bounds.size.height - lineSpace * (count - 1) -rect.size.height * count) / 2;
        
        rect.origin.y = lineOutSpace + rect.size.height * i + lineSpace * i;
        
        if (CGRectContainsPoint(rect, point)) {
            
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));

            CFIndex index = CTLineGetStringIndexForPosition(line, relativePoint);
            
            CGFloat offset;
            
            CTLineGetOffsetForStringIndex(line, index, &offset);
            
            if (offset > relativePoint.x) {
                index = index - 1;
            }
            
            NSInteger link_count = self.attributeStrings.count;
            
            for (int j = 0; j < link_count; j++) {
                
                BAAttributeModel *model = self.attributeStrings[j];
                
                NSRange link_range = model.range;
                if (NSLocationInRange(index, link_range)) {
                    if (resultBlock) {
                        resultBlock (model.str , model.range , (NSInteger)j);
                    }
                    return YES;
                }
            }
        }
    }
    return NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isTapEffect) {
        
        [self performSelectorOnMainThread:@selector(ba_tapEffectWithStatus:) withObject:nil waitUntilDone:NO];
        
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isTapEffect) {

        [self performSelectorOnMainThread:@selector(ba_tapEffectWithStatus:) withObject:nil waitUntilDone:NO];
        
    }
}

- (CGAffineTransform)BA_transformForCoreText
{
    return CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.f, -1.f);
}

- (CGRect)BA_getLineBounds:(CTLineRef)line point:(CGPoint)point
{
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + fabs(descent) + leading;
    
    return CGRectMake(point.x, point.y , width, height);
}

#pragma mark - tapEffect
- (void)ba_tapEffectWithStatus:(BOOL)status
{
    if (self.isTapEffect) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        
        NSMutableAttributedString *subAtt = [[NSMutableAttributedString alloc] initWithAttributedString:[[self.effectDic allValues] firstObject]];
        
        NSRange range = NSRangeFromString([[self.effectDic allKeys] firstObject]);
        
        if (status) {
            [subAtt addAttribute:NSBackgroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, subAtt.string.length)];
            
            [attStr replaceCharactersInRange:range withAttributedString:subAtt];
        }else {
            
            [attStr replaceCharactersInRange:range withAttributedString:subAtt];
        }
        self.attributedText = attStr;
    }
}

- (void)ba_saveEffectDicWithRange:(NSRange)range
{
    self.effectDic = [NSMutableDictionary dictionary];
    
    NSAttributedString *subAttribute = [self.attributedText attributedSubstringFromRange:range];
    
    [self.effectDic setObject:subAttribute forKey:NSStringFromRange(range)];
}

#pragma mark - getRange
- (void)ba_getRangesWithStrings:(NSArray <NSString *>  *)strings
{
    if (self.attributedText == nil) {
        self.isTapAction = NO;
        return;
    }
 
    self.isTapAction = YES;
    
    self.isTapEffect = YES;
    
    __block  NSString *totalStr = self.attributedText.string;
    
    self.attributeStrings = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;
    
    [strings enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSRange range = [totalStr rangeOfString:obj];
        
        if (range.length != 0) {
            
            totalStr = [totalStr stringByReplacingCharactersInRange:range withString:[weakSelf ba_getStringWithRange:range]];
            
            BAAttributeModel *model = [BAAttributeModel new];
            
            model.range = range;
            
            model.str = obj;
            
            [weakSelf.attributeStrings addObject:model];
            
        }
        
    }];
}

- (NSString *)ba_getStringWithRange:(NSRange)range
{
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < range.length ; i++) {
        
        [string appendString:@" "];
    }
    return string;
}

@end
