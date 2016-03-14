//
//  LTImageViewerViewController.h
//  BeatVn
//
//  Created by Le Thang on 8/28/15.
//  Copyright (c) 2015 Le Thang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidDismissBlock)();

@class LTTapGestureRecognizer;

@class LTImageViewerViewController;

@protocol LTImageViewerDelegate <NSObject>

@optional
- (void) imageViewer:(LTImageViewerViewController*)viewer didShowImageAtIndex:(NSInteger)index;

@end

@protocol LTImageViewerDataSources <NSObject>

- (NSInteger) numberOfImageInViewer;

- (NSURL*) imageURLAtIndex:(NSInteger)index;

@optional
- (UIImage*) imageAtIndex:(NSInteger)index;

@optional
- (UIImageView*) fromImageForViewerAtIndex:(NSInteger)index;

@optional
//You can return your custom bar view
//Return nil if you don't use bar view
//Default return LTImageViewerTopBarView
- (UIView*) topBarViewForViewer:(LTImageViewerViewController*)viewer;

@optional
//You can return your custom bar view
//Return nil if you don't use bar view
//Default return LTImageViewerBottomBarView
- (UIView*) bottomBarViewForViewer:(LTImageViewerViewController*)viewer;

@end

@interface LTImageViewerViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) NSObject<LTImageViewerDataSources> *dataSources;

@property (nonatomic, assign) NSObject<LTImageViewerDelegate> *delegate;

@property (nonatomic, weak) IBOutlet UIView *tranparentView;

@property (nonatomic, weak) IBOutlet UIImageView *placeImageView;

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) LTTapGestureRecognizer *fromGesture;

@property (strong, nonatomic) UIImageView *fromImageView;

@property CGRect fromRect;

@property (nonatomic) NSInteger currentImageIndex;

@property (nonatomic) BOOL isShowToolBar;

@property (strong, nonatomic) UIView *topBarView;

@property (strong, nonatomic) UIView *bottomBarView;

@property (nonatomic, copy) DidDismissBlock didDismissBlock;

- (NSInteger) numberOfImageInViewer;

- (IBAction) closeAction:(id)sender;

- (void) animationForShowView;

- (void) animationForCloseView;

#pragma mark - Public method
+ (void) showViewerFromGesture:(LTTapGestureRecognizer*)gesture;

@end
