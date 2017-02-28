//
//  PicScrollView.m
//  IXQ
//
//  Created by 王辉 on 2017/2/27.
//  Copyright © 2017年 北京三芳科技有限公司. All rights reserved.
//

#import "PicScrollView.h"
#import "UIView+SDAutoLayout.h"

#import "SDPhotoBrowser.h"
#import "UIImageView+WebCache.h"

@interface PicScrollView () <SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *imageViewsArray;

@end

@implementation PicScrollView

- (instancetype)initWithFrame:(CGRect)frame andWidth:(float)itemW
{
    if (self = [super initWithFrame:frame]) {
        _itemW = itemW;
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self addSubview:self.imageScroll];
    [self.imageScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 100; i++) {
        UIImageView *imageView = [UIImageView new];
        [self.imageScroll addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewsArray = [temp copy];
}

- (void)setPicPathStringsArray:(NSArray *)picPathStringsArray
{

    _picPathStringsArray = picPathStringsArray;
    
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_picPathStringsArray.count == 0) {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    CGFloat itemH = self.itemW;
    long perRowItemCount = _picPathStringsArray.count;
    CGFloat margin = 5;

    [_picPathStringsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < _imageViewsArray.count) {
            long columnIndex = idx % perRowItemCount;
            long rowIndex = idx / perRowItemCount;
            UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
            imageView.hidden = NO;
            [imageView sd_setImageWithURL:[NSURL URLWithString:obj]];
            imageView.frame = CGRectMake(10+columnIndex * (self.itemW + margin),5+ rowIndex * (itemH + margin), self.itemW, itemH);
        }
    }];

    CGFloat w = perRowItemCount * self.itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    self.width = w;
    self.height = h;
    self.imageScroll.contentSize = CGSizeMake(10+w+10, h+margin);

    self.fixedHeight = @(h);
    self.fixedWidth = @(w);
    
}

#pragma mark - private actions

- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self.imageScroll;//把imageScroll的子view，传过去
    browser.imageCount = self.picPathStringsArray.count;
    browser.delegate = self;
    [browser show];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ResignFirstResponder" object:@"ResignFirstResponder" userInfo:nil];
}


- (UIScrollView *)imageScroll{
    if (_imageScroll == nil) {
        _imageScroll = [UIScrollView new];
        _imageScroll.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
        _imageScroll.showsHorizontalScrollIndicator = NO;
        _imageScroll.userInteractionEnabled = YES;
    }
    return _imageScroll;
}


#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.picPathStringsArray[index];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.imageScroll.subviews[index];
    return imageView.image;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
