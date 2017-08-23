//
//  ViewController.m
//  UI基础-图片浏览器
//
//  Created by libbbb on 2017/7/10.
//  Copyright © 2017年 libbbb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *preBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation ViewController{
    NSArray *_images;
    NSInteger _currentIndex;
}

//前一页事件
- (IBAction)preClick:(id)sender {
    _currentIndex--;
    [self setupUI];
}

//后一页事件
- (IBAction)nextClick:(id)sender {
    _currentIndex++;
    [self setupUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载数据
    _images = [self loadImages];
    
    _currentIndex = 0;
    
    [self setupUI];
    
}

- (void)setupUI {
    
    //禁用按钮
    self.preBtn.enabled = _currentIndex;
    self.nextBtn.enabled = _images.count - 1 - _currentIndex;
    
    //获取第一个元素内容
    NSDictionary *dict = _images[_currentIndex];
    
    //修改count下标
    self.countLabel.text = [NSString stringWithFormat:@"%zd / %zd",_currentIndex + 1,_images.count];
    
    //创建装图片的数组
    NSMutableArray *array = [NSMutableArray array];
    
    //设置序列帧动画
    for (int i = 0; i < [dict[@"count"] integerValue]; i++) {
        //拼接图片名字
        NSString *imageName = [NSString stringWithFormat:@"%@%03d",dict[@"icon"], i + 1];
        
        //图片添加到数组
        [array addObject:[UIImage imageNamed:imageName]];
    }
    
    //获取带序列帧动画的image
    UIImage *image = [UIImage animatedImageWithImages:array duration:2];
    
    //展现在imageView上
    self.imageView.image = image;
    
    //设置描述信息
    self.descLabel.text = dict[@"desc"];
    
}

//加载plist
- (NSArray *)loadImages {
    //1.加载本地数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"images" ofType:@"plist"];
    NSArray *images = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"%@",images);
    
    return images;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
