//
//  CustomScrollView.m
//  Yimu
//
//  Created by 小普 on 14-5-21.
//  Copyright (c) 2014年 NjrSea. All rights reserved.
//

#import "CustomScrollView.h"

#define kMinVelocity 0.8

@interface CustomScrollView ()
@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, assign) DraggingDirection direction;
@property (nonatomic, assign) BOOL changePage;
@property (nonatomic, assign) BOOL ignoreOffset;
@end

@implementation CustomScrollView

- (id)initWithLeftViewController:(UIViewController *)leftViewController centerViewController:(UIViewController *)centerViewController rightViewController:(UIViewController *)rightViewController andFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _leftViewController = leftViewController;
        _centerViewController = centerViewController;
        _rightViewController = rightViewController;
        [self setup];
    }
    return self;
}

#pragma mark - setup
- (void)setup {
  
    self.delegate = self;
    self.contentSize = CGSizeMake(3*ScreenWidth, 400);
    self.contentOffset = CGPointMake(ScreenWidth, 0);
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.bounces = YES;
    self.alwaysBounceVertical = NO;
    self.pagingEnabled = YES;
    


    self.leftView = [[UIView alloc] init];
    self.centerView = [[UIView alloc] init];
    self.rightView  = [[UIView alloc] init];
    
    [self.leftView addSubview:self.leftViewController.view];
    [self.centerView addSubview:self.centerViewController.view];
    [self.rightView addSubview:self.rightViewController.view];
    
    CGRect rect = CGRectMake(0, 0, ScreenWidth, 400);
    [self.leftView setFrame:rect];
    rect.origin.x += ScreenWidth;
    [self.centerView setFrame:rect];
    rect.origin.x += ScreenWidth;
    [self.rightView setFrame:rect];
    
    [self addSubview:self.leftView];
    [self addSubview:self.centerView];
    [self addSubview:self.rightView];
}



#pragma mark - UIScrollView delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.beginPoint = scrollView.contentOffset;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (self.beginPoint.x > scrollView.contentOffset.x) {
        self.direction = DraggingDirectionRight;
        if (self.contentOffset.x >=0 && self.contentOffset.x < 160) {
            self.changePage = YES;
        } else {
            self.changePage = NO;
        }
    } else {
        self.direction = DraggingDirectionLeft;
        if (self.contentOffset.x > 480 && self.contentOffset.x <= 1440) {
            self.changePage = YES;
             NSLog(@"self.changePage = YES;");
        } else {
            self.changePage = NO;
            NSLog(@"self.changePage = NO;");
        }
    }
    
    if (self.ignoreOffset) {
        self.changePage = YES;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0) {
    
    if (fabsf(velocity.x) >= 0.3) {
        self.changePage = YES;
        self.ignoreOffset = YES;
    } else {
        self.ignoreOffset = NO;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.contentOffset = CGPointMake(ScreenWidth, 0);
    if (self.direction == DraggingDirectionRight && self.changePage) {
        [self goRight];
    } else if (self.direction == DraggingDirectionLeft && self.changePage){
        [self goLeft];
    }
}

- (void)goRight {
    
    if ([self.customScrollViewDelegate respondsToSelector:@selector(customScrollView:updateViewControllersWithDirection:)]) {
        [self.customScrollViewDelegate customScrollView:self updateViewControllersWithDirection:DraggingDirectionRight];
        [self updateViews];
    }
}

- (void)goLeft {
    if ([self.customScrollViewDelegate respondsToSelector:@selector(customScrollView:updateViewControllersWithDirection:)]) {
        [self.customScrollViewDelegate customScrollView:self updateViewControllersWithDirection:DraggingDirectionLeft];
        [self updateViews];
    }
}

#pragma mark - update
- (void)updateViews {
    [self.leftViewController.view removeFromSuperview];
    [self.centerViewController.view removeFromSuperview];
    [self.rightViewController.view removeFromSuperview];
 
    [self.leftView addSubview:self.leftViewController.view];
    [self.centerView addSubview:self.centerViewController.view];
    [self.rightView addSubview:self.rightViewController.view];
}


@end
