//
//  WPGestureunlockView.h
//  WPGestureunlockViewController
//
//  Created by 吴鹏 on 16/8/30.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPGestureunlockView;
@protocol WPGestureunlockDelegate <NSObject>

- (void)wp_gestureUnlockPassword:(NSString *)passwordStr;

@end

@interface WPGestureunlockView : UIView

@property (nonatomic , strong) id<WPGestureunlockDelegate>delegate;

@end
