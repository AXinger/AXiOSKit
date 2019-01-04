
//************************************************************************
//************************************************************************
import 不同类型
#if __has_include(<YYWebImage/YYWebImage.h>)
#import <YYWebImage/YYWebImage.h>
#else
#import "YYWebImage.h"
#endif

//************************************************************************
//************************************************************************

/**
* 断言..让代码奔溃,
*/
// NSAssert(0, @"必须有sourceView或者item");

//************************************************************************
//************************************************************************

/**
* 消除 过期警告 top
*/
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

/* 代码放这中间*/
/**
* 消除 过期警告 botton
*/
#pragma clang diagnostic pop

// 将此行放在出现警告的. m 文件中。 消除所有警告
#pragma GCC diagnostic ignored"-Wundeclared-selector"

//************************************************************************
//************************************************************************

// 过期宏 三种方式都是 第一种的宏

__attribute__((deprecated(" ")));

DEPRECATED_MSG_ATTRIBUTE ()

DEPRECATED_ATTRIBUTE

// 禁用宏
NS_UNAVAILABLE 当我们不想要其他开发人员，用普通的 init 方法去初始化一个类，我们可以在.h 文件里这样写：
- (instancetype)init NS_UNAVAILABLE;

NS_DESIGNATED_INITIALIZER 指定的初始化方法。当一个类提供多种初始化方法时，所有的初始化方法最终都会调用这个指定的初始化方法。比较常见的有：
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
//************************************************************************
//************************************************************************

1 NSSet / NSHashTable 、NSDictionary/ NSMapTable 的学习

NSSet 是过滤掉重复 object 的集合类，NSHashTable 是 NSSet 的升级版容器，并且只有可变版本，允许对添加到容器中的对象是弱引用的持有关系， 当NSHashTable 中的对象销毁时，该对象也会从容器中移除。
NSMapTable 同 NSDictionary 类似，唯一区别是多了个功能：可以设置 key 和 value 的 NSPointerFunctionsOptions 特性! NSDictionary的 key 策略固定是 copy，考虑到开销问题，一般使用简单的数字或者字符串为 key。但是如果碰到需要用 object 作为 key 的应用场景呢？NSMapTable 就可以派上用场了！可以通过 NSFunctionsPointer 来分别定义对 key 和 value 的内存管理策略，简单可以分为 strong,weak以及 copy。

2 几个比较有用的宏

NS_ASSUME_NONNULL_BEGIN、NS_ASSUME_NONNULL_END，如果需要每个属性或每个方法都去指定 nonnull 和 nullable，是一件非常繁琐的事。苹果为了减轻我们的工作量，专门提供了这两个宏。在这两个宏之间的代码，所有比较简单指针对象都被假定为 nonnull，因此我们只需要去指定那些 nullable 的指针。如果我们强行通过点语法将一个非空指针置空，编译器会报 warning。
NS_UNAVAILABLE 当我们不想要其他开发人员，用普通的 init 方法去初始化一个类，我们可以在.h 文件里这样写：
- (instancetype)init NS_UNAVAILABLE;
编译器不但不会提示补全 init 方法，就算开发人员强制发送 init 消息，编译器会直接报错。
NS_DESIGNATED_INITIALIZER 指定的初始化方法。当一个类提供多种初始化方法时，所有的初始化方法最终都会调用这个指定的初始化方法。比较常见的有：
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

3 断言的使用
NSAssert(x,y);：x 为 BOOL 值，y 为 字符串类型。当 x = YES，则不产生断言。当 x = NO，则产生断言，app 会 crash，并在控制台中打印 y 字符串内容。合理利用断言，可以保证 app 的健壮性。
4 互斥锁的使用


//************************************************************************
//************************************************************************

//代码触发点击事件

sendActionsForControlEvents

//************************************************************************
//************************************************************************

NSMutableAttributedString 常见的属性：

NSFontAttributeName 字体

NSForegroundColorAttributeName 文字颜色

NSBackgroundColorAttributeName 背景颜色

NSStrikethroughStyleAttributeName 删除线（默认是0，无删除线）

NSUnderlineStyleAttributeName 下划线(默认是0，无下划线)

NSParagraphStyleAttributeName 设置段落／间距 vlue>> NSMutableParagraphStyle



//************************************************************************
//************************************************************************
//pod github资源 格式

pod 'AXiOSTools',  :git => 'https://github.com/liuweixingGitHub/AXiOSTools.git'

//************************************************************************
//************************************************************************

//播放音频,不与其他app冲突

// 1.启动代理
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient withOptions:AVAudioSessionCategoryOptionMixWithOthers|AVAudioSessionCategoryOptionDefaultToSpeaker error:nil];

return YES;
}
// 2. 播放音频时

[[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];

NSString *filePath = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"mp3"];
NSURL *fileUrl = [NSURL URLWithString:filePath];
self.musicPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:nil];
self.musicPlayer.delegate = self;
[self.musicPlayer play];


//************************************************************************
//************************************************************************

tableView 默认选中

[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

//************************************************************************
//************************************************************************

wkwebView 加载本地 css 文件

//获取bundlePath 路径
NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
//获取本地html目录 basePath
NSString *basePath = [NSString stringWithFormat: @"%@/www", bundlePath];
//获取本地html目录 baseUrl
//html 路径
NSString *indexPath = [NSString stringWithFormat: @"%@/%@.html", basePath,url];
NSURL *fileUrl = [NSURL fileURLWithPath:indexPath];
NSURL *baseUrl = [NSURL fileURLWithPath: basePath isDirectory: YES];
[self.webView loadFileURL:[NSURL fileURLWithPath:indexPath] allowingReadAccessToURL: baseUrl];

//************************************************************************
//************************************************************************

scrollView 滚动方向,x 判断左右, y判断上下


CGPoint point =  [scrollView.panGestureRecognizer translationInView:self.view];

if (point.x < 0 ) {
// 往右滚动

}
}
}

//************************************************************************
//************************************************************************

 同时多个aler 顺序弹出

//创建一个队列，串行并行都可以，主要为了操作信号量
dispatch_queue_t queue = dispatch_queue_create("com.se7en.alert", DISPATCH_QUEUE_SERIAL);


dispatch_async(queue, ^{
//创建一个初始为0的信号量
dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//第一个弹框，UI的创建和显示，要在主线程
dispatch_async(dispatch_get_main_queue(), ^{
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹框1" message:@"第一个弹框" preferredStyle:UIAlertControllerStyleAlert];
[alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

UIViewController *vc = [[UIViewController alloc]init];
vc.view.backgroundColor = [UIColor redColor];
[self.navigationController pushViewController:vc animated:YES];
//点击Alert上的按钮，我们发送一次信号。
dispatch_semaphore_signal(sema);
}]];
[self presentViewController:alert animated:YES completion:nil];
});

//等待信号触发，注意，这里是在我们创建的队列中等待
dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//上面的等待到信号触发之后，再创建第二个Alert
dispatch_async(dispatch_get_main_queue(), ^{
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹框2" message:@"第二个弹框" preferredStyle:UIAlertControllerStyleAlert];
[alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
dispatch_semaphore_signal(sema);
}]];
[self presentViewController:alert animated:YES completion:nil];
});

//同理，创建第三个Alert
dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
dispatch_async(dispatch_get_main_queue(), ^{
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"弹框3" message:@"第三个弹框" preferredStyle:UIAlertControllerStyleAlert];
[alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
dispatch_semaphore_signal(sema);
}]];
[self presentViewController:alert animated:YES completion:nil];
});
});

//************************************************************************
//************************************************************************


//类属性
@property (class,nonatomic, copy) NSString *nameAge;

static NSString *_nameAge1 = nil;

+(void)setNameAge:(NSString *)nameAge {

_nameAge1 = nameAge;
}

+ (NSString *)nameAge {

return _nameAge1;
}


//************************************************************************
//************************************************************************

UIScrollView 滚动g内容高度 子视图适应

UIScrollView *scrollView = [[UIScrollView alloc] init];
scrollView.backgroundColor = [UIColor greenColor];
[self.view addSubview:scrollView];

[scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
make.top.mas_equalTo(80);
make.left.mas_equalTo(0);
make.right.mas_equalTo(0);
make.height.mas_equalTo(200);
}];


UIView *containerView = [[UIView alloc] init];
containerView.backgroundColor = [UIColor yellowColor];
[scrollView addSubview:containerView];

[containerView mas_makeConstraints:^(MASConstraintMaker *make) {
make.edges.mas_equalTo(UIEdgeInsetsZero);
make.width.equalTo(scrollView);//这个不能省略
}];


UIView *view0 = [[UIView alloc] init];
view0.backgroundColor = [UIColor redColor];
[containerView addSubview:view0];

[view0 mas_makeConstraints:^(MASConstraintMaker *make) {
make.edges.mas_equalTo(UIEdgeInsetsZero);
make.height.mas_equalTo(400);
}];

//************************************************************************



//**制作脚本**
1.可以.sh结尾,执行 ./文件名
2.无后缀,直接双击

/*
#dirname $0,获取当前执行脚本文件的父路径
basepath=$(cd'dirname $0';pwd)

#echo 打印
echo "$basepath"
echo "父路径: $basepath"

#当前路径
currentPath=$(pwd)
echo "当前路径: $currentPath"
*/