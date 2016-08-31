//
//  WPGestureunlockView.m
//  WPGestureunlockViewController
//
//  Created by 吴鹏 on 16/8/30.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import "WPGestureunlockView.h"


#define btnView 80

@interface WPBtnView : UIView

@property (nonatomic , strong) NSString * tagStr;

@end

@implementation WPBtnView



@end

@interface WPGestureunlockView ()
{
    CGPoint startPoint;
    CGPoint endPoint;
    /**
     * 线的宽度
     */
    float lineWidth;
    /**
     * 红色代表密码错误
     */
    BOOL lineColor;
}

@property (nonatomic , strong) NSMutableArray * viewArray;
@property (nonatomic , strong) NSMutableArray * endPointArray;
@property (nonatomic , strong) NSMutableArray * startPointArray;
@property (nonatomic , strong) NSMutableArray * passwordStrArray;

@end


@implementation WPGestureunlockView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.viewArray = [NSMutableArray array];
        self.endPointArray = [NSMutableArray array];
        self.startPointArray = [NSMutableArray array];
        self.passwordStrArray = [NSMutableArray array];
        lineColor = YES;
        lineWidth = 5;
        [self setUI];
        
    }
    return self;
}

#pragma mark - draw

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef contentText = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(contentText, kCGLineCapRound);
    CGContextSetLineWidth(contentText, lineWidth);
    if(lineColor)
        CGContextSetRGBStrokeColor(contentText, 1, 1, 1, 1);
    else
        CGContextSetRGBStrokeColor(contentText, 1, 0, 0, 1);
    CGContextBeginPath(contentText);
    
    for(NSInteger i= 0 ; i < self.endPointArray.count ;i++)
    {
        CGContextMoveToPoint(contentText, [self.startPointArray[i] CGPointValue].x, [self.startPointArray[i] CGPointValue].y);
        CGContextAddLineToPoint(contentText, [self.endPointArray[i] CGPointValue].x, [self.endPointArray[i] CGPointValue].y);
         CGContextStrokePath(contentText);
    }
    
    CGContextMoveToPoint(contentText, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(contentText, endPoint.x, endPoint.y);
    CGContextStrokePath(contentText);
    
}

#pragma mark - private

- (void)setUI
{
    float width = CGRectGetWidth(self.frame);
    float space = (width - btnView*3)/4;
    for(NSInteger i = 0 ; i < 9 ; i ++)
    {
        WPBtnView * view = [[WPBtnView alloc]initWithFrame:CGRectMake(space + i%3*(btnView + space), 200 + i/3*(btnView + space), btnView, btnView)];
        view.tagStr = [NSString stringWithFormat:@"%ld",i];
        view.layer.cornerRadius = btnView/2;
        view.layer.borderWidth = 1;
        view.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:view];
        [self.viewArray addObject:view];
    }
}

/**
 * 将记录在数组中的相同元素去掉(因为手指在不停的滑动会把记录的每一个view的tagStr加入多次)
 */

- (NSString *)passwordStr
{
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    
    for (unsigned i = 0; i < [self.passwordStrArray count]; i++)
    {
        
        if ([categoryArray containsObject:[self.passwordStrArray  objectAtIndex:i]] == NO)
        {
            [categoryArray addObject:[self.passwordStrArray  objectAtIndex:i]];
        }
        
    }
    
    //将过滤后的数组转化成字符串
    NSString * str = categoryArray[0];
    for(NSInteger i = 1; i < categoryArray.count; i++)
    {
        NSString * str1 = categoryArray[i];
        str = [str stringByAppendingString:str1];
    }
    
    return str;
    
}

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    lineColor = YES;
    lineWidth = 5;
    CGPoint point = [touches.anyObject locationInView:self];
    for(NSInteger i = 0 ; i < self.viewArray.count ; i ++)
    {
        WPBtnView * view = self.viewArray[i];
        if(CGRectContainsPoint(view.frame, point))
        {
            startPoint = CGPointMake(view.frame.origin.x + btnView/2, view.frame.origin.y + btnView/2);
            [self.startPointArray addObject:[NSValue valueWithCGPoint:startPoint]];
            view.backgroundColor = [UIColor whiteColor];
            break;
        }
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    float width = CGRectGetWidth(self.frame);
    float space = (width - btnView*3)/4;
    CGPoint point = [touches.anyObject locationInView:self];
    
    CGRect fram = CGRectMake(space, 200, btnView * 3 + space *2, btnView*3 + space*2);
    if(CGRectContainsPoint(fram, point))
    {
        for(NSInteger i = 0 ; i < self.viewArray.count ; i ++)
        {
            WPBtnView * view = self.viewArray[i];
            if(CGRectContainsPoint(view.frame, point))
            {
                [self.endPointArray addObject:[NSValue valueWithCGPoint:CGPointMake(view.frame.origin.x + btnView/2, view.frame.origin.y + btnView/2)]];
                if(self.endPointArray.count >1)
                    [self.startPointArray addObject:self.endPointArray[self.endPointArray.count - 2]];
                startPoint = [self.endPointArray[self.endPointArray.count - 1] CGPointValue];
                
                view.backgroundColor = [UIColor whiteColor];
                [self.passwordStrArray addObject:view.tagStr];
                
                break;
            }
        }
        
        endPoint = point;
        [self setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (![[UIApplication sharedApplication] isIgnoringInteractionEvents])
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];

    if([self authenticationPassword:[self passwordStr]])
    {
        if(self.delegate && [self.delegate respondsToSelector:@selector(wp_gestureUnlockPassword:)])
        {
            [self.delegate wp_gestureUnlockPassword:[self passwordStr]];
        }
        [self refreshUI];
    }else
    {
        for(WPBtnView * view in self.viewArray)
        {
            for(NSString * str in self.passwordStrArray)
            {
                if([str isEqualToString:view.tagStr])
                {
                    view.backgroundColor = [UIColor redColor];
                }
            }
        }
        lineColor = NO;
        [self setNeedsDisplay];
        
        [self performSelector:@selector(refreshUI) withObject:nil afterDelay:1];
    }
}

- (BOOL)authenticationPassword:(NSString *)str
{
    //默认密码01258;
    if([str isEqualToString:@"01258"])
        return YES;
    return NO;
}


- (void)refreshUI
{
    UIView * view = self.viewArray[0];
    startPoint = CGPointMake(view.frame.origin.x + btnView/2, view.frame.origin.y + btnView/2);
    endPoint = CGPointMake(view.frame.origin.x + btnView/2, view.frame.origin.y + btnView/2);
    [self.endPointArray removeAllObjects];
    [self.startPointArray removeAllObjects];
    lineColor = YES;
    lineWidth = 0;
    if ([[UIApplication sharedApplication] isIgnoringInteractionEvents])
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
    for(UIView * view in self.viewArray)
    {
        view.backgroundColor = [UIColor clearColor];
    }
    [self.passwordStrArray removeAllObjects];
    
    [self setNeedsDisplay];
}

@end
