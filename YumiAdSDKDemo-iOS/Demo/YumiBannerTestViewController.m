//
//  YumiBannerTestViewController.m
//  YumiMediationSDK-iOS_Example
//
//  Created by 王泽永 on 2019/8/26.
//  Copyright © 2019 JiaDingYi. All rights reserved.
//

#import "YumiBannerTestViewController.h"
#import <YumiAdSDK/YumiMediationBannerView.h>

static float const kYumiMargin = 10.0;
static float const kYumiButtonWidth = 200.0;
static float const kYumiButtonHeight = 40.0;
#define kYumiBannerTestScreenWidth [UIScreen mainScreen].bounds.size.width
#define kYumiBannerTestScreenHeight [UIScreen mainScreen].bounds.size.height

@interface YumiBannerTestViewController ()<YumiMediationBannerViewDelegate>
@property (nonatomic) UIButton *dismissButton;
@property (nonatomic) UIButton *showBannerButton;
@property (nonatomic) UIButton *removeBannerButton;
@property (nonatomic) UIScrollView *scrollView;

@property (nonatomic) YumiMediationBannerView *bannerView;

@end

@implementation YumiBannerTestViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenW = kYumiBannerTestScreenWidth;
    self.dismissButton = [[UIButton alloc] initWithFrame:CGRectMake((screenW- kYumiButtonWidth)/2, 50.0, kYumiButtonWidth, kYumiButtonHeight)];
    [self.dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [self.dismissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    self.dismissButton.backgroundColor = [UIColor blackColor];
    self.dismissButton.layer.cornerRadius = 5;
    self.dismissButton.layer.masksToBounds = YES;
    
    self.showBannerButton = [[UIButton alloc] initWithFrame:CGRectMake((screenW-kYumiButtonWidth)/2, kYumiMargin + kYumiButtonHeight + 50.0, kYumiButtonWidth, kYumiButtonHeight)];
    [self.showBannerButton setTitle:@"ShowBanner" forState:UIControlStateNormal];
    [self.showBannerButton addTarget:self action:@selector(showBanner) forControlEvents:UIControlEventTouchUpInside];
    self.showBannerButton.backgroundColor = [UIColor blackColor];
    self.showBannerButton.layer.cornerRadius = 10;
    self.showBannerButton.layer.masksToBounds = YES;
    
    self.removeBannerButton = [[UIButton alloc] initWithFrame:CGRectMake((screenW-kYumiButtonWidth)/2, kYumiMargin*2 + kYumiButtonHeight*2 + 50.0, kYumiButtonWidth, kYumiButtonHeight)];
    [self.removeBannerButton setTitle:@"RemoveBanner" forState:UIControlStateNormal];
    [self.removeBannerButton addTarget:self action:@selector(removeBanner) forControlEvents:UIControlEventTouchUpInside];
    self.removeBannerButton.backgroundColor = [UIColor blackColor];
    self.removeBannerButton.layer.cornerRadius = 5;
    self.removeBannerButton.layer.masksToBounds = YES;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kYumiMargin*3 + kYumiButtonHeight*3 + 50.0, screenW, 300)];
    self.scrollView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.dismissButton];
    [self.view addSubview:self.showBannerButton];
    [self.view addSubview:self.removeBannerButton];
    [self.view addSubview:self.scrollView];
}

- (void)viewDidLayoutSubviews {
    self.scrollView.contentSize = CGSizeMake(kYumiBannerTestScreenWidth, kYumiBannerTestScreenHeight * 2);
}

- (void)dismiss {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self removeBanner];
}

- (void)showBanner {
    self.bannerView = [[YumiMediationBannerView alloc] initWithPlacementID:self.placementID channelID:@"" versionID:@"" position:YumiMediationBannerPositionTop rootViewController:self];
    self.bannerView.delegate = self;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kYumiBannerTestScreenWidth, 80)];
    view.backgroundColor = [UIColor blackColor];
    [view addSubview:self.bannerView];
    [self.scrollView addSubview:view];
    [self.bannerView loadAd:YES];
}

- (void)removeBanner {
    if (self.bannerView) {
        [self.bannerView removeFromSuperview];
        self.bannerView.delegate = nil;
        self.bannerView = nil;
    }
}

#pragma mark - Yumi banner delegate
/// Tells the delegate that an ad has been successfully loaded.
- (void)yumiMediationBannerViewDidLoad:(YumiMediationBannerView *)adView {
    NSLog(@"banner did load in test vc");
}

/// Tells the delegate that a request failed.
- (void)yumiMediationBannerView:(YumiMediationBannerView *)adView didFailWithError:(YumiMediationError *)error {
    NSLog(@"banner did fail to load in test vc");
}

/// Tells the delegate that the banner view has been clicked.
- (void)yumiMediationBannerViewDidClick:(YumiMediationBannerView *)adView {
    NSLog(@"banner did click in test vc");
}

@end
