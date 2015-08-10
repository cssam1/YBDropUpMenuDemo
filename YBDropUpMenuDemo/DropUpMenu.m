//
//  DropUpMenuItem.m
//  YBDropUpMenuDemo
//
//  Created by ting on 15-2-2.
//  Copyright (c) 2015年 yuanbo. All rights reserved.
//

#import "DropUpMenu.h"

@interface DropUpMenu()

@property(nonatomic) CGSize size;
//背景view
@property (nonatomic, strong) UIView *bgView;
//文本
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation DropUpMenu

@synthesize itemText = _itemText;
@synthesize IsExpend = _IsExpend;

/**
 *	@brief	初始化菜单项
 *
 *	@param 	frame 	位置／大小
 *	@param 	showText 	显示文字
 *
 *	@return	self
 */
- (instancetype)initWithFrame:(CGRect)frame showText:(NSString*)itemText
{
    _size = frame.size;
    _itemText = itemText;
    _IsExpend = NO;
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
    [_textLabel release];
    [_bgView release];
    [_itemText release];
    
    [super dealloc];
}

/**
 *	@brief	初始化视图
 */
- (void)initView
{
    self.bgView = [[[UIView alloc] init] autorelease];
    self.bgView.userInteractionEnabled = NO;
    self.bgView.backgroundColor = [UIColor whiteColor];
    [[self.bgView layer] setBorderWidth:0.5];//画线的宽度
    [[self.bgView layer] setBorderColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1].CGColor];//颜色
    //[[self.bgView layer]setCornerRadius:1.0];//圆角
    self.bgView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
    self.bgView.layer.shadowOpacity = 0.1;
    self.bgView.layer.shouldRasterize = YES;
    [self.bgView setFrame:self.bounds];
    [self addSubview:self.bgView];
    
    self.textLabel = [[[UILabel alloc] init] autorelease];
    self.textLabel.numberOfLines = 0;
    self.textLabel.textColor = [UIColor blackColor];
    [self.textLabel setFont:[UIFont systemFontOfSize:12.0f]];
    self.textLabel.text = _itemText;
    self.textLabel.textAlignment = UITextAlignmentCenter;
    CGSize textsize = [self.textLabel.text sizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(_size.width-20, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    [self.textLabel setFrame:CGRectMake((_size.width-textsize.width)/2.0f, (_size.height-textsize.height)/2.0f,  textsize.width, textsize.height)];
    
    [self addSubview:self.textLabel];
    
}


/**
 *	@brief 被选中时方法
 */
-(void)selected
{
    self.bgView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
}

/**
 *	@brief 取消选中时方法
 */
-(void)unSelected
{
    self.bgView.backgroundColor = [UIColor whiteColor];
}


@end
