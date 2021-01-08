//
//  _25FlowLayoutVC3.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2021/1/6.
//  Copyright © 2021 axinger. All rights reserved.
//

#import "_25CompLayoutVC2.h"
#import <Masonry/Masonry.h>
#import <AXiOSKit/AXiOSKit.h>


@interface _25CompLayoutVC2 ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation _25CompLayoutVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"25-2 垂直滚动，一个大cell + 两个小cell 交替";
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    [self.collectionView reloadData];
    
    self.collectionView.backgroundColor = UIColor.groupTableViewBackgroundColor;
  
     
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        //
        //        make.top.left.right.mas_equalTo(0);
        //        make.height.mas_equalTo(200+38*2+20);
    }];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell =  [collectionView  dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f green:arc4random()%255/255.f blue:arc4random()%255/255.f alpha:1];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UICollectionReusableView *h = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
        h.backgroundColor = UIColor.redColor;
        return h;
    } else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *f = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot" forIndexPath:indexPath];
        f.backgroundColor = UIColor.greenColor;
        return f;
    } else if([kind isEqualToString:@"Badge"]){

        UICollectionReusableView *b = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"custom" forIndexPath:indexPath];
        b.backgroundColor = [UIColor blackColor];
        b.layer.cornerRadius = 10;
        b.layer.masksToBounds = YES;
        return b;
    }
    return nil;
}




- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        __kindof UICollectionViewLayout *subLayout = nil;
        
        
        if (@available(iOS 13.0, *)) {
            
            //配置装饰 Anchor 锚
            NSCollectionLayoutAnchor *badgeAnchor = [NSCollectionLayoutAnchor layoutAnchorWithEdges:NSDirectionalRectEdgeTop|NSDirectionalRectEdgeTrailing fractionalOffset:CGPointMake(0.5, -0.5)];//装饰视图中心点等于cell的右上角顶点
            
            ///Anchor 大小
            NSCollectionLayoutSize *badgeSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:20] heightDimension:[NSCollectionLayoutDimension absoluteDimension:20]];
            
            NSCollectionLayoutSupplementaryItem *badge = [NSCollectionLayoutSupplementaryItem supplementaryItemWithLayoutSize:badgeSize elementKind:@"Badge" containerAnchor:badgeAnchor];

            
            NSMutableArray<NSCollectionLayoutItem *> *subitems = NSMutableArray.array;
            
            
            {
                //顶部item
                NSCollectionLayoutSize *topItemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:9.0/16.0]];
                
                NSCollectionLayoutItem *topItem = [NSCollectionLayoutItem itemWithLayoutSize:topItemSize];
                [subitems addObject:topItem];
                
            }
            
            
            {
                
                //底部item
                NSCollectionLayoutSize *bottomItemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.5] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
                
                NSCollectionLayoutItem *bottomItem = [NSCollectionLayoutItem itemWithLayoutSize:bottomItemSize supplementaryItems:@[badge]];
                
                bottomItem.contentInsets = NSDirectionalEdgeInsetsMake(8, 8, 8, 8);
                
                
                
                //底部group
                NSCollectionLayoutSize *bottomGroupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.5]];
                
                
            //    NSCollectionLayoutGroup *bottomGroup = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:bottomGroupSize subitems:@[bottomItem, bottomItem]];//该api放两个相同的item是不起效的
                
                NSCollectionLayoutGroup *bottomGroup = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:bottomGroupSize subitem:bottomItem count:2];//会在这个分组中放入两个相同的item。并且这里设置了2，即使bottomItemSize width设置比较大，依然会平分
                
                
                [subitems addObject:bottomGroup];
                
            }
            
            //组合group 🐂🍺 注意这里的尺寸一点要是组合的大小
            NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:9.0/16.0 + 0.5]];
            
            NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup verticalGroupWithLayoutSize:groupSize subitems:subitems];//NSCollectionLayoutGroup继承自NSCollectionLayoutItem
//            group.contentInsets = NSDirectionalEdgeInsetsMake(0, 20, 0, 20);
            
            //虽然一个section只能指定一个group，但可以group中可以组合item和其他group
            NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
            /// section 内容间距 包含 头 和 group 
            section.contentInsets = NSDirectionalEdgeInsetsMake(0, 20, 0, 20);
        //    section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehaviorContinuous;
            {
                
                
                //配置组头组
                NSCollectionLayoutSize *headerSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension estimatedDimension:44]];
                NSCollectionLayoutBoundarySupplementaryItem *headerItem = [NSCollectionLayoutBoundarySupplementaryItem boundarySupplementaryItemWithLayoutSize:headerSize elementKind:UICollectionElementKindSectionHeader alignment:NSRectAlignmentTop];
            //    headerItem.pinToVisibleBounds = YES;
                
                //配置组头组尾
                NSCollectionLayoutSize *footerSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension estimatedDimension:60]];
                
                NSCollectionLayoutBoundarySupplementaryItem *footerItem = [NSCollectionLayoutBoundarySupplementaryItem boundarySupplementaryItemWithLayoutSize:footerSize elementKind:UICollectionElementKindSectionFooter alignment:NSRectAlignmentBottom];
                
                section.boundarySupplementaryItems = @[headerItem, footerItem];
            }
            
            UICollectionViewCompositionalLayoutConfiguration *config = [UICollectionViewCompositionalLayoutConfiguration.alloc init];
            config.scrollDirection = UICollectionViewScrollDirectionVertical;
            
            UICollectionViewCompositionalLayout *layout = [[UICollectionViewCompositionalLayout alloc]initWithSection:section configuration:config];

            subLayout = layout;
        }else{
            
        }
        
        
        _collectionView = [UICollectionView.alloc initWithFrame:CGRectZero collectionViewLayout:subLayout];
        
        [_collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cellID"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:@"Badge" withReuseIdentifier:@"custom"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        
    }
    return _collectionView;
}

@end
