//
//  AXGuidePageVC.m
//  AXiOSToolsDemo
//
//  Created by mac on 2018/6/21.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "AXGuidePageVC.h"
#import "AXFullLayout2.h"
#import "AXGuidePageCell.h"
#import "AXToolsHeader.h"
@interface AXGuidePageVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray <NSString *>*imageArray;

/**
 <#Description#>
 */
@property (nonatomic, copy)void(^passBlock)(void);

@end

@implementation AXGuidePageVC

+ (instancetype )guidePageWithImage:(NSArray <NSString *>*)imageArray passBlock:(void(^)(void))passBlock{
    
    AXGuidePageVC *vc = [[AXGuidePageVC alloc]init];
    vc.imageArray = imageArray;
    vc.passBlock = passBlock;
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    AXFullLayout2 *lay = [[AXFullLayout2 alloc]init];
    
    self.collectionView.collectionViewLayout = lay;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:ax_Nib(@"AXGuidePageCell") forCellWithReuseIdentifier:axCellID];
    
    self.pageControl.numberOfPages = self.imageArray.count;
}

- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AXGuidePageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:axCellID forIndexPath:indexPath];
    
    cell.contentImageView.image = [UIImage imageNamed:self.imageArray[indexPath.item]];
    
    if (indexPath.item == self.imageArray.count-1) {
        cell.passBtn.hidden = NO;
        [cell.passBtn setBackgroundImage:self.passImage forState:UIControlStateNormal];
    }else{
        cell.passBtn.hidden = YES;
    }
    [cell.passBtn addTarget:self action:@selector(passBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    double currentDouble = scrollView.contentOffset.x/self.view.width;
    
    double roundD = round(currentDouble);
    
    self.pageControl.currentPage =  (NSInteger )roundD;
}

- (void)passBtnAction:(UIButton *)button{
    
    if (self.passBlock) {
        self.passBlock();
    }
}



@end
