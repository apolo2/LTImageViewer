//
//  LTBlankImageViewerCollectionCell.h
//  Wallpaper18
//
//  Created by Le Thang on 3/13/15.
//  Copyright (c) 2015 LT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTImageViewerCollectionViewCell : UICollectionViewCell<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;

@property (nonatomic) UITapGestureRecognizer *doubleTapGesture;

+ (UINib*) nib;
+ (NSString*) nibName;

- (void) configWithImageURL:(NSURL*)imageURL;
- (void) configWithImage:(UIImage*)image;

@end
