//
//  DropUpMenu.h
//  YBDropUpMenuDemo
//
//  Created by ting on 15-2-9.
//  Copyright (c) 2015年 yuanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropUpMenu : UIControl

@property(nonatomic,strong) NSString* itemText;
@property(nonatomic) BOOL IsExpend;//是否是被打开


/**
 *	@brief	初始化菜单项
 *
 *	@param 	frame 	位置／大小
 *	@param 	showText 	显示文字
 *
 *	@return	self
 */
- (instancetype)initWithFrame:(CGRect)frame showText:(NSString*)itemText;

/**
 *	@brief 被选中时方法
 */
-(void)selected;

/**
 *	@brief 取消选中时方法
 */
-(void)unSelected;

@end
