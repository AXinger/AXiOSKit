//
//  AXPlayVC.m
//  BigApple
//
//  Created by liuweixing on 2016/10/24.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXPlayVC.h"
#import "AXToolsHeader.h"
@import MediaPlayer;
@import AVFoundation;
@interface AXPlayVC ()<AVPlayerViewControllerDelegate>

/**
 * <#注释#>
 */
@property (nonatomic, copy) NSMutableArray *fileArray;
/**
 *
 */
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation AXPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupMovePath:self.playUrl];
}

- (void)setupMovePath:(NSString *)path{
//    MPMoviePlayerController
//    MPMoviePlayerViewController
    if (@available(iOS 9.0, *)) {
        self.delegate = self;
    } else {
        // Fallback on earlier versions
    }
    
    self.videoGravity = AVLayerVideoGravityResizeAspect;
    self.showsPlaybackControls = YES;
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    
    
    
    AXLog(@"path-->%@--mp4--> %@",path,[self.playPaths ax_getFileNameListName:@"mp4"]);
    
    if (path==nil) {
        return;
    }
    
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    
//    NSURL *url = [NSURL fileURLWithPath:self.fileArray];
    
    
    AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:url];

   self.player = [AVPlayer playerWithPlayerItem:playerItem];
    
//    player.currentItem;
//    playerLayer.≥videoGravity = AVLayerVideoGravityResizeAspect;
    self.player.externalPlaybackVideoGravity = AVLayerVideoGravityResizeAspectFill;
    
//player replaceCurrentItemWithPlayerItem:<#(nullable AVPlayerItem *)#>
//    self.player = player;
    
//    AVQueuePlayer

    
//    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
//    layer.frame = self.view.frame;
//    [self.view.layer addSublayer:layer];
    
        //AVPlayerViewController 内部可能是用约束写的，这句可以禁用自动约束，消除报错
    
    [self.player play];
    
}
- (NSMutableArray *)fileArray{
    if (!_fileArray) {
        _fileArray = [NSMutableArray array];
    }
    return _fileArray;
}
- (void)setPlayPaths:(NSString *)playPaths{
    _playPaths = playPaths;
    
    for (NSString *file in [playPaths ax_getFileNameListName:@"mp4"]) {
        NSString *url = [playPaths stringByAppendingPathComponent:file];
        [self.fileArray addObject:url];
    }
    
    self.playUrl = self.fileArray[self.currentIndex];

}

// 1、即将开始画中画
- (void)playerViewControllerWillStartPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"即将开始画中画");
}

// 2、开始画中画
- (void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewController *)playerViewController{
     NSLog(@"开始画中画");
}

// 3、画中画失败
- (void)playerViewController:(AVPlayerViewController *)playerViewController failedToStartPictureInPictureWithError:(NSError *)error{
      NSLog(@"画中画失败");
}

// 4、即将结束画中画
- (void)playerViewControllerWillStopPictureInPicture:(AVPlayerViewController *)playerViewController{
    NSLog(@"即将结束画中画");
}

// 5、结束画中画
- (void)playerViewControllerDidStopPictureInPicture:(AVPlayerViewController *)playerViewController{
     NSLog(@"结束画中画");
}


- (BOOL)playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart:(AVPlayerViewController *)playerViewController {
    NSLog(@"%s", __FUNCTION__);
    return true;
}

- (void)playerViewController:(AVPlayerViewController *)playerViewController restoreUserInterfaceForPictureInPictureStopWithCompletionHandler:(void (^)(BOOL))completionHandler {
    NSLog(@"%s", __FUNCTION__);
}




@end
