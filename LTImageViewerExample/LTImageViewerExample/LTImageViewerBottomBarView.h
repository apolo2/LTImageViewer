//
//  ImageViewerBottomBarView.h
//  LTImageViewerExample
//
//  Created by Le Thang on 3/12/16.
//  Copyright © 2016 Le Thang. All rights reserved.
//

#import "LTBaseUIView.h"
#import "LTImageViewerViewController.h"

@interface LTImageViewerBottomBarView : LTBaseUIView

@property (weak, nonatomic) IBOutlet UILabel *lblImageIndex;

- (void) configViewWithViewer:(LTImageViewerViewController*)viewer;

@end
