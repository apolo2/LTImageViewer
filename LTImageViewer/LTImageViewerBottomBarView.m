//
//  ImageViewerBottomBarView.m
//  LTImageViewerExample
//
//  Created by Le Thang on 3/12/16.
//  Copyright © 2016 Le Thang. All rights reserved.
//

#import "LTImageViewerBottomBarView.h"

@interface LTImageViewerBottomBarView ()

@end

@implementation LTImageViewerBottomBarView

- (void) configViewWithViewer:(LTImageViewerViewController*)viewer {
    NSInteger currentIndex = [viewer currentImageIndex];
    NSInteger total = [viewer numberOfImageInViewer];
    
    self.lblImageIndex.text = [NSString stringWithFormat:@"%d / %d", (int)currentIndex + 1, (int)total];
}

@end
