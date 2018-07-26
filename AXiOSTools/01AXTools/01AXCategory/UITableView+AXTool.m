//
//  UITableView+AXTool.m
//  AXiOSTools
//
//  Created by liuweixing on 16/8/23.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "UITableView+AXTool.h"
#import "AXConstant.h"
@implementation UITableView (AXTool)


/**
 UITableView 注册 NibCell

 @param nib nib
 @param identifier identifier
 */
- (void)ax_registerNibCell:(NSString *)nib identifier:(NSString * )identifier{
    [self registerNib:[UINib nibWithNibName:nib bundle:nil] forCellReuseIdentifier:identifier];
}


/**
 UITableView 注册 NibCell 默认使用 axCellID identifier

 @param nibName nib名称
 */
- (void)ax_registerNibCell:(NSString *)nibName{
    
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil]forCellReuseIdentifier:axCellID];
}

/**
  UITableView 注册 ClassCell 默认使用 axCellID identifier

 @param aClass Class
 */
- (void)ax_registerClassCell:(Class )aClass{
    [self registerClass:aClass forCellReuseIdentifier:axCellID];
    
}


/**
 UITableView dequeueReusableCel 默认使用 axCellID identifier

 @param indexPath indexPath
 @return UITableViewCell
 */
- (__kindof UITableViewCell *)ax_dequeueReusableCellWithIndexPath:(NSIndexPath *)indexPath{
    
   return [self dequeueReusableCellWithIdentifier:axCellID forIndexPath:indexPath];
}


/**
 UITableView 注册 section Header
 计算是自定义的xib也得用class方法

 @param aClass Class
 */
- (void)ax_registerHeaderWithClass:(Class )aClass{
    [self registerClass:aClass forHeaderFooterViewReuseIdentifier:axCellHeadID];;
}

/**
 UITableView dequeueReusableHeaderFooterView axCellHeadID

 @return UITableViewHeaderFooterView
 */
- (nullable __kindof UITableViewHeaderFooterView *)ax_dequeueReusableHeader{
   return [self dequeueReusableHeaderFooterViewWithIdentifier:axCellHeadID];
}

/**
 UITableView 注册 section Footer
 计算是自定义的xib也得用class方法
 
 @param aClass Class
 */
- (void)ax_registerFooterWithClass:(Class )aClass{
    [self registerClass:aClass forHeaderFooterViewReuseIdentifier:axCellFootID];;
}

/**
 UITableView dequeueReusableHeaderFooterView axCellHeadID
 
 @return UITableViewHeaderFooterView
 */
- (nullable __kindof UITableViewHeaderFooterView *)ax_dequeueReusableFooter{
    return [self dequeueReusableHeaderFooterViewWithIdentifier:axCellFootID];
}


- (void)ax_footerViewZero{
    self.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

@end
