//
//  YYLabel+AXTool.m
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/5/19.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "YYLabel+AXTool.h"

@implementation YYLabel (AXTool)

- (void)ax_sethighlightText:(NSString *)text{
    
    self.attributedText = [self regionAt_manager:text];
}


- (NSMutableAttributedString *)regionAt_manager:(NSString *)str{
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:str];
    //    [text yy_setFont:[UIFont systemFontOfSize:12.0f] range:text.yy_rangeOfAll];
    
    
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName:[UIColor blueColor],
                           NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                           NSUnderlineColorAttributeName:[UIColor blueColor]
                           };
    
    YYTextBorder *border = [[YYTextBorder alloc]init];
    border.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    border.cornerRadius = 3;
    border.fillColor = [UIColor clearColor];
    
    
    // @某某某
    NSArray *resultArra = [[self regexAt] matchesInString:text.string options:kNilOptions range:text.yy_rangeOfAll];
    for (NSTextCheckingResult *at in resultArra) {
        
        if (at.range.length<=1) {
            
            continue;
            
        }
        if ([text yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil) {
            
//            [text yy_setColor:[UIColor redColor] range:at.range];
            YYTextHighlight *highLight = [[YYTextHighlight alloc]init];
            
#warning 注意: at.range.location是加还是减，at.range.length是加还是减
            highLight.userInfo = @{@"type":@"@",
                                   @"value":[text.string substringWithRange:NSMakeRange(at.range.location + 1, at.range.length - 1)]};
            [highLight setBorder:border];
            [text yy_setTextHighlight:highLight range:at.range];
            [text addAttributes:dict range:at.range];
        }
    }
    
    
    // #话题数组
    NSArray *resultTopic = [[self regexTopic] matchesInString:text.string options:kNilOptions range:text.yy_rangeOfAll];
    for (NSTextCheckingResult *at in resultTopic)
    {
        if (at.range.location == NSNotFound && at.range.length <= 1)
        {
            continue;
        }
        
        if ([text yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil)
        {
//            [text yy_setColor:[UIColor blueColor] range:at.range];
            
            
            YYTextHighlight *highlight = [[YYTextHighlight alloc]init];
            highlight.userInfo = @{@"type":@"#",
                                   @"value":[text.string substringWithRange:NSMakeRange(at.range.location + 1, at.range.length - 2)]};
            [highlight setBackgroundBorder:border];
            
            
            [text yy_setTextHighlight:highlight range:at.range];
             [text addAttributes:dict range:at.range];
        }
    }
    
    
    // 网址链接数组
    NSArray *resultLink = [[self regexUrl] matchesInString:text.string options:kNilOptions range:text.yy_rangeOfAll];
    for (NSTextCheckingResult *at in resultLink)
    {
        if (at.range.location == NSNotFound && at.range.length <= 1)
        {
            continue;
        }
        
        if ([text yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil)
        {
//            [text yy_setColor:[UIColor blueColor] range:at.range];
            
            YYTextHighlight *highlight = [[YYTextHighlight alloc]init];
            [highlight setBackgroundBorder:border];
            highlight.userInfo = @{@"type":@"url",
                                   @"value":[text.string substringWithRange:NSMakeRange(at.range.location , at.range.length )]};
            [text yy_setTextHighlight:highlight range:at.range];
             [text addAttributes:dict range:at.range];
        }
    }
    
    
    // 手机号
    NSArray *resultPhone = [[self regexPhone] matchesInString:text.string options:kNilOptions range:text.yy_rangeOfAll];
    for (NSTextCheckingResult *at in resultPhone) {
        
        if (at.range.location == NSNotFound && at.range.length <= 1) {
            continue;
        }
        
        if ([text yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil){
            
            YYTextHighlight *highlight = [[YYTextHighlight alloc]init];
            [highlight setBackgroundBorder:border];
            highlight.userInfo = @{@"type":@"phone",
                                   @"value":[text.string substringWithRange:NSMakeRange(at.range.location , at.range.length )]};
            [text yy_setTextHighlight:highlight range:at.range];
            
            [text addAttributes:dict range:at.range];
            
        }
    }
    
    
    // 邮箱
    NSArray *resultEmail = [[self regexEmail] matchesInString:text.string options:kNilOptions range:text.yy_rangeOfAll];
    for (NSTextCheckingResult *at in resultEmail) {
        
        if (at.range.location == NSNotFound && at.range.length <= 1) {
            continue;
        }
        
        if ([text yy_attribute:YYTextHighlightAttributeName atIndex:at.range.location] == nil)
        {
            [text yy_setColor:[UIColor blueColor] range:at.range];
            
            YYTextHighlight *highlight = [[YYTextHighlight alloc]init];
            [highlight setBackgroundBorder:border];
            highlight.userInfo = @{
                                   @"type":@"email",
                                   @"value":[text.string substringWithRange:NSMakeRange(at.range.location , at.range.length )]
                                   
                                   };
            [text yy_setTextHighlight:highlight range:at.range];
        }
    }
    
    
    return text;
}



- (NSMutableAttributedString *)emotionAct{
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"星期天很高兴:smile::cry::hehe:有一个星期天:smile::cry::hehe:"];
    [text setYy_color:[UIColor blackColor]];
    [text setYy_font:[UIFont systemFontOfSize:30]];
    
    return text;
}


-(YYTextSimpleEmoticonParser *)emotionActPic{
    
    NSMutableDictionary *mapper = [NSMutableDictionary new];
    mapper[@":smile:"] = [self imageWithName:@"001@2x"];
    mapper[@":cry:"] = [self imageWithName:@"003@2x"];
    mapper[@":hehe:"] = [self imageWithName:@"004@2x"];
    
    YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
    parser.emoticonMapper = mapper;
    return parser;
}


- (UIImage *)imageWithName:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"EmoticonQQ" ofType:@"bundle"]];
    NSString *path = [bundle pathForResource:name ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    YYImage *image = [YYImage imageWithData:data scale:2];
    return image;
}



// 正则@某某某
- (NSRegularExpression *)regexAt
{
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        regex = [NSRegularExpression regularExpressionWithPattern:@"@[-_a-zA-Z0-9\u4E00-\u9FA5]+" options:kNilOptions error:NULL];
    });
    return regex;
}


// 正则#某个主题
- (NSRegularExpression *)regexTopic
{
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"#[^@#]+?#" options:kNilOptions error:NULL];
    });
    return regex;
}


// 正则URL
- (NSRegularExpression *)regexUrl
{
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)" options:kNilOptions error:NULL];
    });
    return regex;
}


// 正则手机号（13位，注意和邮箱匹配区分）
- (NSRegularExpression *)regexPhone
{
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"(\\(86\\))?(13[0-9]|15[0-35-9]|18[0125-9])\\d{8}" options:kNilOptions error:NULL];
    });
    return regex;
}



// 正则邮箱
- (NSRegularExpression *)regexEmail
{
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" options:kNilOptions error:NULL];
    });
    return regex;
}


@end
