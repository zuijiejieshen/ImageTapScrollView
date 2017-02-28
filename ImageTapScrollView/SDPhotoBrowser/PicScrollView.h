//
//  PicScrollView.h
//  IXQ
//
//  Created by 王辉 on 2017/2/27.
//  Copyright © 2017年 北京三芳科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicScrollView : UIView

@property (nonatomic, strong) NSArray *picPathStringsArray;
@property (nonatomic, strong) UIScrollView *imageScroll;
@property (nonatomic, assign) float itemW;
//itemW图片宽度
- (instancetype)initWithFrame:(CGRect)frame andWidth:(float)itemW;

@end
