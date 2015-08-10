//
//  DropUpMenuInput.h
//  YBDropUpMenuDemo
//
//  Created by ting on 15-2-11.
//  Copyright (c) 2015年 yuanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DropUpInputDelegate <NSObject>

/**
 *	@brief	发送按钮
 *
 *  @param  sender 按钮对象
 *	@param 	inputInfo 	输入框信息
 */
-(void)clickToSend:(id)sender inputInfo:(NSString*)inputInfo;

@end

@interface DropUpInput : UIView
<UITextFieldDelegate>

@property(nonatomic,retain) id<DropUpInputDelegate> delegate;
@property(nonatomic,retain) UITextField* inputfield; //输入框
@property(nonatomic,retain) UIButton* sendbutton; //发送按钮

/**
 *	@brief	重写失去焦点
 *
 *	@return	YES
 */
-(BOOL)resignFirstResponder;

@end
