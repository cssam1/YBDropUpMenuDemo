//
//  DropUpMenuItem.m
//  YBDropUpMenuDemo
//
//  Created by ting on 15-2-2.
//  Copyright (c) 2015年 yuanbo. All rights reserved.
//

#import "DropUpMenuItem.h"

@interface DropUpMenuItem()

@property(nonatomic) CGSize size;
//背景view
@property (nonatomic, strong) UIView *bgView;
//文本
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation DropUpMenuItem

/**
 *	@brief	初始化菜单项
 *
 *	@param 	frame 	位置／大小
 *	@param 	item 	项参数字典
 *
 *	@return	self
 */
- (instancetype)initWithFrame:(CGRect)frame params:(NSDictionary*)item
{
    _title = item[@"title"];
    _href = item[@"href"];
    
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
    [_textLabel release];
    [_bgView release];
    [_title release];
    [_href release];
    
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
    self.bgView.layer.shadowColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:0.7].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(1, -2);
    self.bgView.layer.shadowOpacity = 0.3;
    self.bgView.layer.shouldRasterize = YES;
    [self.bgView setFrame:self.bounds];
    [self addSubview:self.bgView];
    
    self.textLabel = [[[UILabel alloc] init] autorelease];
    self.textLabel.numberOfLines = 0;
    self.textLabel.textColor = [UIColor blackColor];
    [self.textLabel setFont:[UIFont systemFontOfSize:12.0f]];
    self.textLabel.text = _title;
    self.textLabel.textAlignment = UITextAlignmentCenter;
    CGSize textsize = [self.textLabel.text sizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(_size.width-20, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    [self.textLabel setFrame:CGRectMake((_size.width-textsize.width)/2.0f, (_size.height-textsize.height)/2.0f,  textsize.width, textsize.height)];
    
    [self addSubview:self.textLabel];
    
}



@end
