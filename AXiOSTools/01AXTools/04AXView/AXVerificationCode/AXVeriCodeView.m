//
//  AXVeriCodeView.m
//  BigApple
//
//  Created by liuweixing on 2017/8/3.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import "AXVeriCodeView.h"

#define RandomColor [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha: 1]

#define defaultCodeCount 4


typedef void(^ShowCodeBlock)(NSString *code);

@interface AXVeriCodeView ()

@property (nonatomic, copy) ShowCodeBlock showCodeBlock;

/**
 * 显示的字符串
 */
@property (nonatomic, copy) NSMutableString *codeString;

/**
 * 默认的字符串集合
 */
@property (nonatomic, copy) NSArray *defaultCodeArray;

@end

@implementation AXVeriCodeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.codeArray = self.defaultCodeArray;
        self.codeCount = 4;
        [self chooseCode];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)]];
    }
    return self;
}

- (void)tapGesture {
    [self chooseCode];
    [self setNeedsDisplay];
}

/**
 * 刷新
 */
- (void)refreshCode{
    [self tapGesture];
}


/**
 * 生成code
 */
- (void)chooseCode {
    
    self.codeString = [[NSMutableString alloc] initWithCapacity:self.codeCount];
    
    for(NSInteger i = 0; i < self.codeCount; i++) {
        NSInteger index = arc4random() % (self.codeArray.count);
        NSString *getStr = self.codeArray[index];
        [self.codeString appendString:getStr];
    }
    
}

#pragma mark - 绘制界面
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.backgroundColor = RandomColor;
    CGFloat rectWidth = rect.size.width;
    CGFloat rectHeight = rect.size.height;
    CGFloat pointX, pointY;
    
    NSString *text = self.codeString.copy;
    
    NSInteger charWidth = rectWidth / text.length - 15;
    NSInteger charHeight = rectHeight - 25;
    
    // 依次绘制文字
    for (NSInteger i = 0; i < text.length; i++) {
        // 文字X坐标
        pointX = arc4random() % charWidth + rectWidth / text.length * i;
        // 文字Y坐标
        pointY = arc4random() % charHeight;
        
        NSString *textStr = [text substringWithRange:NSMakeRange(i, 1)];
        
        [textStr drawAtPoint:CGPointMake(pointX, pointY) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:arc4random() % 10 + 15],NSForegroundColorAttributeName:RandomColor}];
    }
    
    // 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置线宽
    CGContextSetLineWidth(context, 1.0);
    
    // 依次绘制直线
    for(NSInteger i = 0; i < self.codeCount; i++) {
        // 设置线的颜色
        CGContextSetStrokeColorWithColor(context, RandomColor.CGColor);
        // 设置线的起点
        pointX = arc4random() % (NSInteger)rectWidth;
        pointY = arc4random() % (NSInteger)rectHeight;
        CGContextMoveToPoint(context, pointX, pointY);
        // 设置线的终点
        pointX = arc4random() % (NSInteger)rectWidth;
        pointY = arc4random() % (NSInteger)rectHeight;
        CGContextAddLineToPoint(context, pointX, pointY);
        // 绘画路径
        CGContextStrokePath(context);
    }
    
    if (self.showCodeBlock) {
        self.showCodeBlock([NSString stringWithString: self.codeString]);
        
    }
}

#pragma mark - Lazy loading

- (void)setCodeArray:(NSArray *)codeArray{
    
    if (codeArray != nil) {
        _codeArray = codeArray;
        [self tapGesture];
    }
    
}

- (void)setCodeCount:(NSInteger)codeCount{
    
    if (codeCount>0) {
        _codeCount = codeCount;
        [self tapGesture];
    }
}


- (NSArray *)defaultCodeArray {
    if (!_defaultCodeArray) {
        _defaultCodeArray =  [self numbernAndAlphabet];
        
    }
    return _defaultCodeArray;
}




- (void)didShowCode:(void(^)(NSString *code))did{
    self.showCodeBlock = did;
}



/**
 * 0-9 a-z A-Z 集合
 */
- (NSArray *)numbernAndAlphabet{
    
    NSMutableArray *temp = [NSMutableArray array];
    
    //0-9
    for(int index=48; index<=57; index++) {
        unichar ch =index;
        NSString *str =[NSString stringWithUTF8String:(char *)&ch];
        [temp addObject:str];
    }
    
    
    //小写字母
    for(int index=97; index<=122; index++) {
        unichar ch =index;
        NSString *str =[NSString stringWithUTF8String:(char *)&ch];
        [temp addObject:str];
    }
    
    //大写字母
    for(int index=65; index<=90; index++) {
        unichar ch =index;
        NSString *str =[NSString stringWithUTF8String:(char *)&ch];
        [temp addObject:str];
    }
    
    return temp.copy;
    
}


@end
