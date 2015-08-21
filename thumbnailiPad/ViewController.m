//
//  ViewController.m
//  thumbnailiPad
//
//  Created by Xiaohe Hu on 8/20/15.
//  Copyright (c) 2015 Xiaohe Hu. All rights reserved.
//

//Copyright (C) 2011 by Dominik Kapusta.
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

#import "ViewController.h"
#import "ThumbnailPickerView.h"

@interface ViewController () <ThumbnailPickerViewDataSource, ThumbnailPickerViewDelegate>
{
    UIView          *uiv_thumbContainer;
    NSMutableArray  *arr_images;
    UIImageView     *uiiv_bigImage;
    UILabel         *uil_caption;
}

@property (strong, nonatomic)ThumbnailPickerView *thumbnailPickerView;

@end

@implementation ViewController

@synthesize thumbnailPickerView = _thumbnailPickerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self prepareData];
    [self createThumb];
    [self createBigImage];
    [self createCaptionLabel];
}

- (void)prepareData {
    
    arr_images = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 28 ; i++) {
        NSString *fileName = [NSString stringWithFormat:@"image0%02d.jpg", i+1];
        [arr_images addObject: fileName];
    }
    
    NSLog(@"The files name is %@", arr_images);
}

- (void)createThumb {
    uiv_thumbContainer = [UIView new];
    CGFloat height = 100;
    uiv_thumbContainer.frame = CGRectMake(0.0, self.view.bounds.size.height - height, self.view.bounds.size.width, height);
    uiv_thumbContainer.backgroundColor = [UIColor redColor];
    [self.view addSubview: uiv_thumbContainer];
    
    self.thumbnailPickerView = [[ThumbnailPickerView alloc] initWithFrame:uiv_thumbContainer.bounds];
    self.thumbnailPickerView.backgroundColor = [UIColor greenColor];
    self.thumbnailPickerView.dataSource = self;
    self.thumbnailPickerView.delegate = self;
    [uiv_thumbContainer addSubview: self.thumbnailPickerView];
}

- (void)createBigImage {
    uiiv_bigImage = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 824, 500)];
    uiiv_bigImage.backgroundColor = [UIColor redColor];
    uiiv_bigImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview: uiiv_bigImage];
}

- (void)createCaptionLabel {
    uil_caption = [[UILabel alloc] initWithFrame:CGRectMake(352, 610, 300, 50)];
    uil_caption.backgroundColor = [UIColor grayColor];
    [uil_caption setTextColor:[UIColor whiteColor]];
    [uil_caption setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:uil_caption];
}

#pragma mark - ThumbnailPicker Datasource and delegate
- (void)thumbnailPickerView:(ThumbnailPickerView *)thumbnailPickerView didSelectImageWithIndex:(NSUInteger)index {
    uiiv_bigImage.image = [UIImage imageNamed:arr_images[index]];
    [uil_caption setText: arr_images[index]];
}
- (NSUInteger)numberOfImagesForThumbnailPickerView:(ThumbnailPickerView *)thumbnailPickerView {
    return arr_images.count;
}
- (UIImage *)thumbnailPickerView:(ThumbnailPickerView *)thumbnailPickerView imageAtIndex:(NSUInteger)index {
    return [UIImage imageNamed:arr_images[index]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
