//
//  AXPhotoBrowserVC.m
//  AXiOSToolsDemo
//
//  Created by mac on 2018/6/21.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXPhotoBrowserVC.h"
#import "AXToolsHeader.h"

@interface AXPhotoBrowserVC ()<GKPhotoBrowserDelegate>

@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIButton *moreBtn;

@end

@implementation AXPhotoBrowserVC

- (instancetype )initWithPhotoURLs:(NSArray *)photoURLsArray animatedFromView:(UIImageView *)view showIndex:(NSInteger )showIndex{
    
    return [self func_initWithGKPhotoURLs:photoURLsArray animatedFromView:view showIndex:showIndex];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - GKPhotoBrowser

- (instancetype )func_initWithGKPhotoURLs:(NSArray *)photoURLsArray animatedFromView:(UIImageView*)view showIndex:(NSInteger )showIndex{
    
    NSMutableArray *photos = [NSMutableArray array];
    
    
    for (NSString *url in photoURLsArray) {
        
        GKPhoto *photo = [[GKPhoto alloc]init];;
        photo.url = [NSURL URLWithString:url];
        photo.sourceImageView = view;
        [photos addObject:photo];
    }
    
    AXPhotoBrowserVC *browser = [AXPhotoBrowserVC photoBrowserWithPhotos:photos currentIndex:showIndex];
    
    browser.showStyle           = GKPhotoBrowserShowStyleNone;
    browser.hideStyle           = GKPhotoBrowserHideStyleZoomSlide;
    browser.isSingleTapDisabled = YES;  // 不响应默认单击事件
    browser.isStatusBarShow     = NO;  // 显示状态栏
    browser.isHideSourceView    = NO;
    browser.delegate            = self;
    
    //    [browser setupCoverViews:@[self.closeBtn, self.moreBtn] layoutBlock:^(GKPhotoBrowser *photoBrowser, CGRect superFrame) {
    //
    //        [self resetCoverFrame:superFrame index:photoBrowser.currentIndex];
    //    }];
    
    return browser;
    
}


- (void)resetCoverFrame:(CGRect)frame index:(NSInteger)index{
    
    self.closeBtn.frame = CGRectMake(0, 100, 50, 50);
    self.moreBtn.frame = CGRectMake(0, 100, 50, 50);
    
}

- (void)closeBtnClick:(id)sender {
    
    //    [self.gKBrowser dismissViewControllerAnimated:YES completion:nil];
}

- (void)moreBtnClick:(id)sender {
    
}


#pragma mark 懒加载
- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]init];
        [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn sizeToFit];
    }
    return _closeBtn;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc]init];
        [_moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_moreBtn sizeToFit];
    }
    return _moreBtn;
}


@end
