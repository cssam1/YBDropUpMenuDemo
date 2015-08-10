//
//  DropUpMenuInput.m
//  YBDropUpMenuDemo
//
//  Created by ting on 15-2-11.
//  Copyright (c) 2015年 yuanbo. All rights reserved.
//

#import "DropUpInput.h"

@interface DropUpInput()


@property(nonatomic) CGSize size;//视图大小

@end

@implementation DropUpInput

@synthesize inputfield = _inputfield;
@synthesize sendbutton = _sendbutton;
@synthesize size = _size;
@synthesize delegate = _delegate;

/**
 *	@brief	初始化输入视图
 *
 *	@param 	frame 	位置／大小
 *
 *	@return	self
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    _size = frame.size;
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

/**
 *	@brief	释放
 */
-(void)dealloc
{
    [_delegate release];
    [_inputfield release];
    [_sendbutton release];
    
    [super dealloc];
}

/**
 *	@brief	初始化视图
 */
-(void)initView
{
    [[self layer] setBorderWidth:0.5];//画线的宽度
    [[self layer] setBorderColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1].CGColor];//颜色
    
    [[self layer] setBackgroundColor:[UIColor whiteColor].CGColor];
    
    _inputfield = [[[UITextField alloc] initWithFrame:CGRectMake(20.0, _size.height*0.15f,_size.width-80.0, _size.height*0.7f)] autorelease];
    [_inputfield setBorderStyle:UITextBorderStyleRoundedRect]; //外框类型
    _inputfield.placeholder = @""; //默认显示的字
    _inputfield.autocorrectionType = UITextAutocorrectionTypeNo;
    _inputfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _inputfield.returnKeyType = UIReturnKeyDone;
    _inputfield.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    
    _inputfield.delegate = self;
    [self addSubview:_inputfield];
    
    _sendbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_sendbutton setFrame:CGRectMake(_size.width-50.0f, 0, 40.0f, 40.0f)];
    [_sendbutton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendbutton addTarget:self action:@selector(clickToSend:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendbutton];

}

/**
 *	@brief	发送按钮点击
 */
-(void)clickToSend
:(id)sender{
    [_delegate clickToSend:sender inputInfo:_inputfield.text];
}

/**
 *	@brief	textfield开始编辑时
 *
 *	@param 	textField 	textField
 */
-(void)textFieldDidBeginEditing:(UITextField *)textField{
   
}

/**
 *	@brief	重写失去焦点
 *
 *	@return	YES
 */
-(BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    [_inputfield resignFirstResponder];
    return YES;
}

@end
