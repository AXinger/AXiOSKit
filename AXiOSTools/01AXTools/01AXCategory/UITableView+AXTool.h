//
//  UITableView+AXTool.h
//  AXiOSTools
//
//  Created by liuweixing on 16/8/23.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (AXTool)

/**
 UITableView 注册 NibCell
 
 @param nib nib
 @param identifier identifier
 */
- (void)ax_registerNibCell:(NSString *_Nullable)nib identifier:(NSString *_Nullable )identifier;

/**
 UITableView 注册 NibCell 默认使用 axCellID identifier
 
 @param nibName nib名称
 */
- (void)ax_registerNibCell:(NSString *_Nullable)nibName;

/**
 UITableView 注册 ClassCell 默认使用 axCellID identifier
 
 @param aClass Class
 */
- (void)ax_registerClassCell:(Class _Nullable )aClass;

/**
 UITableView dequeueReusableCel 默认使用 axCellID identifier
 
 @param indexPath indexPath
 @return UITableViewCell
 */
- (__kindof UITableViewCell *_Nullable)ax_dequeueReusableCellWithIndexPath:(NSIndexPath *_Nullable)indexPath;


/**
 UITableView 注册 section Header
 计算是自定义的xib也得用class方法
 
 @param aClass Class
 */
- (void)ax_registerHeaderWithClass:(Class _Nullable )aClass;

/**
 UITableView dequeueReusableHeaderFooterView axCellHeadID
 
 @return UITableViewHeaderFooterView
 */
- (nullable __kindof UITableViewHeaderFooterView *)ax_dequeueReusableHeader;

/**
 UITableView 注册 section Footer
 计算是自定义的xib也得用class方法
 
 @param aClass Class
 */
- (void)ax_registerFooterWithClass:(Class _Nullable)aClass;

/**
 UITableView dequeueReusableHeaderFooterView axCellHeadID
 
 @return UITableViewHeaderFooterView
 */
- (nullable __kindof UITableViewHeaderFooterView *)ax_dequeueReusableFooter;


/**
 UITableView footerViewZero
 */
- (void)ax_footerViewZero;

@end
