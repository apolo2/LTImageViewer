# LTImageViewer

![](https://github.com/apolo2/LTImageViewer/blob/master/LTImageViewer.gif)

## Requirements
iOS 6.0

## Installation

####[CocoaPods](http://cocoapods.org)
Coming soon.

####Manual Installation

Unzip example project and add files in LTImageViewer forder to your project

Add [SDWebImage](https://github.com/rs/SDWebImage) framework to your project

## Usage

* Import class:
    - '#import "LTImageViewerViewController.h"'
    - '#import "UIImageView+LTImageViewer.h"'

* Config your UIImageView with LTImageViewer:
    [youImageView configWithViewerDataSources:dataSources delegate:delegate imageIndex:index];

* Implement LTImageViewer DataSoucres in your controller:
    //Number of image in LTImageViewer
    - (NSInteger) numberOfImageInViewer 
    {
        return [number of image in your controller];
    }
    
    //If you use web url for display image
    - (NSURL*) imageURLAtIndex:(NSInteger)index 
    {
        return [Web URL of image at index];
    }

    //Else use normal image
    - (UIImage*) imageAtIndex:(NSInteger)index 
    {
        return [your image at index];
    }
    
    //Top bar view and bottom bar view
    - (UIView*) topBarViewForViewer:(LTImageViewerViewController *)viewer 
    {
        //You can return your custom bar view
        //Return nil if you don't use bar view
        //Default return LTImageViewerBottomBarView

        return nil;
    }

    - (UIView*) bottomBarViewForViewer:(LTImageViewerViewController *)viewer 
    {
        //You can return your custom bar view
        //Return nil if you don't use bar view
        //Default return LTImageViewerBottomBarView

        return nil;
    }

* Handle LTImageViewerDelegate for change:
    - (void) imageViewer:(LTImageViewerViewController *)viewer didShowImageAtIndex:(NSInteger)index 
    {
        //Your change code
    }

### Note

In this examle, SDWebImage was used to display image from an url. You can modify it by yourself using your own image cache manager such as AFNetworking...

### Author

ThangLN, lethang255@gmail.com

Feel free to copy and modify this source code. Please let me know if you have any question!