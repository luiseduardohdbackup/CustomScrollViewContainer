//
//  CustomScrollView.h
//  Yimu
//
//  Created by 小普 on 14-5-21.
//  Copyright (c) 2014年 NjrSea. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DraggingDirection) {
    DraggingDirectionLeft = 0,
    DraggingDirectionRight
};

@protocol CustomScrollViewDelegate;

@interface CustomScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, assign) id<CustomScrollViewDelegate> customScrollViewDelegate;
@property (nonatomic, weak) UIViewController *leftViewController;
@property (nonatomic, weak) UIViewController *centerViewController;
@property (nonatomic, weak) UIViewController *rightViewController;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, assign) NSUInteger pageIndex;

- (id)initWithLeftViewController:(UIViewController *)leftViewController centerViewController:(UIViewController *)centerViewController rightViewController:(UIViewController *)rightViewController andFrame:(CGRect)frame;

@end

@protocol CustomScrollViewDelegate <NSObject>

- (void)customScrollView:(CustomScrollView *)scrollView updateViewControllersWithDirection:(DraggingDirection) direction;

@end
