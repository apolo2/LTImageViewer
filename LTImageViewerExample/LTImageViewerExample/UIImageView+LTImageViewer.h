//
//  UIImageView+LTImageViewer.h
//  BeatVn
//
//  Created by Le Thang on 8/28/15.
//  Copyright (c) 2015 Le Thang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTTapGestureRecognizer.h"

@interface UIImageView (LTImageViewer)

- (void) configWithViewerDataSources:(NSObject<LTImageViewerDataSources>*)viewerDataSources delegate:(NSObject<LTImageViewerDelegate>*)viewerDelegate imageIndex:(NSInteger)imageIndex ;

- (void) removeViewerDelegate;

@end
