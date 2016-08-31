//
//  ViewController.m
//  WPGestureunlockViewController
//
//  Created by 吴鹏 on 16/8/26.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import "ViewController.h"
#import "WPGestureunlockView.h"

@interface ViewController () <UITableViewDelegate , UITableViewDataSource,WPGestureunlockDelegate>
{
    float yy;
    BOOL isShow;
}

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) CAShapeLayer * eyeFirstLightLayer;
@property (nonatomic , strong) CAShapeLayer *eyeSecondLightLayer;
@property (nonatomic , strong) CAShapeLayer *eyeballLayer;
@property (nonatomic , strong) CAShapeLayer *topEyesocketLayer;
@property (nonatomic , strong) CAShapeLayer *bottomEyesocketLayer;

@property (nonatomic , strong) UIView * contentView;


@end

@implementation ViewController

- (void)viewDidLoad
{
    self.title = @"手势密码&眼睛";
    [super viewDidLoad];
    [self refreshLayer];
    
    WPGestureunlockView * wp = [[WPGestureunlockView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    wp.delegate = self;
    [self.view addSubview:wp];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.tableView];
}


#pragma mark - property

- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)- 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (UIView *)contentView
{
    if(!_contentView)
    {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - 30, 80, 60, 60)];
        [_contentView.layer addSublayer:self.eyeFirstLightLayer];
        [_contentView.layer addSublayer:self.eyeSecondLightLayer];
        [_contentView.layer addSublayer:self.eyeballLayer];
        [_contentView.layer addSublayer:self.topEyesocketLayer];
        [_contentView.layer addSublayer:self.bottomEyesocketLayer];
    }
    return _contentView;
}

- (CAShapeLayer *)eyeFirstLightLayer
{
    if (!_eyeFirstLightLayer)
    {
        _eyeFirstLightLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.contentView.frame) / 2, CGRectGetHeight(self.contentView.frame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:CGRectGetWidth(self.contentView.frame) * 0.1
                                                        startAngle:(230.f / 180.f) * M_PI
                                                          endAngle:(265.f / 180.f) * M_PI
                                                         clockwise:YES];
        _eyeFirstLightLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeFirstLightLayer.lineWidth = 5.f;
        _eyeFirstLightLayer.path = path.CGPath;
        _eyeFirstLightLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeFirstLightLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _eyeFirstLightLayer;
}

- (CAShapeLayer *)eyeSecondLightLayer
{
    if (!_eyeSecondLightLayer)
    {
        _eyeSecondLightLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.contentView.frame) / 2, CGRectGetHeight(self.contentView.frame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:CGRectGetWidth(self.contentView.frame) * 0.1
                                                        startAngle:(211.f / 180.f) * M_PI
                                                          endAngle:(220.f / 180.f) * M_PI
                                                         clockwise:YES];
        _eyeSecondLightLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeSecondLightLayer.lineWidth = 5.f;
        _eyeSecondLightLayer.path = path.CGPath;
        _eyeSecondLightLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeSecondLightLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _eyeSecondLightLayer;
}

- (CAShapeLayer *)eyeballLayer
{
    if (!_eyeballLayer)
    {
        _eyeballLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.contentView.frame) / 2, CGRectGetHeight(self.contentView.frame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:CGRectGetWidth(self.contentView.frame) * 0.2
                                                        startAngle:(0.f / 180.f) * M_PI
                                                          endAngle:(360.f / 180.f) * M_PI
                                                         clockwise:YES];
        _eyeballLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeballLayer.lineWidth = 1.f;
        _eyeballLayer.path = path.CGPath;
        _eyeballLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeballLayer.strokeColor = [UIColor whiteColor].CGColor;
        _eyeballLayer.anchorPoint = CGPointMake(0.5, 0.5);
    }
    return _eyeballLayer;
}

- (CAShapeLayer *)topEyesocketLayer {
    if (!_topEyesocketLayer) {
        _topEyesocketLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.contentView.frame) / 2, CGRectGetHeight(self.contentView.frame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.contentView.frame) / 2)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame) / 2)
                     controlPoint:CGPointMake(CGRectGetWidth(self.contentView.frame) / 2, center.y - center.y - 10)];
        _topEyesocketLayer.borderColor = [UIColor blackColor].CGColor;
        _topEyesocketLayer.lineWidth = 1.f;
        _topEyesocketLayer.path = path.CGPath;
        _topEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _topEyesocketLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _topEyesocketLayer;
}

- (CAShapeLayer *)bottomEyesocketLayer {
    if (!_bottomEyesocketLayer) {
        _bottomEyesocketLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.contentView.frame) / 2, CGRectGetHeight(self.contentView.frame) / 2);
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.contentView.frame) / 2)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame) / 2)
                     controlPoint:CGPointMake(CGRectGetWidth(self.contentView.frame) / 2, center.y + center.y + 10)];
        _bottomEyesocketLayer.borderColor = [UIColor blackColor].CGColor;
        _bottomEyesocketLayer.lineWidth = 1.f;
        _bottomEyesocketLayer.path = path.CGPath;
        _bottomEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _bottomEyesocketLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _bottomEyesocketLayer;
}

#pragma mark - private

- (void)refreshLayer
{
    self.eyeFirstLightLayer.lineWidth = 0.f;
    self.eyeSecondLightLayer.lineWidth = 0.f;
    self.eyeballLayer.opacity = 0.f;
    self.bottomEyesocketLayer.strokeStart = 0.5f;
    self.bottomEyesocketLayer.strokeEnd = 0.5f;
    self.topEyesocketLayer.strokeStart = 0.5f;
    self.topEyesocketLayer.strokeEnd = 0.5f;
}

#pragma mark - UITableViewDelegate & dataDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@" %ld ", indexPath.row];
    
    return cell;
}

#pragma mark - wpgestureDelegate

- (void)wp_gestureUnlockPassword:(NSString *)passwordStr
{
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)- 64);
        self.navigationController.navigationBar.frame = CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 44);
    } completion:^(BOOL finished) {
        [self refreshLayer];
        isShow = NO;
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float y = fabs(scrollView.contentOffset.y);
    
    NSLog(@" %f ",y);
    
    
    if(y > 150)
    {
        isShow = YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)- 64);
            self.navigationController.navigationBar.frame = CGRectMake(0, -44, CGRectGetWidth(self.view.frame), 44);
            
        } completion:^(BOOL finished) {
           
        }];
        
    }else
    {
        if(!isShow)
            [self setAnimation:y];
    }

}

- (void)setAnimation:(float)y
{
    if(y > 76)
    {
        
        if(y - yy > 0)
        {
            if(y > 77)
            {
                if(self.eyeSecondLightLayer.lineWidth <=5)
                {
                    self.eyeFirstLightLayer.lineWidth += 0.5;
                    self.eyeSecondLightLayer.lineWidth += 0.5;
                }
            }
            
            if(y > 87)
            {
                if(self.eyeballLayer.opacity <= 1)
                    self.eyeballLayer.opacity +=0.1;
            }
            
            if(y > 97)
            {
                if(self.topEyesocketLayer.strokeEnd <= 1 && self.topEyesocketLayer.strokeStart >=0)
                {
                    self.topEyesocketLayer.strokeStart -= 0.05;
                    self.topEyesocketLayer.strokeEnd += 0.05;
                    self.bottomEyesocketLayer.strokeStart -= 0.05;
                    self.bottomEyesocketLayer.strokeEnd += 0.05;
                    
                }
            }
            
        }else
        {
            
            if(y > 77)
            {
                if(self.eyeSecondLightLayer.lineWidth > 0)
                {
                    self.eyeFirstLightLayer.lineWidth -= 0.5;
                    self.eyeSecondLightLayer.lineWidth -= 0.5;
                }
            }
            
            if(y > 87)
            {
                if(self.eyeballLayer.opacity > 0)
                    self.eyeballLayer.opacity -=0.1;
            }
            
            if(y > 97)
            {
                if(self.topEyesocketLayer.strokeEnd > 0.5 && self.topEyesocketLayer.strokeStart < 0.5)
                {
                    self.topEyesocketLayer.strokeStart += 0.05;
                    self.topEyesocketLayer.strokeEnd -= 0.05;
                    self.bottomEyesocketLayer.strokeStart += 0.05;
                    self.bottomEyesocketLayer.strokeEnd -= 0.05;
                    
                }
            }
            
        }
    }else
    {
        [self refreshLayer];
    }
    
    yy = y;
}

@end
