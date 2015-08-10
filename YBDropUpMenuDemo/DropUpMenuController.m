//
//  DropUpMenuController.m
//  YBDropUpMenuDemo
//
//  Created by ting on 15-2-5.
//  Copyright (c) 2015年 yuanbo. All rights reserved.
//

#import "DropUpMenuController.h"
#import "DropUpChangeButton.h"
#import "DropUpMenuItem.h"
#import "DropUpMenu.h"



#define SCREEN_WIDTH self.owner.view.bounds.size.width //当前屏幕宽
#define SCREEN_HEIGHT self.owner.view.bounds.size.height//当前屏幕高

@interface DropUpMenuController ()

@property(nonatomic,retain)UIControl *menucontrol;//菜单控制
@property(nonatomic,retain)NSMutableArray *menuarray;//菜单数组
@property(nonatomic,retain)NSMutableArray *itemarray;//菜单项数组

@property(nonatomic,retain)DropUpChangeButton* up2key;//切换到输入按钮
@property(nonatomic,retain)DropUpChangeButton* up2menu;//切换到菜单按钮

@property(nonatomic,retain)UIView *inputView;//输入交互视图

@property(nonatomic) float paddingleft;//左内边距

@property(nonatomic,retain) NSString* url;//webview 地址

@end

@implementation DropUpMenuController


@synthesize isHasInteractiveInput = _isHasInteractiveInput;
@synthesize menuheight = _menuheight;
@synthesize paddingleft = _paddingleft;
@synthesize data = _data;
@synthesize owner = _owner;
@synthesize menucontrol = _menucontrol;
@synthesize itemarray = _itemarray;
@synthesize up2key = _up2key;
@synthesize inputView = _inputView;
@synthesize delegate = _delegate;
@synthesize inputAndButton = _inputAndButton;
@synthesize webView = _webView;
@synthesize isHasWebView = _isHasWebView;
@synthesize url = _url;

/**
 *	@brief	数据初始化
 *
 *	@param 	array 	数据
 *
 *	@return	self
 */
- (instancetype)initWithData:(NSArray*)array owner:(UIViewController*)owner url:(NSString *)url
{
    self = [super init];
    _owner = owner;
    _data = array;
    [self setInitValue];
    [self setNotificationCenter];
    return self;
}

/**
 *	@brief	释放
 */
-(void)dealloc
{
    [_data release];
    [_owner release];
    [_menucontrol release];
    [_itemarray release];
    [_inputView release];
    [_delegate release];
    [_inputAndButton release];
    [_webView release];
    [_url release];
    
    [super dealloc];
}

/**
 *	@brief	设置默认值
 */
-(void)setInitValue
{
    _itemarray = [[NSMutableArray alloc] init];
    _menuarray = [[NSMutableArray alloc] init];
    _isHasInteractiveInput = true;
    _isHasWebView = true;
    _menuheight = 40.0f;
    _paddingleft = 0.0f;
}


/**
 *	@brief	设置消息通知
 */
-(void)setNotificationCenter
{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

/**
 *	@brief	当键盘出现或改变时调用
 *
 *	@param 	aNotification 	消息
 */
- (void)keyboardWillShow:(NSNotification *)aNotification

{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int keyboardheight = keyboardRect.size.height;
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard"context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect rect = CGRectMake(0.0f, -keyboardheight,width,height); //上推键盘操作,view大小始终没变
    self.view.frame = rect;
    [UIView commitAnimations];
}

/**
 *	@brief	当键退出时调用
 *
 *	@param 	aNotification 	消息
 */
- (void)keyboardWillHide:(NSNotification *)aNotification

{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard"context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect rect = CGRectMake(0.0f, 0.0f,width,height); //还原键盘
    self.view.frame = rect;
    [UIView commitAnimations];
}

/**
 *	@brief	视图加载时
 */
-(void)viewDidLoad
{
    if (_isHasWebView) {
        [self initWebView];
    }
    if (_isHasInteractiveInput) {
        _paddingleft = _menuheight;
        [self initInputView];
    }
    [self initMenuView];
    
}


/**

 *	@brief	初始化webview

 */
-(void)initWebView{
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , self.view.frame.size.height)];
    _webView.delegate = self;
    
    [self Reflush:nil];
    [self.view addSubview:_webView];
}

/**
 *	@brief 初始化菜单
 */
-(void)initMenuView
{
    _menucontrol = [[[UIControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-_menuheight, SCREEN_WIDTH, SCREEN_HEIGHT)] autorelease];
    [_menucontrol addTarget:self action:@selector(menucontrolClickAction:) forControlEvents:UIControlEventTouchDown];
    
    if (_isHasInteractiveInput) {
        _up2key = [[[DropUpChangeButton alloc] initWithFrame:CGRectMake(0,0,_menuheight,_menuheight) imageNamed:@"keyboard_down.png"] autorelease];
        [_up2key addTarget:self action:@selector(dropUpToKeyClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_menucontrol addSubview:_up2key];
    }
    
    //一级横向菜单
    for (int i =0 ; i<_data.count; i++) {
        NSMutableArray* items = [_data[i] objectForKey:@"items"];
        NSString *title = [_data[i] objectForKey:@"title"];
        DropUpMenu *menu = [[[DropUpMenu alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-_menuheight)/_data.count*i+_paddingleft, 0, (SCREEN_WIDTH-_menuheight)/_data.count, _menuheight) showText:title] autorelease];
        menu.tag = i;
        
        //二级纵向菜单
        for (int j = 0; j<items.count; j++) {
            //NSString* title = [items[j] objectForKey:@"title"];
            DropUpMenuItem* item = [[[DropUpMenuItem alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-_menuheight)/_data.count*i+_paddingleft, 0, (SCREEN_WIDTH-_menuheight)/_data.count, _menuheight) params:items[j]] autorelease];
            item.alpha = 0.0;
            item.tag = i;
            [item addTarget:self action:@selector(itemClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [_menucontrol addSubview:item];
            [_itemarray addObject:item];
        }
        
        [menu addTarget:self action:@selector(menuClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_menucontrol addSubview:menu];
        
        [_menuarray addObject:menu];
        
        [self.view addSubview:_menucontrol];
    }
}

/**
 *	@brief	初始化交互输入视图
 */
-(void)initInputView
{
    _inputView = [[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-_menuheight, SCREEN_WIDTH, SCREEN_HEIGHT)] autorelease];
    [[_inputView layer] setBorderWidth:0.5];//画线的宽度
    [[_inputView layer] setBorderColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1].CGColor];//颜色
    _inputView.alpha = 0.0;
    _up2menu = [[[DropUpChangeButton alloc] initWithFrame:CGRectMake(0,0,_menuheight,_menuheight) imageNamed:@"keyboard_up.png"] autorelease];
    [_up2menu addTarget:self action:@selector(dropUpToMenuClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [_inputView addSubview:_up2menu];
    
    _inputAndButton = [[DropUpInput alloc] initWithFrame:CGRectMake(_paddingleft, 0, SCREEN_WIDTH-_paddingleft, _menuheight)];
    _inputAndButton.delegate = self;
    [_inputView addSubview:_inputAndButton];
    
    [self.view addSubview:_inputView];
}

/**
 *	@brief	刷新
 */
-(void)Reflush:(NSString*)url
{
    if (url!=nil) {
        _url = url;
    }
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url copy]]];
    [_webView loadRequest:request];
}


-(void)menucontrolClickAction:(id)sender{
    [self menuReview];
}

/**
 *	@brief	点击按钮显示输入交互
 */
-(void)dropUpToKeyClickAction:(id)sender{
    //UISegmentedControl* control = (UISegmentedControl*)sender;
    [UIView animateWithDuration:0.5 animations:^{
        _menucontrol.alpha = 0.0;
        [_menucontrol setFrame:CGRectMake(_menucontrol.frame.origin.x, _menucontrol.frame.origin.y+_menucontrol.frame.size.height,_menucontrol.frame.size.width, _menucontrol.frame.size.height)];
    }
                     completion:^(BOOL finished){
                         _inputView.alpha = 1.0;
                         [_menucontrol setFrame:CGRectMake(_menucontrol.frame.origin.x, _menucontrol.frame.origin.y-_menucontrol.frame.size.height,_menucontrol.frame.size.width, _menucontrol.frame.size.height)];
                     }];
}

/**
 *	@brief	点击按钮显示菜单
 */
-(void)dropUpToMenuClickAction:(id)sender{
    //UISegmentedControl* control = (UISegmentedControl*)sender;
    [UIView animateWithDuration:0.5 animations:^{
        _inputView.alpha = 0.0;
        [_inputView setFrame:CGRectMake(_inputView.frame.origin.x, _inputView.frame.origin.y+_inputView.frame.size.height,_inputView.frame.size.width, _inputView.frame.size.height)];
    }
                     completion:^(BOOL finished){
                         _menucontrol.alpha = 1.0;
                         [_inputView setFrame:CGRectMake(_inputView.frame.origin.x, _inputView.frame.origin.y-_inputView.frame.size.height,_inputView.frame.size.width, _inputView.frame.size.height)];
                     }];
}


/**
 *	@brief	重新加载菜单视图
 */
-(void)menuReview
{
    [_menucontrol setFrame:CGRectMake(0, SCREEN_HEIGHT-_menuheight, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (_isHasInteractiveInput) {
        [_up2key setFrame:CGRectMake(0,0, _up2key.frame.size.width, _up2key.frame.size.height)];
    }
    for (int i = 0; i< _menuarray.count; i++) {
        DropUpMenu* menu = _menuarray[i];
        menu.IsExpend = NO;
        [menu unSelected];
        [menu setFrame:CGRectMake((SCREEN_WIDTH-_menuheight)/_menuarray.count*i+_paddingleft, 0, (SCREEN_WIDTH-_menuheight)/_menuarray.count, _menuheight)];
        for (DropUpMenuItem* item in _itemarray) {
            if (menu.tag==item.tag) {
                [item setFrame:CGRectMake(menu.frame.origin.x, menu.frame.origin.y, item.frame.size.width, item.frame.size.height)];
                [UIView animateWithDuration:0.5 animations:^{
                    item.alpha = 0.0;
                }];
            }
        }
    }
    
}


/**
 *	@brief	重新加载交互输入视图
 */
-(void)inputReview
{
    [_inputView setFrame:CGRectMake(0, SCREEN_HEIGHT-_menuheight, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (_isHasInteractiveInput) {
        [_up2menu setFrame:CGRectMake(0,0, _up2menu.frame.size.width, _up2menu.frame.size.height)];
    }
    
}


/**
 *	@brief	菜单点击
 */
-(void)menuClickAction:(id)sender{
    [self menuReview];//重置视图
    DropUpMenu* menu = (DropUpMenu*)sender;
    if (!menu.IsExpend) {
        menu.IsExpend = YES;
        [menu selected];
        
        UISegmentedControl* control = (UISegmentedControl*)sender;
        [_menucontrol setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        if (_isHasInteractiveInput) {
            [_up2key setFrame:CGRectMake(_up2key.frame.origin.x, _menucontrol.frame.size.height-_menuheight, _up2key.frame.size.width, _up2key.frame.size.height)];
        }
        for (int i = 0; i< _menuarray.count; i++) {
            DropUpMenu* menu = _menuarray[i];
            [menu setFrame:CGRectMake(menu.frame.origin.x, _menucontrol.frame.size.height-_menuheight,menu.frame.size.width, menu.frame.size.height)];
        }
        int i = 1;
        for (DropUpMenuItem* item in _itemarray) {
            if (item.tag==control.tag) {
                [item setFrame:CGRectMake(control.frame.origin.x-4.0f, control.frame.origin.y-item.frame.size.height*i, item.frame.size.width, item.frame.size.height)];
                [UIView animateWithDuration:0.6 animations:^{
                    item.alpha = 1.0;
                }];
                
                i++;
            }
        }
    }else{
        menu.IsExpend = NO;
    }
}


/**
 *	@brief	菜单项点击
 */
-(void)itemClickAction:(id)sender{
    [_delegate itemClickAction:sender];
}

/**
 *	@brief	发送按钮点击
 */
-(void)clickToSend:(id)sender inputInfo:(NSString *)inputInfo{
    [_delegate buttonClickSendAction:sender inputInfo:inputInfo];
}



//delegate

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (![_inputView isExclusiveTouch]) {
        [_inputAndButton resignFirstResponder];
    }
}


/**
 *	@brief	开始加载时
 *
 *	@param 	webView 	webview
 */
- (void)webViewDidStartLoad:(UIWebView *)webView

{
    [_delegate webViewDidStartLoad:webView];
}

/**
 *	@brief	加载完成时
 *
 *	@param 	webView 	webview
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView

{
    [_delegate webViewDidFinishLoad:webView];
}

#pragma mark webview每次加载之前都会调用这个方法
// 如果返回NO，代表不允许加载这个请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return [_delegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
}



@end
