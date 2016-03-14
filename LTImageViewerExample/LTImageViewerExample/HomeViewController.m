//
//  HomeViewController.m
//  LTImageViewerExample
//
//  Created by Le Thang on 3/11/16.
//  Copyright © 2016 Le Thang. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
#import "LTImageViewerViewController.h"
#import "UIImageView+LTImageViewer.h"
#import "LTTapGestureRecognizer.h"
#import "LTImageViewerTopBarView.h"
#import "LTImageViewerBottomBarView.h"

@interface HomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, LTImageViewerDataSources, LTImageViewerDelegate>

@property (strong, nonatomic) NSArray *listImageURLs;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Home";
    
    [self setupNavigationBar];
    
    [self setupCollectionView];
    
    [self reloadItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupNavigationBar {
    if (self.navigationController) {
        UINavigationBar *navBar = [self.navigationController navigationBar];
        [navBar setBarTintColor:[UIColor darkGrayColor]];
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    }
}

- (void) reloadItems {
    self.listImageURLs = @[@"https://www.mylinea.com/wp-content/uploads/natural-beauty-wallpaper.jpg",
                           @"https://artdoxa-images.s3.amazonaws.com/uploads/artwork/image/123468/watermark_Your_Natural_Beauty_wallpaper.jpg",
                           @"https://s-media-cache-ak0.pinimg.com/736x/60/b7/01/60b7019827cf8f7affd921f02793adf0.jpg",
                           @"http://www.keenthemes.com/preview/conquer/assets/plugins/jcrop/demos/demo_files/image1.jpg",
                           @"http://www.joomlaworks.net/images/demos/galleries/abstract/7.jpg",
                           @"http://www.pnas.org/site/misc/images/15-04709.500.jpg",
                           @"http://www.gettyimages.com/gi-resources/images/ImageCollections/image2_157111078.jpg",
                           @"http://angeoudemongif.a.n.pic.centerblog.net/d3e42620.gif",
                           @"https://codepo8.github.io/canvas-images-and-pixels/img/horse.png",
                           @"http://i.telegraph.co.uk/multimedia/archive/03224/Wellcome-Pregnant-_3224786k.jpg",
                           @"http://static.guim.co.uk/sys-images/Guardian/Pix/pictures/2014/4/11/1397210130748/Spring-Lamb.-Image-shot-2-011.jpg",
                           @"http://www.pnas.org/site/misc/images/15-01065.500.jpg",
                           @"https://stepupandlive.files.wordpress.com/2014/09/3d-animated-frog-image.jpg",
                           @"http://a5.mzstatic.com/us/r30/Purple5/v4/5a/2e/e9/5a2ee9b3-8f0e-4f8b-4043-dd3e3ea29766/icon128-2x.png",
                           @"http://www.gettyimages.com/gi-resources/images/ImageCollections/image5_170127819.jpg",
                           @"http://www.nasa.gov/sites/default/files/styles/image_card_4x3_ratio/public/thumbnails/image/pia20285-1041.jpg?itok=UQWFb9Vp"];
    
    [self.collectionView reloadData];
}

#pragma mark - CollectionView
- (void) setupCollectionView {
    UICollectionViewFlowLayout *layout = (id)self.collectionView.collectionViewLayout;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    layout.itemSize = CGSizeMake(screenSize.width / 3, screenSize.height / 4);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[HomeCollectionViewCell nib] forCellWithReuseIdentifier:[HomeCollectionViewCell nibName]];
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listImageURLs.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView_ cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell = (HomeCollectionViewCell*)[collectionView_ dequeueReusableCellWithReuseIdentifier:[HomeCollectionViewCell nibName] forIndexPath:indexPath];
    NSString *imageURL = [self.listImageURLs objectAtIndex:indexPath.row];
    
    //Config cell image URL
    [cell configCellWithImageURL:imageURL];
    
    //Config cell for ImageViewer
    [[cell imgPhoto] configWithViewerDataSources:self delegate:self imageIndex:indexPath.row];

    return cell;
}

#pragma mark - LTImageViewer
- (NSInteger) numberOfImageInViewer {
    return self.listImageURLs.count;
}

- (NSURL*) imageURLAtIndex:(NSInteger)index {
    return [NSURL URLWithString:[self.listImageURLs objectAtIndex:index]];
}

//Return normal UIImage if you don't use UIImage from URL
//- (UIImage*) imageAtIndex:(NSInteger)index {
//    HomeCollectionViewCell *cell = (HomeCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//    UIImage *image = [[cell imgPhoto].image copy];
//    return image;
//}

- (UIImageView*) fromImageForViewerAtIndex:(NSInteger)index {
    HomeCollectionViewCell *cell = (HomeCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    return [cell imgPhoto];
}

//- (UIView*) topBarViewForViewer:(LTImageViewerViewController *)viewer {
//    //You can return your custom bar view
//    //Return nil if you don't use bar view
//    //Default return LTImageViewerBottomBarView
//
//    return nil;
//}

//- (UIView*) bottomBarViewForViewer:(LTImageViewerViewController *)viewer {
//    //You can return your custom bar view
//    //Return nil if you don't use bar view
//    //Default return LTImageViewerBottomBarView
//    
//    return nil;
//}

- (void) imageViewer:(LTImageViewerViewController *)viewer didShowImageAtIndex:(NSInteger)index {
    //Reload your bar view
    //Example:
    //LTImageViewerBottomBarView *bottomView = (LTImageViewerBottomBarView*)[viewer bottomBarView];
    //[bottomView configViewWithViewer:viewer];
    
    //Scroll To Item
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
}

@end
