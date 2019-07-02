//
//  AppDelegate.h
//  YumiAdSDKDemo-iOS
//
//  Created by Michael Tang on 2019/7/2.
//  Copyright © 2019 MichaelTang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

