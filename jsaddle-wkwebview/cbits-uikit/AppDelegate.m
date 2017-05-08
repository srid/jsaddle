#import "AppDelegate.h"
#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

extern void handlerIO(HsStablePtr);
extern void handlerCString(const char * _Nonnull, HsStablePtr);

@interface AppDelegate ()

@end

HsStablePtr globalHandler = 0;
HsStablePtr global_willFinishLaunchingWithOptions = 0;
HsStablePtr global_didFinishLaunchingWithOptions = 0;
HsStablePtr global_applicationDidBecomeActive = 0;
HsStablePtr global_applicationWillResignActive = 0;
HsStablePtr global_applicationDidEnterBackground = 0;
HsStablePtr global_applicationWillEnterForeground = 0;
HsStablePtr global_applicationWillTerminate = 0;
HsStablePtr global_applicationSignificantTimeChange = 0;
BOOL global_requestAuthorizationWithOptions = NO;
BOOL global_requestAuthorizationOptionBadge = NO;
BOOL global_requestAuthorizationOptionSound = NO;
BOOL global_requestAuthorizationOptionAlert = NO;
BOOL global_requestAuthorizationOptionCarPlay = NO;
BOOL global_registerForRemoteNotifications = NO;
HsStablePtr global_didRegisterForRemoteNotificationsWithDeviceToken = 0;
HsStablePtr global_didFailToRegisterForRemoteNotificationsWithError = 0;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Tells the delegate that the launch process has begun but that state restoration has not yet occurred.
    handlerIO(global_willFinishLaunchingWithOptions);
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Tells the delegate that the launch process is almost done and the app is almost ready to run.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController = [[ViewController alloc] initWithHandler:globalHandler];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    if (global_requestAuthorizationWithOptions) {
      UNAuthorizationOptions options = (UNAuthorizationOptions)0;
      if (global_requestAuthorizationOptionBadge) {
        options = options + UNAuthorizationOptionBadge;
      }
      if (global_requestAuthorizationOptionSound) {
        options = options + UNAuthorizationOptionSound;
      }
      if (global_requestAuthorizationOptionAlert) {
        options = options + UNAuthorizationOptionAlert;
      }
      if (global_requestAuthorizationOptionCarPlay) {
        options = options + UNAuthorizationOptionCarPlay;
      }
      [center requestAuthorizationWithOptions:(options)
         completionHandler:^(BOOL granted, NSError * _Nullable error) {
           // Handler used to alter application behavior based on types of notifications authorized
      }];
    }
    if (global_registerForRemoteNotifications) {
      [application registerForRemoteNotifications];
    }
    handlerIO(global_didFinishLaunchingWithOptions);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    handlerIO(global_applicationWillResignActive);
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    handlerIO(global_applicationDidEnterBackground);
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    handlerIO(global_applicationWillEnterForeground);
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    handlerIO(global_applicationDidBecomeActive);
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    handlerIO(global_applicationWillTerminate);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Tells the delegate that the app successfully registered with Apple Push Notification service (APNs).
    NSString *deviceTokenString = [deviceToken base64EncodedStringWithOptions: 0];
    handlerCString([deviceTokenString UTF8String], global_didRegisterForRemoteNotificationsWithDeviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // Sent to the delegate when Apple Push Notification service cannot successfully complete the registration process.
    NSString *errorString = [error localizedDescription];
    handlerCString([errorString UTF8String], global_didFailToRegisterForRemoteNotificationsWithError);
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
    // Tells the delegate when there is a significant change in the time.
    handlerIO(global_applicationSignificantTimeChange);
}

@end

void runInWKWebView(HsStablePtr handler,
                    const char * _Nonnull progName,
                    HsStablePtr hs_willFinishLaunchingWithOptions,
                    HsStablePtr hs_didFinishLaunchingWithOptions,
                    HsStablePtr hs_applicationDidBecomeActive,
                    HsStablePtr hs_applicationWillResignActive,
                    HsStablePtr hs_applicationDidEnterBackground,
                    HsStablePtr hs_applicationWillEnterForeground,
                    HsStablePtr hs_applicationWillTerminate,
                    HsStablePtr hs_applicationSignificantTimeChange,
                    const BOOL hs_requestAuthorizationWithOptions,
                    const BOOL hs_requestAuthorizationOptionBadge,
                    const BOOL hs_requestAuthorizationOptionSound,
                    const BOOL hs_requestAuthorizationOptionAlert,
                    const BOOL hs_requestAuthorizationOptionCarPlay,
                    const BOOL hs_registerForRemoteNotifications,
                    HsStablePtr hs_didRegisterForRemoteNotificationsWithDeviceToken,
                    HsStablePtr hs_didFailToRegisterForRemoteNotificationsWithError) {
    @autoreleasepool {
        globalHandler = handler;
        global_willFinishLaunchingWithOptions = hs_willFinishLaunchingWithOptions;
        global_didFinishLaunchingWithOptions = hs_didFinishLaunchingWithOptions;
        global_applicationDidBecomeActive = hs_applicationDidBecomeActive;
        global_applicationWillResignActive = hs_applicationWillResignActive;
        global_applicationDidEnterBackground = hs_applicationDidEnterBackground;
        global_applicationWillEnterForeground = hs_applicationWillEnterForeground;
        global_applicationWillTerminate = hs_applicationWillTerminate;
        global_applicationSignificantTimeChange = hs_applicationSignificantTimeChange;
        global_requestAuthorizationWithOptions = hs_requestAuthorizationWithOptions;
        global_requestAuthorizationOptionBadge = hs_requestAuthorizationOptionBadge;
        global_requestAuthorizationOptionSound = hs_requestAuthorizationOptionSound;
        global_requestAuthorizationOptionAlert = hs_requestAuthorizationOptionAlert;
        global_requestAuthorizationOptionCarPlay = hs_requestAuthorizationOptionCarPlay;
        global_registerForRemoteNotifications = hs_registerForRemoteNotifications;
        global_didRegisterForRemoteNotificationsWithDeviceToken = hs_didRegisterForRemoteNotificationsWithDeviceToken;
        global_didFailToRegisterForRemoteNotificationsWithError = hs_didFailToRegisterForRemoteNotificationsWithError;
        const char * _Nonnull argv [] =  {"", 0};
        UIApplicationMain(0, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

BOOL openApp(NSURL * url) {
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
        return true;
    }
    return false;
}
