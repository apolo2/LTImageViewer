//
//  LTBlankTapGestureRecognizer.h
//  LTBlank
//
//  Created by ThangLN on 4/7/14.
//  Copyright (c) 2014 LT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTImageViewerViewController.h"

@interface LTTapGestureRecognizer : UITapGestureRecognizer

@property NSObject<LTImageViewerDataSources> *viewerDataSources;

@property NSObject<LTImageViewerDelegate> *viewerDelegate;

@property NSInteger imageIndex;

@property (nonatomic, weak) UIImageView *fromImageView;

@end
