
//
//  PicTableViewCell.m
//  ImageTapScrollView
//
//  Created by 王辉 on 2017/2/28.
//  Copyright © 2017年 王辉. All rights reserved.
//

#import "PicTableViewCell.h"

@implementation PicTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=[UIColor whiteColor];
        [self setSubView];
    }
    return self;
}

- (void)setSubView{
    
    self.picContainerView = [[PicScrollView alloc] initWithFrame:CGRectZero andWidth:55];
    self.picContainerView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.picContainerView];
    
    [self.contentView addSubview:self.picContainerView];
    [self.picContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


- (void)setImageArray:(NSArray *)imageArray{
    self.picContainerView.picPathStringsArray = imageArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
