//
//  TestController.h
//  YBDropUpMenuDemo
//
//  Created by ting on 15-2-2.
//  Copyright (c) 2015年 yuanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropUpMenuController.h"

@interface TestController : UIViewController
<DropUpMenuDelegate>

@property (nonatomic, copy) NSArray* upDownItems;

@property(nonatomic,copy) NSString* showText;


@end
