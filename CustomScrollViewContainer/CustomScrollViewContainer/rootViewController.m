//
//  rootViewController.m
//  CustomScrollViewContainer
//
//  Created by 小普 on 14-5-26.
//  Copyright (c) 2014年 NjrSea. All rights reserved.
//

#import "rootViewController.h"
#import "CustomViewController.h"

@interface rootViewController ()

@property (nonatomic, strong) CustomViewController *leftViewController;
@property (nonatomic, strong) CustomViewController *centerViewController;
@property (nonatomic, strong) CustomViewController *rightViewController;

@end

@implementation rootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.leftViewController = [[CustomViewController alloc] init];
    self.leftViewController.view.backgroundColor = [UIColor blackColor];
    self.centerViewController = [[CustomViewController alloc] init];
    self.centerViewController.view.backgroundColor = [UIColor blueColor];
    self.rightViewController = [[CustomViewController alloc] init];
    self.rightViewController.view.backgroundColor = [UIColor brownColor];
    self.scrollView = [[CustomScrollView alloc] initWithLeftViewController:self.leftViewController centerViewController:self.centerViewController rightViewController:self.rightViewController andFrame:CGRectMake(0, 90, ScreenWidth, 400)];
    self.scrollView.customScrollViewDelegate = self;
    [self.view addSubview:self.scrollView];
}

#pragma mark - custom scroll view delegate
- (void)customScrollView:(CustomScrollView *)scrollView updateViewControllersWithDirection:(DraggingDirection) direction {
    CustomViewController *tmpVC = [[CustomViewController alloc] init];
    if (direction == DraggingDirectionLeft) {
        //exchange view controllers index
        tmpVC = self.leftViewController;
        self.leftViewController = self.centerViewController;
        self.centerViewController = self.rightViewController;
        self.rightViewController = tmpVC;
        
    } else {
         //exchange view controllers index
        tmpVC = self.rightViewController;
        self.rightViewController = self.centerViewController;
        self.centerViewController = self.leftViewController;
        self.leftViewController = tmpVC;
    }
    //update custom scroll view's view controllers
    [self.scrollView setLeftViewController:self.leftViewController];
    [self.scrollView setCenterViewController:self.centerViewController];
    [self.scrollView setRightViewController:self.rightViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
