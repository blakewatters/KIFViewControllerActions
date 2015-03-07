KIFViewControllerActions
========================

**Actions for KIF's System Test Actor to assist in functionally testing UIViewControllers.**

KIFViewControllerActions is a small library of actions for [KIF](https://github.com/KIF-framework/KIF) that provide support for functionally testing UIViewController objects. It is implemented as a category on the `KIFSystemTestActor` class.

These actions are designed to promote isolation between tests and enable the testing of view controllers that are not yet wired into the user interface. They are primarily of interest to those who use a test-driven development process and utilize KIF as a development tool rather than exclusively as an acceptance testing tool.

### API Summary

There are only a handful of properties and methods in the library. Each action instantiates and presents a view controller by replacing the `rootViewController` on the `keyWindow` of the `[UIApplication sharedApplication]` shared instance. Support is provided for programmatic and Storyboard based view controllers.

1. `- (void)presentViewControllerWithClass:(Class)viewControllerClass withinNavigationControllerWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass configurationBlock:(void (^)(id viewController))configurationBlock` - Instantiates and presents an instance of the specified `UIViewController` subclass within a `UINavigationController` instance with the specified `UINavigationBar` and `UIToolbar` subclasses, optionally yielding the instantiated controller to the block for configuration.
1. `- (void)presentViewControllerWithIdentifier:(NSString *)controllerIdentifier fromStoryboardWithName:(NSString *)storyboardName configurationBlock:(void (^)(UIViewController *viewController))configurationBlock` - Instantiates and presents a view controller from the Storyboard with the given name, optionally yielding the instantiated controller to the block for configuration.
1. `- (void)presentModalViewControllerWithIdentifier:(NSString *)controllerIdentifier fromStoryboardWithName:(NSString *)storyboardName configurationBlock:(void (^)(UIViewController *viewController))configurationBlock` - Instantiates and modally presents a view controller from the Storyboard with the given name, optionally yielding the instantiated controller to the block for configuration.
1. `defaultNavigationBarClass` - Specifies a `UINavigationBar` subclass to be used when instantiating view controllers.
1. `defaultToolbarClass` - Specifies a `UIToolbar` subclass to be used when instantiating view controllers.

## Example Usage

You can access the `KIFSystemTestActor` using the `system` property on `KIFTestCase`, e.g.

```
@interface MyViewControllerUITests : KIFTestCase

...

- (void)test
{
    [system presentViewControllerWithIdentifier:@"MyViewController"     
                         fromStoryboardWithName:@"MyStoryBoardName"     
                             configurationBlock:^(UIViewController *viewController) {    
        // Configure your view controller, e.g. by injecting mock data or a mock endpoint
        MyViewController *myViewController = (MyViewController *)viewController;
        ...
    }];
    
    [tester waitForViewWithAccessibilityLabel:@"my accessibility label"];
    [tester enterText:@"asdf" intoViewWithAccessibilityLabel:@"my accessibility label"];
}
```

## Contact

Blake Watters

- http://github.com/blakewatters
- http://twitter.com/blakewatters
- blakewatters@gmail.com

## License

KIFViewControllerActions is available under the Apache 2 License. See the LICENSE file for more info.
