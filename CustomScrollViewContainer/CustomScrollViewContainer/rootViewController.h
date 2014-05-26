//
//  rootViewController.h
//  CustomScrollViewContainer
//
//  Created by 小普 on 14-5-26.
//  Copyright (c) 2014年 NjrSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomScrollView.h"

@interface rootViewController : UIViewController <CustomScrollViewDelegate>
@property (nonatomic, strong) CustomScrollView *scrollView;
@end
