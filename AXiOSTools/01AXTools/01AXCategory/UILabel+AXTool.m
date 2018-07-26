//
//  UILabel+AXTool.m
//
//
//  Created by liuweixing on 15/10/27.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import "UILabel+AXTool.h"
#import <objc/runtime.h>
#import "AXMacros.h"
#import "NSString+AXEffective.h"
#import "UIView+AXTool.h"

@implementation UILabel (AXTool)

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copyText:));
}

- (void)attachTapHandler {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *g = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:g];
}

//  处理手势相应事件
- (void)handleTap:(UIGestureRecognizer *)g {
    [self becomeFirstResponder];
    
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:AXToolsLocalizedString(@"ax.copy") action:@selector(copyText:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:item]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    
}
//  复制时执行的方法
- (void)copyText:(id)sender {
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        if (self.text) {
            pBoard.string = self.text;
        } else {
            pBoard.string = self.attributedText.string;
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return [objc_getAssociatedObject(self, @selector(axCopyable)) boolValue];
}

- (void)setAxCopyable:(BOOL)number {
    objc_setAssociatedObject(self, @selector(axCopyable), [NSNumber numberWithBool:number], OBJC_ASSOCIATION_ASSIGN);
    [self attachTapHandler];
}

- (BOOL)axCopyable {
    return [objc_getAssociatedObject(self, @selector(axCopyable)) boolValue];
}


/**
 设置 电话 含有下划线,并可以点击打电话
 */
- (void)ax_setPhoneCall{
    
    NSString *labelStr = self.text;
    UILabel *label = self;
    
    //获取字符串中的电话号码
    NSString *regulaStr = @"\\d{3,4}[- ]?\\d{7,8}";
    NSRange stringRange = NSMakeRange(0, labelStr.length);
    //正则匹配
    NSError *error;
    NSRegularExpression *regexps = [NSRegularExpression regularExpressionWithPattern:regulaStr options:0 error:&error];
    if (!error && regexps != nil) {
        [regexps enumerateMatchesInString:labelStr options:0 range:stringRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            
            //可能为电话号码的字符串及其所在位置
            NSRange phoneRange = result.range;
            
            //设置文本中的电话号码显示为蓝色
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:labelStr];
            NSDictionary *dcit = @{
                                   //添加下划线
                                   NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                                   
                                   // 文字颜色
                                   NSForegroundColorAttributeName:[UIColor blueColor],
                                   
                                   //下划线颜色
                                   NSUnderlineColorAttributeName:[UIColor blueColor]
                                   };
            [str addAttributes:dcit range:phoneRange];
            label.attributedText = str;
            NSString *phoneStr = [labelStr substringWithRange:phoneRange];
            [self ax_addViewTargetActionBlock:^(UIView *view) {
                ax_CallTel(phoneStr);
            }];
            
        }];
    }
}

- (void)ax_setTextWithLinkAttribute:(NSString *)text {
    self.userInteractionEnabled = YES;
    
    self.attributedText = [self subStr:text];
    
}


- (NSMutableAttributedString*)subStr:(NSString *)string

{
    
    NSError *error;
    
    //可以识别url的正则表达式
    
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    
//    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\d+)?(/[a-zA-Z0-9\.\-~!@#%^&+?:_/=<>])?)";
    
     
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                  
                                                                           options:NSRegularExpressionCaseInsensitive
                                  
                                                                             error:&error];
    
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    
    NSMutableArray *rangeArr=[[NSMutableArray alloc]init];
    
    
    for (NSTextCheckingResult *match in arrayOfAllMatches) {
        
        NSString* substringForMatch;
        
        substringForMatch = [string substringWithRange:match.range];
        
        [arr addObject:substringForMatch];
        
        
    }
    
    NSString *subStr=string;
    
    for (NSString *str in arr) {
        
        [rangeArr addObject:[self rangesOfString:str inString:subStr]];
        
    }
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]initWithString:subStr];
    
    
    for(NSValue *value in rangeArr)
        
    {
        
        NSInteger index=[rangeArr indexOfObject:value];
        
        NSRange range=[value rangeValue];
        
        
        NSDictionary *dcit = @{
                               NSLinkAttributeName : [NSURL URLWithString:[arr objectAtIndex:index]],
                               //添加下划线
                               NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                               
                               // 文字颜色
                               NSForegroundColorAttributeName:[UIColor blueColor],
                               
                               //下划线颜色
                               NSUnderlineColorAttributeName:[UIColor blueColor]
                               };
        [attributedText  addAttributes:dcit range:range];
        
    }
    
    return attributedText;
    
    
    
}

//获取查找字符串在母串中的NSRange

- (NSValue *)rangesOfString:(NSString *)searchString inString:(NSString *)str {
    
    
    NSRange searchRange = NSMakeRange(0, [str length]);
    
    
    NSRange range;
    
    
    if ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
        
    }
    
    return [NSValue valueWithRange:range];
    
}


@end
