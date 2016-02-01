//
//  ViewController.m
//  ScrollTest
//
//  Created by acewu on 16/2/1.
//  Copyright © 2016年 justlike. All rights reserved.
//

#import "ViewController.h"

#import "Masonry.h"

@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic) UIScrollView *scrollView;

@property (nonatomic) UIButton *uploadBtn;
@property (nonatomic) UIButton *submitBtn;

@property (nonatomic) UIImageView *tips;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self addViews];
}
- (void)viewDidAppear:(BOOL)animated {
	[self updateXOffset:0];
}

- (void)addViews {
	CGFloat pages = 2;
	
	self.scrollView = [UIScrollView new];
	[self.view addSubview:self.scrollView];
	self.scrollView.backgroundColor= [UIColor brownColor];
	self.scrollView.delegate = self;
	[self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
	
	[self.scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width * pages, [UIScreen mainScreen].bounds.size.height)];
	self.scrollView.pagingEnabled = YES;
	
	self.uploadBtn = [UIButton new];
	[self.view addSubview:self.uploadBtn];
	self.uploadBtn.backgroundColor = [UIColor grayColor];
	[self.uploadBtn setTitle:@"Upload" forState:UIControlStateNormal];
	// uploadBtn
	[self.uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.view).offset(50);
		make.right.equalTo(self.view).offset(-20);
		make.width.equalTo(@60);
		make.height.equalTo(@30);
	}];
	
	
	self.submitBtn = [UIButton new];
	[self.view addSubview:self.submitBtn];
	self.submitBtn.backgroundColor = [UIColor grayColor];
	[self.submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
	// submit
	[self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.equalTo(self.view);
		make.bottom.equalTo(self.view).offset(-50);
		make.width.equalTo(@80);
		make.height.equalTo(@40);
	}];

	
	self.tips = [UIImageView new];
	self.tips.backgroundColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.2 alpha:0.4];
	[self.view addSubview:self.tips];
	[self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.height.equalTo(@80);
	}];
	self.tips.layer.cornerRadius = 80/2;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	CGPoint offSet = scrollView.contentOffset;
	NSLog(@"Offset:%f", offSet.x);
	[self updateXOffset:offSet.x];
	
}
- (void)updateXOffset:(CGFloat)xOffset {
	CGFloat va = xOffset / [UIScreen mainScreen].bounds.size.width;
	
	CGPoint tipsCenter = CGPointMake(self.uploadBtn.center.x + (self.submitBtn.center.x - self.uploadBtn.center.x)*va,
									 self.uploadBtn.center.y + (self.submitBtn.center.y - self.uploadBtn.center.y)*va);
	self.tips.center = tipsCenter;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
