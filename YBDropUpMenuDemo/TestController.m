//
//  TestController.m
//  YBDropUpMenuDemo
//
//  Created by ting on 15-2-2.
//  Copyright (c) 2015年 yuanbo. All rights reserved.
//

#import "TestController.h"
#import "JSONKit.h"
#import "DropUpMenuItem.h"

@implementation TestController

-(void)viewDidLoad{
    [super viewDidLoad];
    
//    
        NSString* json = @"[{\"title\": \"测试1\",\"items\": [{\"title\":\"item1\"},{\"title\":\"item2\"}]},{\"title\": \"测试1\",\"items\": [{\"title\":\"item1\"},{\"title\":\"item2\"}]},{\"title\": \"测试1\",\"items\": [{\"title\":\"item1\"},{\"title\":\"item2\"}]}]";
    
        NSArray* array = [json objectFromJSONString];
//    //
//    //    DropUpMenuGroup* group = [[DropUpMenuGroup alloc] initWithFrame:CGRectMake(0, 100, 300, 30) formatDict:array];
//    //
//    //    [self.view addSubview:group];
//    
//    NSMutableArray *dropdownItems = [[NSMutableArray alloc] init];
//    for (int i = 0; i < 3; i++) {
//        
//        NSDictionary *item = [NSDictionary dictionaryWithObjectsAndKeys:@"title1",@"title", nil];
//        [dropdownItems addObject:item];
//    }
//    DropUpMenu *menu1 = [[DropUpMenu alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2, 100, 45) showText:@"测试" items:dropdownItems];
//
//    
//    [self.view addSubview:menu1];
    
    DropUpMenuController *dropcontroller = [[DropUpMenuController alloc] initWithData:array owner:self];
    dropcontroller.delegate = self;//很重要
    [self.view addSubview:dropcontroller.view];
        
}

-(void)itemClickAction:(id)sender{
    NSString* href = ((DropUpMenuItem*)sender).href;
    NSLog(@"%@",href);
}

-(void)buttonClickSendAction:(id)sender inputInfo:(NSString *)info{
    NSLog(@"%@",info);
}

@end
