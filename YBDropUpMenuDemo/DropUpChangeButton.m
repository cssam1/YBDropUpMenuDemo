//
//  DropUpToKeyView.m
//  YBDropUpMenuDemo
//
//  Created by ting on 15-2-5.
//  Copyright (c) 2015年 yuanbo. All rights reserved.
//

#import "DropUpChangeButton.h"

@interface DropUpChangeButton ()


@end

@implementation DropUpChangeButton

@synthesize imagename = _imagename;


/**
 *	@brief	初始化视图(重写)
 *
 *	@param 	frame 	大小
 *  @param  name  图片地址
 *
 *	@return	self
 */
-(instancetype)initWithFrame:(CGRect)frame imageNamed:(NSString*)name
{
    self = [super initWithFrame:frame];
    _imagename = name;
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
    
    [_imagename release];
    
    [super dealloc];
}

/**
 *	@brief	加载视图
 */
-(void)initView
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    [[self layer] setBorderWidth:0.5];//画线的宽度
    [[self layer] setBorderColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1].CGColor];//颜色
    //[[self.bgView layer]setCornerRadius:1.0];//圆角
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.1;
    [self setFrame:self.bounds];
    [self setImage:[UIImage imageNamed:_imagename] forState:UIControlStateNormal];
}

@end
