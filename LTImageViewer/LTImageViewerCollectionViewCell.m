//
//  LTBlankImageViewerCollectionCell.m
//  Wallpaper18
//
//  Created by Le Thang on 3/13/15.
//  Copyright (c) 2015 LT. All rights reserved.
//

#import "LTImageViewerCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation LTImageViewerCollectionViewCell

+ (UINib*) nib {
    return [UINib nibWithNibName:[self nibName] bundle:[NSBundle mainBundle]];
}

+ (NSString*) nibName {
    return NSStringFromClass([self class]);
}

- (void) awakeFromNib {
    [super awakeFromNib];
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 4.0;
    
    self.doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDidDoubleTapGesture:)];
    [self.doubleTapGesture setNumberOfTapsRequired:2];
    [self.scrollView addGestureRecognizer:self.doubleTapGesture];
}

- (void) configWithImageURL:(NSURL*)imageURL {
    self.scrollView.zoomScale = 1.0;
    
    [self.imgPhoto setImageWithURL:imageURL placeholderImage:nil];
}

- (void) configWithImage:(UIImage*)image {
    self.scrollView.zoomScale = 1.0;
    
    [self.imgPhoto setImage:image];
}

- (void) zoomToScale:(CGFloat)zoomScale center:(CGPoint)center {
    CGRect zoomRect;
    zoomRect.size.height = self.scrollView.frame.size.height / zoomScale;
    zoomRect.size.width  = self.scrollView.frame.size.width  / zoomScale;
    
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    [self.scrollView zoomToRect:zoomRect animated:YES];
}

- (void) scrollViewDidDoubleTapGesture:(UITapGestureRecognizer*)gesture {
    CGPoint center = [gesture locationInView:self.imgPhoto];
    
    if (self.scrollView.zoomScale < 2.0) {
        [self zoomToScale:2.0 center:center];
    } else if (self.scrollView.zoomScale < 4.0) {
        [self zoomToScale:self.scrollView.maximumZoomScale center:center];
    } else {
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    }
}

- (UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imgPhoto;
}

@end
