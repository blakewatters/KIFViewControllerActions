//
//  KIFSystemTestAction+ViewControllerActions.m
//  KIFViewControllerActions
//
//  Created by Blake Watters on 10/31/2013.
//  Copyright (c) 2013 Blake Watters. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "KIFSystemTestActor+ViewControllerActions.h"

@implementation KIFSystemTestActor (ViewControllerActions)

static void *KIFDefaultNavigationBarClassAssociatedObjectKey = &KIFDefaultNavigationBarClassAssociatedObjectKey;
static void *KIFDefaultToolbarClassAssociatedObjectKey = &KIFDefaultToolbarClassAssociatedObjectKey;

static Class defaultNavigationBarClass;
static Class defaultToolbarClass;

- (Class)defaultNavigationBarClass
{
    return defaultNavigationBarClass;
}

- (void)setDefaultNavigationBarClass:(Class)newDefaultNavigationBarClass
{
    defaultNavigationBarClass = newDefaultNavigationBarClass;
}

- (Class)defaultToolbarClass
{
    return defaultToolbarClass;
}

- (void)setDefaultToolbarClass:(Class)newDefaultToolbarClass
{
    defaultToolbarClass = newDefaultToolbarClass;
}

- (void)presentViewControllerWithClass:(Class)viewControllerClass withinNavigationControllerWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
                    configurationBlock:(void (^)(id viewController))configurationBlock;
{
    [self runBlock:^KIFTestStepResult(NSError **error) {
        UIViewController *viewControllerToPresent = [viewControllerClass new];
        KIFTestCondition(viewControllerToPresent != nil, error, @"Expected a view controller, but got nil");

        Class navigationBarClassToUse = navigationBarClass ?: self.defaultNavigationBarClass;
        Class toolbarClassToUse = toolbarClass ?: self.defaultToolbarClass;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:navigationBarClassToUse toolbarClass:toolbarClassToUse];
        navigationController.viewControllers = @[viewControllerToPresent];
        if (configurationBlock) configurationBlock(viewControllerToPresent);
        [UIApplication sharedApplication].keyWindow.rootViewController = navigationController;

        return KIFTestStepResultSuccess;
    }];
}

- (void)presentViewControllerWithIdentifier:(NSString *)controllerIdentifier fromStoryboardWithName:(NSString *)storyboardName configurationBlock:(void (^)(UIViewController *viewController))configurationBlock
{
    [self runBlock:^KIFTestStepResult(NSError *__autoreleasing *error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];

        UIViewController *storyboardViewController = [storyboard instantiateViewControllerWithIdentifier:controllerIdentifier];
        if (configurationBlock) configurationBlock(storyboardViewController);
        KIFTestCondition(storyboardViewController != nil, error, @"Expected a view controller, but got nil");

        UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:self.defaultNavigationBarClass toolbarClass:self.defaultToolbarClass];
        navigationController.viewControllers = @[ storyboardViewController ];
        [UIApplication sharedApplication].keyWindow.rootViewController = navigationController;

        return KIFTestStepResultSuccess;
    }];
}

- (void)presentModalViewControllerWithIdentifier:(NSString *)controllerIdentifier fromStoryboardWithName:(NSString *)storyboardName configurationBlock:(void (^)(UIViewController *viewController))configurationBlock
{
    [self runBlock:^KIFTestStepResult(NSError *__autoreleasing *error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];

        UIViewController *storyboardViewController = [storyboard instantiateViewControllerWithIdentifier:controllerIdentifier];
        if (configurationBlock) configurationBlock(storyboardViewController);
        KIFTestCondition(storyboardViewController != nil, error, @"Expected a view controller, but got nil");

        UIViewController *viewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:self.defaultNavigationBarClass toolbarClass:self.defaultToolbarClass];
        navigationController.viewControllers = @[ viewController ];
        [UIApplication sharedApplication].keyWindow.rootViewController = navigationController;

        return KIFTestStepResultSuccess;
    }];
}

- (void)presentModalViewController:(UINavigationController *)navigationController configurationBlock:(void (^)(UINavigationController *navigationController))configurationBlock
{
    [self runBlock:^KIFTestStepResult(NSError **error) {
        UINavigationController *navigationControllerToPresent = navigationController;
        KIFTestCondition(navigationControllerToPresent != nil, error, @"Expected a navigationController, but got nil");
        
        if (configurationBlock) configurationBlock(navigationControllerToPresent);
        [[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController presentViewController:navigationControllerToPresent animated:true completion:nil];
        
        return KIFTestStepResultSuccess;
    }];
}

@end
