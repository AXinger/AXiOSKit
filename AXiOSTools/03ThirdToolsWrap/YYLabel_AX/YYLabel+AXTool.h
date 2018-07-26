//
//  YYLabel+AXTool.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/5/19.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "YYLabel.h"
#import "YYText.h"
#import "YYImage.h"

@interface YYLabel (AXTool)


/**
 YYLabel 对电话 url 显示高亮,配合 YYLabel highlightTapAction 点击事件

 @param text 当前文字
 */
- (void)ax_sethighlightText:(NSString *)text;


- (NSMutableAttributedString *)regionAt_manager:(NSString *)str;

- (NSMutableAttributedString *)emotionAct;

-(YYTextSimpleEmoticonParser *)emotionActPic;

@end
