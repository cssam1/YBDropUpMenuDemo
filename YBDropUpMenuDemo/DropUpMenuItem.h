//
//  DropUpMenuItem.h
//  YBDropUpMenuDemo
//
//  Created by ting on 15-2-2.
//  Copyright (c) 2015年 yuanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropUpMenuItem : UIControl

@property(nonatomic,retain) NSString* title;
@property(nonatomic,retain) NSString* href;


/**
 *	@brief	初始化菜单项
 *
 *	@param 	frame 	位置／大小
 *	@param 	item 	项参数字典
 *
 *	@return	self
 */
- (instancetype)initWithFrame:(CGRect)frame params:(NSDictionary*)item;


@end
