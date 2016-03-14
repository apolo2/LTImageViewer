//
//  LTImageViewerViewController.m
//  BeatVn
//
//  Created by Le Thang on 8/28/15.
//  Copyright (c) 2015 Le Thang. All rights reserved.
//

#import "LTImageViewerViewController.h"
#import "LTImageViewerCollectionViewCell.h"
#import "LTTapGestureRecognizer.h"
#import "LTImageViewerTopBarView.h"
#import "LTImageViewerBottomBarView.h"

@interface LTImageViewerViewController () <UIScrollViewDelegate>
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@end

@implementation LTImageViewerViewController

- (id) initFromGesture:(LTTapGestureRecognizer*)gesture {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.fromGesture = gesture;
        self.currentImageIndex = gesture.imageIndex;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSources = self.fromGesture.viewerDataSources;
    self.delegate = self.fromGesture.viewerDelegate;
    
    [self setupBarViews];
    
    [self setupCollectionView];
    [self setupCollectionItem];
    
    [self addViewPanGesture];
    [self addViewTapGesture];
}

- (void) setupCollectionView {
    self.collectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.collectionView registerNib:[LTImageViewerCollectionViewCell nib] forCellWithReuseIdentifier:[LTImageViewerCollectionViewCell nibName]];
}

#pragma mark - Tool bar view
- (void) setupDefaultTopBarView {
    LTImageViewerTopBarView *topView = [LTImageViewerTopBarView initViewUsingNib];
    [topView configViewWithViewer:self];
    self.topBarView = topView;
    self.topBarView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.topBarView.frame.size.height);
    [self.view addSubview:self.topBarView];
    
    self.topBarView.alpha = 0;
}

- (void) setupDefaultBottomBarView {
    LTImageViewerBottomBarView *bottomView = [LTImageViewerBottomBarView initViewUsingNib];
    [bottomView configViewWithViewer:self];
    self.bottomBarView = bottomView;
    self.bottomBarView.frame = CGRectMake(0, self.view.frame.size.height - self.bottomBarView.frame.size.height, self.view.frame.size.width, self.bottomBarView.frame.size.height);
    [self.view addSubview:self.bottomBarView];
    
    self.bottomBarView.alpha = 0;
}

- (void) setupBarViews {
    if (self.dataSources && [self.dataSources respondsToSelector:@selector(topBarViewForViewer:)]) {
        //Use user custom top bar view
        self.topBarView = [self.dataSources topBarViewForViewer:self];
        self.topBarView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.topBarView.frame.size.height);
        [self.view addSubview:self.topBarView];
        
        self.topBarView.alpha = 0;
    } else {
        //Using default top bar view
        [self setupDefaultTopBarView];
    }
    
    if (self.dataSources && [self.dataSources respondsToSelector:@selector(bottomBarViewForViewer:)]) {
        //Use user custom bottom bar view
        self.bottomBarView = [self.dataSources bottomBarViewForViewer:self];
        self.bottomBarView.frame = CGRectMake(0, self.view.frame.size.height - self.bottomBarView.frame.size.height, self.view.frame.size.width, self.bottomBarView.frame.size.height);
        [self.view addSubview:self.bottomBarView];
        
        self.bottomBarView.alpha = 0;
    } else {
        //Using default bottom bar view
        [self setupDefaultBottomBarView];
    }
    
    self.isShowToolBar = NO;
}

- (void) hideToolBarView {
    self.isShowToolBar = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.topBarView.alpha = 0;
        self.bottomBarView.alpha = 0;
    }];
}

- (void) showToolBarView {
    self.isShowToolBar = YES;
    [UIView animateWithDuration:0.25 animations:^{
        self.topBarView.alpha = 1;
        self.bottomBarView.alpha = 1;
    }];
}

#pragma mark - Gestures
- (void) addViewTapGesture {
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureView:)];
    [self.tapGesture setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:self.tapGesture];
}

- (void) handleTapGestureView:(UITapGestureRecognizer*)gesture {
    if (self.isShowToolBar)
        [self hideToolBarView];
    else
        [self showToolBarView];
}

- (void) addViewPanGesture {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureView:)];
    [self.view addGestureRecognizer:panGesture];
}

- (void) handlePanGestureView:(UIPanGestureRecognizer*)panGesture_ {
    static CGPoint firstCenter;
    CGPoint translatedPoint = [panGesture_ translationInView:self.view];
    if (panGesture_.state == UIGestureRecognizerStateBegan) {
        firstCenter = self.collectionView.center;
    }
    
    [self hideToolBarView];
    
    translatedPoint = CGPointMake(firstCenter.x, firstCenter.y + translatedPoint.y);
    [self.collectionView setCenter:translatedPoint];
    [self.placeImageView setCenter:translatedPoint];
    
    self.tranparentView.alpha = 1.0 - 2*ABS(translatedPoint.y - self.view.center.y) / self.view.frame.size.height;
    
    if (panGesture_.state == UIGestureRecognizerStateEnded) {
        // dismiss view
        if (ABS(self.collectionView.center.x - firstCenter.x) > 50 ||
            ABS(self.collectionView.center.y - firstCenter.y) > 50)
            [self animationForCloseView];
        else {
            // Continue Showing View
            CGFloat velocityY = (.35*[panGesture_ velocityInView:self.view].y);
            CGFloat animationDuration = (ABS(velocityY)*.0002)+.2;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:animationDuration];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [UIView setAnimationDelegate:self];
            [self.collectionView setCenter:firstCenter];
            self.placeImageView.center = firstCenter;
            self.tranparentView.alpha = 1.0;
            [UIView commitAnimations];
            
            [self showToolBarView];
        }
    }
}

#pragma mark - Collection View Delegate + DataScoure
- (void) setupCollectionItem {
    UICollectionViewFlowLayout *layout = (id)self.collectionView.collectionViewLayout;
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.collectionView reloadData];
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.fromGesture.imageIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (NSInteger) numberOfImageInViewer {
    if (self.dataSources && [self.dataSources respondsToSelector:@selector(numberOfImageInViewer)]) {
        return [self.dataSources numberOfImageInViewer];
    }
    
    return 0;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self numberOfImageInViewer];
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView_ cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [LTImageViewerCollectionViewCell nibName];
    LTImageViewerCollectionViewCell *cell = [collectionView_ dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    //Config cell
    if (self.dataSources && [self.dataSources respondsToSelector:@selector(imageURLAtIndex:)]) {
        NSURL *imageURL = [self.dataSources imageURLAtIndex:indexPath.row];
        [cell configWithImageURL:imageURL];
    } else if (self.dataSources && [self.dataSources respondsToSelector:@selector(imageAtIndex:)]) {
        UIImage *image = [self.dataSources imageAtIndex:indexPath.row];
        [cell configWithImage:image];
    } else if (self.dataSources && [self.dataSources respondsToSelector:@selector(fromImageForViewerAtIndex:)]) {
        UIImageView *fromImage = [self.dataSources fromImageForViewerAtIndex:indexPath.row];
        UIImage *image = [[fromImage image] copy];
        [cell configWithImage:image];
    }
    
    //Disible viewer tap gesture when cell double tap to zoom
    [self.tapGesture requireGestureRecognizerToFail:cell.doubleTapGesture];
    
    return cell;
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //Handle delegate
    UICollectionViewCell *cell = [[self.collectionView visibleCells] firstObject];
    if (!cell)
        return;
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    self.currentImageIndex = indexPath.row;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewer:didShowImageAtIndex:)]) {
        [self.delegate imageViewer:self didShowImageAtIndex:indexPath.row];
    }
    
    if (self.bottomBarView && [self.bottomBarView isKindOfClass:[LTImageViewerBottomBarView class]]) {
        [(LTImageViewerBottomBarView*)self.bottomBarView configViewWithViewer:self];
    }
    
    //Reset from ImageView
    if (indexPath && self.dataSources && [self.dataSources respondsToSelector:@selector(fromImageForViewerAtIndex:)]) {
        self.fromImageView.hidden = NO;
        self.fromImageView = [self.dataSources fromImageForViewerAtIndex:indexPath.row];
        self.fromRect = [self.fromImageView convertRect:self.fromImageView.bounds toView:nil];
        self.fromImageView.hidden = YES;
        [self.placeImageView setImage:self.fromImageView.image];
        self.placeImageView.contentMode = self.fromImageView.contentMode;
        self.placeImageView.frame = [self getPlaceImageFrameOnView];
    }
}

#pragma mark - Close Action
- (IBAction) closeAction:(id)sender {
    [self animationForCloseView];
}

#pragma mark - Animations
- (CGRect) getPlaceImageFrameOnView {
    CGRect imageFrame = self.placeImageView.frame;
    UIImage *image = self.placeImageView.image;
    if (image) {
        CGSize maxSize = self.view.superview.frame.size;
        float width = maxSize.width;
        float height = image.size.height * width / image.size.width;
        if (height > maxSize.height) {
            height = maxSize.height;
            width = height * image.size.width / image.size.height;
        }
        
        imageFrame = CGRectMake((maxSize.width - width)/2, (maxSize.height - height)/2, width, height);
    }
    return imageFrame;
}

- (void) animationForShowView {
    self.fromImageView = self.fromGesture.fromImageView;
    self.fromImageView.hidden = YES;
    
    self.fromRect = [self.fromImageView convertRect:self.fromImageView.bounds toView:nil];
    self.placeImageView.image = self.fromImageView.image;
    self.placeImageView.contentMode = self.fromImageView.contentMode;
    self.placeImageView.frame = self.fromRect;
    self.collectionView.hidden = YES;
    
    CGRect imageFrame = [self getPlaceImageFrameOnView];
    self.tranparentView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self.tranparentView.alpha = 1;
        self.placeImageView.frame = imageFrame;
    } completion:^(BOOL finished) {
        self.placeImageView.hidden = YES;
        self.collectionView.hidden = NO;
        [self showToolBarView];
    }];
}

- (void) animationForCloseView {
    if (self.didDismissBlock)
        self.didDismissBlock();
    
    [self hideToolBarView];
    
    self.placeImageView.hidden = NO;
    self.collectionView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.tranparentView.alpha = 0;
        self.placeImageView.frame = self.fromRect;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        self.fromImageView.hidden = NO;
    }];
}

#pragma mark - Public method
+ (void) showViewerFromGesture:(LTTapGestureRecognizer*)gesture {
    LTImageViewerViewController *imageViewer = [[LTImageViewerViewController alloc] initFromGesture:gesture];
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
    UIViewController *rootViewController = window.rootViewController;
    [rootViewController addChildViewController:imageViewer];
    imageViewer.view.frame = CGRectMake(0, 0, rootViewController.view.frame.size.width, rootViewController.view.frame.size.height);
    [rootViewController.view addSubview:imageViewer.view];
    [imageViewer didMoveToParentViewController:rootViewController];
    [imageViewer animationForShowView];
}

@end
