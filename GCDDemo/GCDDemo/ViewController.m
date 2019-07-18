//
//  ViewController.m
//  GCDDemo
//
//  Created by lee on 2019/7/10.
//  Copyright © 2019 Onlyou. All rights reserved.
//

#import "ViewController.h"
#import "pthread.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self testCreateMoreThread];
}

#pragma mark - 排列组合

//1.串行队列 + 同步任务
- (void)syncSerial
{
    NSLog(@"开始");
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("demo", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务一"];
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务二"];
        }
    });
    
    NSLog(@"结束");
}

//2.串行队列 + 异步任务
- (void)asyncSerial
{
    NSLog(@"开始");
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("demo", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务一"];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务二"];
        }
    });
    
    NSLog(@"结束");
}

//3.并发队列 + 同步任务
- (void)syncConcurrent
{
    NSLog(@"开始");
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("demo", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务一"];
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务二"];
        }
    });
    
    NSLog(@"结束");
}

//4.并发队列 + 异步任务
- (void)asyncConcurrent
{
    NSLog(@"开始");
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("demo", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务一"];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务二"];
        }
    });
    
    NSLog(@"结束");
}


//5.主队列 + 异步任务
- (void)asyncMain
{
    NSLog(@"开始");
    //获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务一"];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务二"];
        }
    });
    
    NSLog(@"结束");
}

//6.主队列 + 同步任务
- (void)syncMain
{
    NSLog(@"开始");
    //获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    NSLog(@"%@", dispatch_get_current_queue());
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务一"];
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务二"];
        }
    });
    
    NSLog(@"结束");

}

//7.全局队列 + 同步任务
- (void)syncGlobal
{
    NSLog(@"开始");
    //获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务一"];
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务二"];
        }
    });
    
    NSLog(@"结束");
}

//8.全局队列 + 异步任务
- (void)asyncGlobal
{
    NSLog(@"开始");
    //获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务一"];
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务二"];
        }
    });
    
    NSLog(@"结束");
}

#pragma mark - 个人理解队列与线程关系

//一个队列对应一个线程
- (void)singleQueueToSingleThread
{
    //主线程与主队列
    dispatch_async(dispatch_get_main_queue(), ^{
        [self logThreadAndTaskName:@"任务1"];
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self logThreadAndTaskName:@"任务2"];
    });
}

//多个队列对应一个线程
- (void)multipleQueueToSingleThread
{
    //创建一个队列
    dispatch_queue_t queue = dispatch_queue_create("demoQueue", DISPATCH_QUEUE_SERIAL);
    
    //主队列 <-> 主线程
    [self logThreadAndTaskName:@"任务1"];
    
    //创建的队列demoQueue <-> 主线程
    //由于是同步任务，所以不会创建线程。
    dispatch_sync(queue, ^{
        [self logThreadAndTaskName:@"任务2"];
    });
}

//一个队列对应多个线程
- (void)singleQueueToMultipleThread
{
    //创建一个并发队列
    dispatch_queue_t queue = dispatch_queue_create("demoQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //由于是一部任务，并且是在并发队列上，所以会创建线程。
    dispatch_async(queue, ^{
        [self logThreadAndTaskName:@"任务1"];
    });
    
    dispatch_async(queue, ^{
        [self logThreadAndTaskName:@"任务2"];
    });
}

//多个队列对应多个线程
- (void)multipleQueueToMultipleThread
{
    //创建一个并发队列
    dispatch_queue_t queue = dispatch_queue_create("demoQueue", DISPATCH_QUEUE_CONCURRENT);
    
    //主队列 <-> 主线程
    [self logThreadAndTaskName:@"任务1"];
    
    //由于是一部任务，并且是在并发队列上，所以会创建线程。
    dispatch_async(queue, ^{
        [self logThreadAndTaskName:@"任务2"];
    });
}

#pragma mark - 测试死锁
- (void)testDeadlock
{
    NSLog(@"1");
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
}

#pragma mark - 常见使用
- (void)testDispatchAfter
{
    NSLog(@"开始");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"hello dispatch_after");
        NSLog(@"执行完成");
    });
}

- (void)testDispatchOnce
{
    //线程安全
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //这里写入要执行一次的代码
    });
}

- (void)testDispatchGroupWithAsync
{
    //创建一个队列组
    dispatch_group_t group = dispatch_group_create();
    
    //模拟两个耗时操作
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务1"];
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务2"];
        }
    });
    
    //耗时任务完成后，通知
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"耗时任务结束，在这里做相关的处理。");
    });
    
    NSLog(@"这里会先执行哦！！！");
}

- (void)testDispatchGroupWithEnterAndLeave
{
    //创建一个队列组
    dispatch_group_t group = dispatch_group_create();
    
    //模拟两个耗时操作
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务1"];
        }
        dispatch_group_leave(group);
    });

    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务2"];
        }
        dispatch_group_leave(group);
    });
    
    //耗时任务完成后，通知
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"耗时任务结束，在这里做相关的处理。");
    });
    
    NSLog(@"这里会先执行哦！！！");
    
}

- (void)testDispatchGroupWithAsyncAndWait
{
    //创建一个队列组
    dispatch_group_t group = dispatch_group_create();
    
    //模拟两个耗时操作
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务1"];
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务2"];
        }
    });
    
    //一直等待完成
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    //指定等待时间
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
    long watiTime = dispatch_group_wait(group, time);
    
    if ( watiTime != 0 ) {
        NSLog(@"等待时间结束了，但是耗时任务还未执行完成，不阻塞线程，往下继续执行代码");
    }
    
    //耗时任务完成后，通知
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"耗时任务结束，在这里做相关的处理。");
    });
    
    NSLog(@"这里会先执行吗？不会，因为dispatch_group_wait会阻塞当前线程。");
}


- (void)testDispatchBarrierSync
{
    //创建一个并发队列
    dispatch_queue_t queue = dispatch_queue_create("demoQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务1"];
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务2"];
        }
    });
    
    NSLog(@"同步栅栏 开始");
    dispatch_barrier_sync(queue, ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [self logThreadAndTaskName:@"执行栅栏函数"];
        }
    });
    NSLog(@"同步栅栏 结束");
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务3"];
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务4"];
        }
    });
    
}

- (void)testDispatchBarrierAsync
{
    //创建一个并发队列
    dispatch_queue_t queue = dispatch_queue_create("demoQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务1"];
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务2"];
        }
    });
    
    NSLog(@"异步栅栏 开始");
    dispatch_barrier_async(queue, ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [self logThreadAndTaskName:@"执行栅栏函数"];
        }
    });
    NSLog(@"异步栅栏 结束");
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务3"];
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务4"];
        }
    });
    
}

- (void)testDispatchSemaphore
{

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务1"];
        }
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务2"];
        }
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        for (NSInteger i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];
            [self logThreadAndTaskName:@"任务3"];
        }
        dispatch_semaphore_signal(semaphore);
    });
}

- (void)testDispatchApplySync
{
    
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("demo", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"开始");
    
    dispatch_apply(5, queue, ^(size_t index) {
        [self logThreadAndTaskName:[NSString stringWithFormat:@"任务%lu", index + 1]];
    });
    
    NSLog(@"结束");
}


- (void)testDispatchApplyAsync
{
    
    //创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("demo", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"开始");
    
    dispatch_apply(5, queue, ^(size_t index) {
        [self logThreadAndTaskName:[NSString stringWithFormat:@"任务%lu", index + 1]];
    });
    
    NSLog(@"结束");
}

-  (void)testCreateMoreThread
{
    for (int i = 0; i < 100; ++i) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"%d", i);
        });
    }
}

#pragma mark - 打印当前线程

- (void)logThreadAndTaskName:(NSString *)taskName
{
    NSLog(@"%@，线程：%@", taskName, [NSThread currentThread]);
}




@end
