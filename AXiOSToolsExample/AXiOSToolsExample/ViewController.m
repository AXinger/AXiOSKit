//
//  ViewController.m
//  AXiOSToolsExample
//
//  Created by AXing on 2019/1/19.
//  Copyright © 2019 liu.weixing. All rights reserved.
//
#import "ViewController.h"
#import "AAViewController.h"
#import "AXiOSTools.h"
#import "WebSocketManager.h"


@interface ViewController ()

@property(nonatomic,strong)AAViewController *avc;

/**<#description#>*/
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"view>> %@",self.view);
    }
    return self;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
          NSLog(@"view>>3 %@",self.view);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [@"www.baodu.com/" ax_pathAppendingWithParameter:@{@"age":@"18",@"name":@"jim"}];
     [@"www.baodu.com" ax_pathAppendingWithParameter:@{@"age":@"18",@"name":@"jim"}];
     [@"www.baodu.com?tap=18" ax_pathAppendingWithParameter:@{@"age":@"18",@"name":@"jim"}];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    AAViewController *vc = [[AAViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

    
    
}

- (IBAction)btnAction:(id)sender {
    
    NSDictionary *dcit =  @{@"msg":self.tf.text,@"onlineCount":@2,@"type":@"SPEAK",@"username":@"tom"};
    
    [WebSocketManager.shared sendDataToServer: [dcit ax_toJSONString]];
}

- (IBAction)btnAc2:(id)sender {
    
}


@end
