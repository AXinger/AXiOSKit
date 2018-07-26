//
//  AXQRCodeVC.h
//  AXiOSTools
//
//  Created by liuweixing on 16/6/12.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXQRCodeVC : UIViewController

- (void)successQRCode:(void(^)(NSString *code))code;

@end
