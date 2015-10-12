//
//  main.m
//  JSONWithOSX
//
//  Created by linx214 on 15/10/13.
//  Copyright © 2015年 linx214. All rights reserved.
//

/**
 使用CocoaTouch框架，解析JSON数据
 填写数据，采用JSON数据格式封装，写入txt文档
 2015.10.13 02:11:33 start
 过程中只对Xcode官方文档进行查阅，并了解相关其他的方法
 */

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        // insert code here...
        NSLog(@"Hello, World!");
        
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"jsonFormat" ofType:@"json"];
        NSData* data = [NSData dataWithContentsOfFile:filePath
                                              options:NSDataReadingMappedIfSafe
                                                error:NULL];
        
        NSJSONSerialization* jsonSerilizer = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:NSJSONReadingMutableContainers
                                                                               error:NULL];
        
        if ([NSJSONSerialization isValidJSONObject:jsonSerilizer])
            NSLog(@"is valid json object");
        else
            NSLog(@"is not valid json object");
    }
    return 0;
}
