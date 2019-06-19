//
//  AXChoosePayStyleVC.m
//  AXiOSKitDemo
//
//  Created by liuweixing on 2018/8/20.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXChoosePayStyleVC.h"
#import "AXChoosePayStyleCell.h"
#import "AXiOSKit.h"

@interface AXChoosePayStyleVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation AXChoosePayStyleVC

- (AXAlertControllerStyle)axAlertControllerStyle{
    return AXAlertControllerStyleUpward;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:ax_NibClass(AXChoosePayStyleCell.class) forCellReuseIdentifier:k_axCellID];
    axTableFooterViewZero;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AXChoosePayStyleCell *cell = [tableView dequeueReusableCellWithIdentifier:k_axCellID forIndexPath:indexPath];
    
    AXChoosePayModel *model = self.dataArray[indexPath.row];
    
    cell.logoImageView.image = [UIImage axBundle_imageNamed:model.imageName];
    cell.nameLabel.text = model.name;
    
    if (self.selectIndex == indexPath.row) {
        
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectIndex == indexPath.row) {
        return;
    }

//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.didSelectBlock) {
        self.didSelectBlock(indexPath.row);
    }
}


- (IBAction)backBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end