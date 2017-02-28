//
//  PicTableViewCell.h
//  ImageTapScrollView
//
//  Created by 王辉 on 2017/2/28.
//  Copyright © 2017年 王辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PicScrollView.h"

@interface PicTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) PicScrollView *picContainerView; //所有图片部分


@end
