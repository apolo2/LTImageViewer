//
//  ImageViewerTopBarView.m
//  LTImageViewerExample
//
//  Created by Le Thang on 3/12/16.
//  Copyright © 2016 Le Thang. All rights reserved.
//

#import "LTImageViewerTopBarView.h"

@interface LTImageViewerTopBarView ()

@end

@implementation LTImageViewerTopBarView

- (void) configViewWithViewer:(LTImageViewerViewController*)viewer {
    [self.btnDone addTarget:viewer action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
}

@end
