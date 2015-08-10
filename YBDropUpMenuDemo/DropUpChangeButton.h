//
//  DropUpToKeyView.h
//  YBDropUpMenuDemo
//
//  Created by ting on 15-2-5.
//  Copyright (c) 2015年 yuanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropUpChangeButton : UIButton

@property(nonatomic,retain) NSString* imagename;

/**
 *	@brief	初始化视图(重写)
 *
 *	@param 	frame 	大小
 *  @param  name  图片地址
 *
 *	@return	self
 */
-(instancetype)initWithFrame:(CGRect)frame imageNamed:(NSString*)name;

@end
