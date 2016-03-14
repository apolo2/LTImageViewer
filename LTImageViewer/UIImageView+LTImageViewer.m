//
//  UIImageView+LTImageViewer.m
//  BeatVn
//
//  Created by Le Thang on 8/28/15.
//  Copyright (c) 2015 Le Thang. All rights reserved.
//

#import "UIImageView+LTImageViewer.h"

@implementation UIImageView (LTImageViewer)

- (void) configWithViewerDataSources:(NSObject<LTImageViewerDataSources>*)viewerDataSources delegate:(NSObject<LTImageViewerDelegate>*)viewerDelegate imageIndex:(NSInteger)imageIndex {
    LTTapGestureRecognizer *tapGesture = [[LTTapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureDidTapView:)];
    self.userInteractionEnabled = YES;
    tapGesture.viewerDataSources = viewerDataSources;
    tapGesture.viewerDelegate = viewerDelegate;
    tapGesture.fromImageView = self;
    tapGesture.imageIndex = imageIndex;
    [self addGestureRecognizer:tapGesture];
    tapGesture = nil;
}

- (void) removeViewerDelegate {
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        if ([gesture isKindOfClass:[LTTapGestureRecognizer class]])
            [self removeGestureRecognizer:gesture];
    }
}

- (void) gestureDidTapView:(LTTapGestureRecognizer*)gesture {
    [LTImageViewerViewController showViewerFromGesture:gesture];
}


@end
