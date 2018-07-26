//
//  AXObject.m
//  BigApple
//
//  Created by liuweixing on 2016/12/5.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "AXObject.h"
#import <UIKit/UIKit.h>

@implementation AXObject

+(void)isDebug:(void(^)(void))bebug release:(void(^)(void))release{
    
#ifdef DEBUG
    if (bebug) {
        bebug();
    }
#else
    if (release) {
        release();
    }
#endif

}



+(void)iPad:(void(^)(void))iPad iPhone:(void(^)(void))iPhone{

    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        
        if (iPad) {
            iPad();
        }

    }else{
        if (iPhone) {
            iPhone();
        }
        
    }
    
}


@end
