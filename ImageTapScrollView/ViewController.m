//
//  ViewController.m
//  ImageTapScrollView
//
//  Created by 王辉 on 2017/2/28.
//  Copyright © 2017年 王辉. All rights reserved.
//

#import "ViewController.h"
#import "PicTableViewCell.h"
#import "Masonry.h"
#import "HexColors.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)getData{
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < 10; i++) {
        [self.dataArray addObject:@"http://images-10040877.image.myqcloud.com/9541c953-ba49-42c5-b75d-8c286364c26f"];
        [self.dataArray addObject:@"http://images-10040877.image.myqcloud.com/6b9b237a-6bed-4696-a9be-eeb0cb976c02"];
        [self.dataArray addObject:@"http://images-10040877.image.myqcloud.com/49f612d7-4e16-46b4-a55a-28f6c22a0f95"];
        [self.dataArray addObject:@"http://images-10040877.image.myqcloud.com/5f30920e-cbaa-4acf-a05c-d14fa82cf38b"];
        [self.dataArray addObject:@"http://images-10040877.image.myqcloud.com/bf52f363-9f87-4973-b67e-5d53b297090c"];
        [self.dataArray addObject:@"http://images-10040877.image.myqcloud.com/941ea6fd-3cc2-413f-a956-6d5d33d28051"];
        
    }
    
    [self.myTableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self getData];
}

- (void)setUI{
    self.title = @"点击查看大图";
    self.myTableView.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"ffffff"];
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.myTableView registerClass:[PicTableViewCell class] forCellReuseIdentifier:@"PicTableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PicTableViewCell"];
    cell.imageArray = self.dataArray;
    return cell;
}

- (UITableView *)myTableView {
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
