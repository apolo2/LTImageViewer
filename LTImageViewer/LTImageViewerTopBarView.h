//
//  ImageViewerTopBarView.h
//  LTImageViewerExample
//
//  Created by Le Thang on 3/12/16.
//  Copyright © 2016 Le Thang. All rights reserved.
//

#import "LTBaseUIView.h"
#import "LTImageViewerViewController.h"

@interface LTImageViewerTopBarView : LTBaseUIView

@property (nonatomic, weak) IBOutlet UIButton *btnDone;

- (void) configViewWithViewer:(LTImageViewerViewController*)viewer;

@end
