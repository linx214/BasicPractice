//
//  ViewController.m
//  JSONWithiOS
//
//  Created by linx214 on 15/10/13.
//  Copyright © 2015年 linx214. All rights reserved.
//

/**
 使用CocoaTouch框架，解析JSON数据
 填写数据，采用JSON数据格式封装，写入txt文档
 2015.10.13 02:11:33 start
 过程中只对Xcode官方文档进行查阅，并了解相关其他的方法
 2015.10.13 03:53:30 end
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"jsonFormat" ofType:@"json"];
//    NSInteger errorInteger = 0;
//    NSDictionary* errorDict = [NSDictionary dictionary];
//    NSError* error = [NSError errorWithDomain:NSCocoaErrorDomain
//                                         code:errorInteger
//                                     userInfo:errorDict];
    NSError* error = nil;
    
    NSData* data = [NSData dataWithContentsOfFile:filePath
                                          options:NSDataReadingMappedIfSafe
                                            error:&error];
    if (error)
    {
        NSLog(@"dataWithContentsOfFile: %@", error);
    }
    
    NSJSONSerialization* jsonSerilizer = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:NSJSONReadingMutableContainers
                                                                           error:&error];
    
    if (error)
    {
        NSLog(@"JSONObjectWithData: %@", error);
    }
    
    if ([NSJSONSerialization isValidJSONObject:jsonSerilizer])
        NSLog(@"is valid json object");
    else
        NSLog(@"is not valid json object");
  
    /**
     不能这样直接使用JSONSerialization对象
     */
//    NSArray* keys = @[@"id", @"author", @"url", @"content"];
//    NSDictionary* dict = [NSDictionary dictionaryWithObject:data
//                                                     forKey:keys];
//    
//    NSLog(@"dict: %@", dict);

    /**
     查阅网上关于iOS原生JSON解析是直接将JSONSerialization对象直接强转成NSDictionary？
     */
    NSDictionary* dict = (NSDictionary*)jsonSerilizer;
    NSLog(@"dict: %@", dict);
    
    NSArray* array = [dict objectForKey:@"comments"];
    for (NSDictionary* loopdict in array)
    {
        NSString* author = [loopdict valueForKey:@"author"];
        NSString* coment = [loopdict valueForKey:@"content"];
        NSString* stringid = [loopdict valueForKey:@"id"];
        NSString* url = [loopdict valueForKey:@"url"];
        
        NSLog(@"result is aothor: %@, comment: %@, id: %@, url: %@", author, coment, stringid, url);
    }
    
    /**
     JSONSerialization对象的内存结构与NSDictionary的内存结构一致，所以可以直接强转使用
     */
    
    /**
     下面使用JSONSerialization对象将一个自己定义的NSDictionary对象转换成JSON数据格式
     */
    
    NSDictionary* targetDictionary = @{ @"name" : @"Linxiang", @"age" : @28, @"isHandsome" : @"YES" };
    NSJSONSerialization* targetJSONSerialization = (NSJSONSerialization*)targetDictionary;
    NSData* targetData = [NSJSONSerialization dataWithJSONObject:targetJSONSerialization
                                                         options:NSJSONWritingPrettyPrinted
                                                           error:&error];
    if (error)
    {
        NSLog(@"targetData Error: %@", error);
    }
    else
    {
        NSLog(@"targetDate: %@", targetData);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
