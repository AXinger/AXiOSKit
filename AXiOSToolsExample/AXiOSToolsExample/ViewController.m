//
//  ViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//




#import "ViewController.h"

#import "ABViewController.h"
#import "AXiOSTools.h"

#import "AAViewController.h"
#import "AView.h"
#import "AView.h"
#import "QRCodeViewController.h"
#import "AView.h"
#import "BView.h"

@interface ViewController ()<QRCodeViewControllerDelegate>

@property(nonatomic,strong)AAViewController *avc;

/**<#description#>*/
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    
  
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    
//    AXQRCodeVC *vc = [[AXQRCodeVC alloc]init];
//    vc.qrCodeBlock = ^(NSError *error, NSString *code) {
//        NSLog(@"%@  %@",error,code);
//        self.label.text = code;
////        [vc.navigationController dismissViewControllerAnimated:YES completion:nil];
//    };
//    [self.navigationController pushViewController:vc animated:YES];
    
    
//    QRCodeViewController *vc = [[QRCodeViewController alloc]init];
//    vc.delegate = self;
//    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)qrCodeViewController:(QRCodeViewController *)reader didScanResult:(NSString *)result {
    self.label.text = result;
//     [reader.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnAction:(id)sender {
    
    BView *VIEW = [[BView alloc]init];
    
    [self.view addSubview:VIEW];
    
    
    [VIEW mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
}



@end
