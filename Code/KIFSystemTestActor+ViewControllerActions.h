//
//  KIFSystemTestAction+ViewControllerActions.h
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

#import <KIF/KIFSystemTestActor.h>

/**
 The `ViewControllerActions` category provides system level actions for triggering the instantation and presentation of `UIViewController` objects from code or loaded from Storyboards. These actions support the use of KIF during TDD or as a functional testing tool.
 */
@interface KIFSystemTestActor (ViewControllerActions)

/**
 The default `UINavigationBar` subclass to use when presenting view controllers without a navigation bar class specified.

 This is a subclass of `UINavigationBar` that is used when presenting view controllers via `presentViewControllerWithClass:withinNavigationControllerWithNavigationBarClass:toolbarClass:configurationBlock:` when the `navigationBarClass` argument is `nil`.
 */
@property (nonatomic, strong) Class defaultNavigationBarClass;

/**
 The default `UIToolbar` subclass to use when presenting view controllers without a toolbar bar class specified.

 This is a subclass of `UIToolbar` to use when presenting view controllers via `presentViewControllerWithClass:withinNavigationControllerWithNavigationBarClass:toolbarClass:configurationBlock:` when the `toolbarClass` argument is `nil`.
 */
@property (nonatomic, strong) Class defaultToolbarClass;

/**
 Instantiates and presents an instance of the specified `UIViewController` subclass within a `UINavigationController` instance with the specified `UINavigationBar` and `UIToolbar` subclasses, optionally yielding the instantiated controller to the block for configuration.

 @param viewControllerClass The `UIViewController` subclass to instantiate. Cannot be `nil`.
 @param navigationBarClass A subclass of `UINavigationBar` to use when instantiating the `UINavigationController` instance within which the view controller instance will be presented. If `nil`, then the class specified via `setDefaultNavigationBarClass:` will be used.
 @param toolbarClass A subclass of `UIToolbar` to use when instantiating the `UINavigationController` instance within which the view controller instance will be presented. If `nil`, then the class specified via `setDefaultToolbarClass:` will be used.
 @param configurationBlock An optional block in which to yield the newly instantiated view controller instance prior to presenting it in the main window.
 */
- (void)presentViewControllerWithClass:(Class)viewControllerClass withinNavigationControllerWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
                    configurationBlock:(void (^)(id viewController))configurationBlock;

/*!
 @method stepToPresentViewControllerWithIdentifier:fromStoryboardWithName:configurationBlock:
 @abstract A step that presents a view controller with a given identifier from a Storyboard
 with a given name.
 @discussion The view controller will be instantiated through the Storyboard and presented within a
 new UINavigationController, which will be configured as the root view controller of the
 application's primary window. The UIViewController is yielded to the configuration block before
 presentation so that any required setup work may be done (i.e. setting required properties).
 @param controllerIdentifier The identifier of the desired controller within the Storyboard.
 @param storyboardName The name of the Storyboard from which to instantiate the view controller.
 @param configurationBlock An optional configuration block which is invoked with the view controller
 before it is presented.
 @result A configured test step.
 */
- (void)presentViewControllerWithIdentifier:(NSString *)controllerIdentifier fromStoryboardWithName:(NSString *)storyboardName configurationBlock:(void (^)(UIViewController *viewController))configurationBlock;

/*!
 @method stepToPresentModalViewControllerWithIdentifier:fromStoryboardWithName:configurationBlock:
 @abstract A step that modally presents a view controller with a given identifier from a Storyboard
 with a given name.
 @discussion The view controller will be instantiated through the Storyboard and presented
 modally over a vanilla UIViewController configured as the root view controller of a new
 UINavigationController, which will be configured as the root view controller of the
 application's primary window. The UIViewController is yielded to the configuration block before
 presentation so that any required setup work may be done (i.e. setting required properties).
 @param controllerIdentifier The identifier of the desired controller within the Storyboard.
 @param storyboardName The name of the Storyboard from which to instantiate the view controller.
 @param configurationBlock An optional configuration block which is invoked with the view controller
 before it is presented.
 @result A configured test step.
 */
- (void)presentModalViewControllerWithIdentifier:(NSString *)controllerIdentifier fromStoryboardWithName:(NSString *)storyboardName configurationBlock:(void (^)(UIViewController *viewController))configurationBlock;


/*!
 @abstract Modally presents a given navigation controller on top of the currently presented view controller
 @param navigationController The `UINavigationController` object you wish to present
 @param configurationBlock An optional configuration block which is invoked with the navigation controller
 before it is presented.
 @result A configured test step.
 */
- (void)presentModalViewController:(UINavigationController *)navigationController configurationBlock:(void (^)(UINavigationController *navigationController))configurationBlock;

@end
