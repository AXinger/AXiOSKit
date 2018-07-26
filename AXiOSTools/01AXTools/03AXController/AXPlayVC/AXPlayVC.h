//
//  AXPlayVC.h
//  BigApple
//
//  Created by liuweixing on 2016/10/24.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <AVKit/AVKit.h>

@interface AXPlayVC : AVPlayerViewController
/**
 * 播放的url
 */
@property (nonatomic, copy) NSString *playUrl;

/**
 * 文件夹路径,里面包含很多MP4,文件,筛选出来,拼接路径,进行播放
 */
@property (nonatomic, copy) NSString *playPaths;


@end
