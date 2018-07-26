//
//  AXCycleScrollView.m
//  广告栏无限滚动
//
//  Created by Mole Developer on 2017/7/6.
//  Copyright © 2017年 mole. All rights reserved.
//

#import "AXCycleScrollView.h"
#import "UIImageView+WebCache.h"


typedef enum {
    AXDataStyleImageName,//本地图片
    AXDataStyleImageURL//网络url
} AXDataStyle;//显示图片类型

@interface AXCycleScrollView () <UICollectionViewDelegate,UICollectionViewDataSource>
/**
 *
 */
@property (nonatomic, strong)UICollectionView  *collectionView;
/**
 * 记录当前翻页 indexPathsForVisibleItems 不够精确
 */
@property (nonatomic, assign) NSInteger pageIndex;

/**
 * 数组 count
 */
@property (nonatomic, assign) NSInteger dataCount;

/**
 *
 */
@property (nonatomic, assign) AXDataStyle dataStyle;

/**
 *
 */
@property (nonatomic, strong)UIPageControl  *pageControl;

/**
 * 定时翻页
 */
@property (nonatomic, strong)NSTimer  *autoScrollTimer;

/**
 * 是否手动在滑动,是,定时器就不自动翻页
 */
@property (nonatomic, assign,getter=isGestureScroll) BOOL gestureScroll;

/**
 *
 */
@property (nonatomic, copy)void(^didIndexBlock)(NSInteger index);

/**
 * 是否加载过
 */
@property (nonatomic, assign) BOOL reloadFirst;

@end


@implementation AXCycleScrollView

static NSString *cellID = @"cellID";

#pragma mark - init
/**
本地图片 轮播初始化方式

@param frame frame
@param imageNamesArray 本地图片名称 数组
@return AXCycleScrollView
*/
- (instancetype)initWithFrame:(CGRect)frame imageNamesArray:(NSArray <NSString *>*)imageNamesArray{
    
    self = [self initWithFrame:frame];
    self.imageNamesArray = [self doDataArray:imageNamesArray];
    self.dataCount =  self.imageNamesArray.count;
    self.dataStyle = AXDataStyleImageName;
    [self func_initData];
    [self func_roladData];
    
    return self;
}


/**
 网络图片URL 轮播初始化方式
 
 @param frame frame
 @param imageURLArray  网络图片 url sting 数组
 @param placeholderImage 无法加载网络图片 占位图片
 @return AXCycleScrollView
 */
-(instancetype)initWithFrame:(CGRect)frame imageURLArray:(NSArray <NSString *>*)imageURLArray placeholderImage:(UIImage *)placeholderImage{

    self= [self initWithFrame:frame];
    self.imageURLArray = [self doDataArray:imageURLArray];
    self.dataCount =  self.imageURLArray.count;
    self.placeholderImage =placeholderImage;
    self.dataStyle = AXDataStyleImageURL;
    [self func_initData];
    [self func_roladData];
    return self;
}


/**
 * 处理数组, 0 位置插入 最后位置元素   最后位置插入0位置元素
 */
-(NSArray *)doDataArray:(NSArray *)array{
    if (array.count==0|| array.count==1) {
        return array;
    }
    NSMutableArray *reArray = array.mutableCopy;
    [reArray insertObject:array.lastObject atIndex:0];
    [reArray addObject:array.firstObject];
    return reArray.copy;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    if (self.reloadFirst==NO) {
        self.pageIndex = 1;
        
        self.pageControl.currentPage = 0;
        [self func_noAnimatedScrollToItem:self.pageIndex];
        self.reloadFirst = YES;
    }
    
}

-(void)func_page:(NSInteger )index{
    if (index==0) {
        
        self.pageControl.currentPage = self.dataCount-2;
        
    }else if (index==self.dataCount-1){
        
        self.pageControl.currentPage = 0;
        
    }else{
         self.pageControl.currentPage = index-1;
        
    }
}


#pragma mark - delegate

#pragma mark  滚动中
/**
 * 滚动中 手动 自动 都调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = round(scrollView.contentOffset.x/scrollView.bounds.size.width);
    
    self.pageIndex = index;
    [self func_page:index];
    
    
}

#pragma mark  手动滚动 开始调用
/**
 *  手动滚动 开始调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.gestureScroll = YES;
}

#pragma mark  自动滚动完毕就会调用
/**
 *  自动滚动完毕就会调用（如果scrollView自动滚动完毕，才会调用这个方法）
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self func_firstAndLast];
}


#pragma mark  手动滚动完毕就会调用
/**
 *  手动滚动完毕就会调用（如果是人为拖拽scrollView导致滚动完毕，才会调用这个方法）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    self.gestureScroll = NO;
    [self func_firstAndLast];
}

-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataCount;
}

/**
 * cell
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AXCycleScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
   
    if (self.dataStyle == AXDataStyleImageName) {
         cell.aImageView.image = [UIImage imageNamed:self.imageNamesArray[indexPath.item]];
    }else{
        
        NSURL *url =[NSURL URLWithString:self.imageURLArray[indexPath.item]];
        [cell.aImageView sd_setImageWithURL:url placeholderImage:self.placeholderImage];
        
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (self.didIndexBlock) {
        
        NSInteger didIndex = 0;
        if (indexPath.item==0) {
            didIndex = self.dataCount-2;
        }else if (indexPath.item==self.dataCount-1){
            didIndex = 0;
        }else{
             didIndex = indexPath.item-1;
        }
        
        self.didIndexBlock(didIndex);
    }
}


-(void)didSelectItemAtIndex:(void(^)(NSInteger index))blokc{
    self.didIndexBlock = blokc;
}

#pragma mark - func

/**
 * 滚动到 第一页 最后一页 进行处理
 */
-(void)func_firstAndLast{
    
    if (self.pageIndex == self.dataCount-1) {
        
        self.pageIndex = 1;
        [self func_noAnimatedScrollToItem:self.pageIndex];
        
    }else if (self.pageIndex==0){
        
        self.pageIndex = self.dataCount-2 ;
        [self func_noAnimatedScrollToItem:self.pageIndex];
    }
}

/**
 * 第一页 最后页 无动画滚动
 */
-(void)func_noAnimatedScrollToItem:(NSInteger )index{
    //连续手动滚动,会有空白间隙 延迟一下
    self.collectionView.userInteractionEnabled = NO;
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForItem:index inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.collectionView.userInteractionEnabled = YES;
    });
}


/**
 * 动画滚动,完毕后 scrollViewDidEndScrollingAnimation 中处理 第一页(数组中 last )立即 无动画跳转到 倒数第二页(数组中 last )
 */
- (void)upPage {
    
    if (self.pageIndex >=1) {
        self.pageIndex--;
        NSIndexPath *nextIndexPath=[NSIndexPath indexPathForItem:self.pageIndex inSection:0];
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

/**
 * 动画滚动,完毕后 scrollViewDidEndScrollingAnimation 中处理 最后一页(数组中 first )立即 无动画跳转到 第二页(数组中 first )
 */
- (void)nextPage {
    
    if (self.dataCount<=1) {
        return;
    }
    if (self.pageIndex <self.dataCount-1) {
        self.pageIndex++;
        NSIndexPath *nextIndexPath=[NSIndexPath indexPathForItem:self.pageIndex inSection:0];
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}



/**
 * 初始化参数
 */
-(void)func_initData{
    
    self.autoScrollTimeInterval = 3;
    
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    [self.autoScrollTimer fire];
    
}
-(void)func_roladData{
    self.pageIndex=0;
    self.reloadFirst=NO;
    [self.autoScrollTimer invalidate];
    self.autoScrollTimer = nil;
    self.pageControl.numberOfPages = self.dataCount-2;
    [self.autoScrollTimer fire];
}



#pragma mark - get and set
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        
        layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height); //item尺寸
        layout.minimumInteritemSpacing = 0;//列间距
        layout.minimumLineSpacing = 0;//行间距
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//滚动方向
        
       _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];

        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:AXCycleScrollCell.class forCellWithReuseIdentifier:cellID];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollsToTop = NO;
    }
    return _collectionView;
}



- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-20,self.bounds.size.width, 20)];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        
    }
    return _pageControl;
}


- (NSTimer *)autoScrollTimer{
    if (!_autoScrollTimer) {
        _autoScrollTimer =  [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            if (!self.isGestureScroll) {
                [self nextPage];
            }
        }];
    }
    return _autoScrollTimer;
}


- (void)setAutoScrollTimeInterval:(NSTimeInterval)autoScrollTimeInterval{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    if (self.autoScrollTimer.timeInterval != autoScrollTimeInterval) {
        [self.autoScrollTimer invalidate];
        self.autoScrollTimer = nil;
        [self.autoScrollTimer fire];
    }
    
}

- (void)setImageNamesArray:(NSArray<NSString *> *)imageNamesArray{
    
    _imageNamesArray = [self doDataArray:imageNamesArray];
    self.dataCount =  _imageNamesArray.count;

    self.dataStyle = AXDataStyleImageURL;
    [self func_roladData];
    [self.collectionView reloadData];
}

- (void)setImageURLArray:(NSArray<NSString *> *)imageURLArray{
    
    
    _imageURLArray = [self doDataArray:imageURLArray];
    self.dataCount =  _imageURLArray.count;
    self.dataStyle = AXDataStyleImageURL;
    [self func_roladData];
    [self.collectionView reloadData];
}
@end

@interface AXCycleScrollCell ()

@end

@implementation AXCycleScrollCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self func_init];
    }
    return self;
}
-(void)func_init{
    self.aImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:self.aImageView];
}



@end


