//
//  HomeCollectionViewCell.h
//  LTImageViewerExample
//
//  Created by Le Thang on 3/11/16.
//  Copyright © 2016 Le Thang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;

+ (UINib*) nib;
+ (NSString*) nibName;

- (void) configCellWithImageURL:(NSString*)imageURL;

@end
