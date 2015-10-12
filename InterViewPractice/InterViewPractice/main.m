//
//  main.m
//  InterViewPractice
//
//  Created by linx214 on 15/10/10.
//  Copyright © 2015年 linx214. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTest : NSObject

- (void)test;

@property (strong, nonatomic) NSString* sstring;
@property (copy, nonatomic) NSString* cstring;

@end

@implementation CTest

- (void)test
{
    NSMutableString* mutableString = [NSMutableString stringWithFormat:@"abc"];
//    self.sstring = mutableString;
//    self.cstring = mutableString;
    
//    NSLog(@"%p %p", mutableString, &mutableString);
//    NSLog(@"%p %p", _sstring, &_sstring);
//    NSLog(@"%p %p", _cstring, &_cstring);
//    
//    NSLog(@"#1: %d", _objc_rootRetainCount(mutableString));
//    NSLog(@"#2: %d", _objc_rootRetainCount(_sstring));
//    NSLog(@"#2: %d", _objc_rootRetainCount(_cstring));
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        id __strong tmp1 = [[NSObject alloc] init];
        NSLog(@"tmp1 retainCount: %d", _objc_rootRetainCount(tmp1));
        id __strong tmp2 = tmp1;
        NSLog(@"tmp1 retainCount: %d", _objc_rootRetainCount(tmp1));
        /**
         第一次打印1，第二次打印2，因为tmp2指向tmp1，引用计数加1
         */
        
        id __strong tmp3 = [NSString stringWithFormat:@"def"];
        NSLog(@"tmp3 retainCount: %ld", _objc_rootRetainCount(tmp3));
        id __strong tmp4 = tmp3;
        NSLog(@"tmp3 retainCount: %ld", _objc_rootRetainCount(tmp3));
        /**
         第一次打印与第二次打印相同，都是1667391797，不知道这个是什么含义
         解释是：因为@“abc”是字符串常量，系统不会对其进行回收，所以引用计数无效
         */
        
        NSMutableString* mutableString = [NSMutableString stringWithFormat:@"abcdefg"];
        NSLog(@"mutableString retainCount: %d", _objc_rootRetainCount(mutableString));
        /**
         _objc_rootRetainCount -> 1
         po [mutableString retainCount] -> 2
         */
        
        NSString* stableString = [NSString stringWithFormat:@"hijklmn"];
        NSLog(@"stableString retainCount: %d", _objc_rootRetainCount(stableString));
        /**
         _objc_rootRetainCount -> 178529217
         po [stable retainCount] -> 18446744073709551615(-1)
         */
        
        NSString* stableString2 = @"qwerty";
        NSLog(@"stableString2 retainCount: %d", _objc_rootRetainCount(stableString2));
        /**
         _objc_rootRetainCount -> 1
         po [stableString2 retainCount] -> 18446744073709551615(-1)
         */
        
        NSArray* stableArray = [NSArray arrayWithObjects:@1, @2, @3, nil];
        NSLog(@"stableArray retainCount: %d", _objc_rootRetainCount(stableArray));
        /**
         _objc_rootRetainCount -> 2
         po [stableArray retainCount] -> 2
         */
        
        NSMutableArray* mutableArray = [NSMutableArray arrayWithObjects:@1, @2, @3, nil];
        NSLog(@"mutableArray retainCount: %d", _objc_rootRetainCount(mutableArray));
        /**
         _objc_rootRetainCount -> 2
         po [mutableArray retainCount] -> 2
         */
        
        /**
         小结一下，以po为准，满足资料中所说的，字符串常量是没有引用计数的，所以是-1
         至于NSMutableString为什么是2，可能是内部实现方式的问题吧，目前只能这样认为了。
         */
        
        CTest* obj = [[CTest alloc] init];
        [obj test];
        
    }
    return 0;
}
