//
//  DropUpMenuController.h
//  YBDropUpMenuDemo
//
//  Created by ting on 15-2-5.
//  Copyright (c) 2015年 yuanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropUpInput.h"

@protocol DropUpMenuDelegate <NSObject>

/**
 *	@brief	菜单项点击委托
 *
 *	@param 	sender 	菜单项
 */
-(void)itemClickAction:(id)sender;

/**
 *	@brief	发送按钮点击委托
 *
 *	@param 	info 输入框信息
 */
-(void)buttonClickSendAction:(id)sender inputInfo:(NSString*)info;

//webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;



@end

@interface DropUpMenuController : UIViewController
<
DropUpInputDelegate,
UIWebViewDelegate
>

@property(nonatomic) float menuheight;//菜单高度
@property(nonatomic) BOOL isHasInteractiveInput;//是否有交互式输入
@property(nonatomic,strong) NSArray* data;//数据
@property (nonatomic,retain) UIViewController *owner;//父视图

@property(nonatomic,retain)DropUpInput *inputAndButton;//输入和按钮视图部分

@property(nonatomic,retain)UIWebView* webView;//webview
@property(nonatomic) BOOL isHasWebView;//是否有webview

@property(nonatomic,retain) id<DropUpMenuDelegate> delegate;//菜单委托



/**
 *	@brief	数据初始化
 *
 *	@param 	array 	数据
 *
 *	@return	self
 */
- (instancetype)initWithData:(NSArray*)array owner:(UIViewController*)owner url:(NSString *)url;

@end
