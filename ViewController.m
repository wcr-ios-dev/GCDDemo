//
//  ViewController.m
//  GCDDemo
//
//  Created by wcr－dev on 2017/1/3.
//  Copyright © 2017年 Alijoin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self GCDDemo3];
//    [self GCDDemo2];
    [self GCDDemo4];
}
#pragma mark - 全局队列 -
- (void)GCDDemo3{
    dispatch_queue_t allqueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int a = 0; a < 10; a++) {
        
        
        dispatch_async(allqueue, ^{
            NSLog(@"线程_全局队列:%@ + %d",[NSThread currentThread],a);
        });
    }
    
}
#pragma mark - 主线程队列 -
- (void)GCDDemo4{
    dispatch_queue_t mainQ = dispatch_get_main_queue();
    //这样主线程会阻塞
    dispatch_sync(mainQ, ^{
        NSLog(@"主线程队列");
    });
}

#pragma mark - GCD方法 -
//串行队列
- (void)GCDDemo{
    //将操作放在队列中
    //在c语言函数中,定义类型,绝大多数的结尾是_t或者ref
    //使用串行队列的异步任务非常非常有用
    //应用案列:
    //1> 从网络上面下载图片
    //2> 滤镜
    dispatch_queue_t q = dispatch_queue_create("gcd_wcr_demo", DISPATCH_QUEUE_SERIAL);
    dispatch_async(q, ^{
        //num = 1 表示主线程
        //num = 2 表示第二个线程
        NSLog(@"线程列表:-----------------------%@",[NSThread currentThread]);
    });
    
}
#pragma mark - 并行 - (并排跑,类似于赛跑)
- (void)GCDDemo2{
    dispatch_queue_t g = dispatch_queue_create("gcd_wcr_demo2", DISPATCH_QUEUE_CONCURRENT);
    
    
    for (int a = 0; a < 10; a++) {
        dispatch_async(g, ^{
            //num = 1 表示主线程
            //num = 2 表示第二个线程
            NSLog(@"线程列表:-----------------------%@",[NSThread currentThread]);
        });
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
