//
//  AXQRCodeVC.m
//  AXiOSTools
//
//  Created by liuweixing on 16/6/12.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "AXQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "AXToolsHeader.h"
typedef void(^QRCodeBlock)(NSString *code);

@interface AXQRCodeVC ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong)AVCaptureSession * session;//输入输出的中间桥梁
@property (nonatomic, assign) BOOL isOpenCamera;
@property (nonatomic, assign) BOOL isShowResult;
/**
 * 
 */
@property (nonatomic, copy) QRCodeBlock qRCodeBlock;
@end

@implementation AXQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = AXToolsLocalizedString(@"扫一扫");
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.isOpenCamera = YES;
        [self.session startRunning];
    }else{
        [self ax_showAlertByTitle:@"该设备无相机功能"];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(activeCodeDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isShowResult = NO;
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
}



- (void)dealloc{
    axLong_dealloc ;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}
- (void)activeCodeDidEnterBackground{
    if (self.isOpenCamera ) {
        [self.session stopRunning];
    }
}

- (void)becomeActive{
    if (self.isOpenCamera ) {
        //开始捕获
        [self.session startRunning];
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    
    if ([metadataObjects count] >0){
        
        if (_isShowResult) {
            return;
        }
        _isShowResult = YES;
        AVMetadataMachineReadableCodeObject * metadataObject = metadataObjects.firstObject;
        NSString *stringValue = metadataObject.stringValue;
        
       
        
//        [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
        if (self.qRCodeBlock) {
            self.qRCodeBlock(stringValue);
        }
    }
}

- (void)successQRCode:(void(^)(NSString *code))code{
    self.qRCodeBlock = code;
}

- (AVCaptureSession *)session{
    if (!_session) {
        
        AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        //创建输入流
        AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        
        //创建输出流
        AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
        //设置代理 在主线程里刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        // CGRectMake（y的起点/屏幕的高，x的起点/屏幕的宽，扫描的区域的高/屏幕的高，扫描的区域的宽/屏幕的宽）
        
        //    output.rectOfInterest=CGRectMake(0.25, 0.25, 0.25,0.25);
        
        
        //    output.
        //初始化链接对象
        _session = [[AVCaptureSession alloc]init];
        //高质量采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        
        
        AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
        layer.backgroundColor =[UIColor orangeColor].CGColor;
        
        CGFloat layerWH = axScreenWidth-40;
        
        CGRect rect =  CGRectMake(20,120, layerWH, layerWH);
        layer.frame = rect;
        
        [self.view.layer insertSublayer:layer atIndex:0];
        
        if ([_session canAddInput:input])
        {
            [_session addInput:input];
        }
        
        if ([_session canAddOutput:output])
        {
            [_session addOutput:output];
        }
        // 一定要写在 self.session addOutput:output] 后面
        output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    }
    return _session;
}
@end
