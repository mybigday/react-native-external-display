#import "RNExternalDisplayView.h"
#import "UIView+React.h"
#import "RCTShadowView.h"
#import <React/RCTLog.h>
#ifdef RCT_NEW_ARCH_ENABLED
#import <React/RCTFabricComponentsPlugins.h>
#import <react/renderer/components/RNExternalDisplaySpec/ComponentDescriptors.h>
#import <react/renderer/components/RNExternalDisplaySpec/Props.h>
#endif

@implementation RNExternalDisplayView {
  UIWindow *_window;
  NSMutableArray<UIView *> *_subviews;
  NSString *_screen;
  BOOL _fallbackInMainScreen;
}

- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
  if (!_subviews) {
    _subviews = [NSMutableArray new];
  }
  [_subviews insertObject:subview atIndex:atIndex];
  [super insertReactSubview:subview atIndex:atIndex];
  [self updateScreen];
}

- (void)removeReactSubview:(UIView *)subview
{
  [super removeReactSubview:subview];
}

- (void)didMoveToSuperview
{
  [super didMoveToSuperview];
  if (!self.superview) {
    [self invalidate];
  }
}

- (void)didUpdateReactSubviews {
  if (_fallbackInMainScreen && !_window) {
    [super didUpdateReactSubviews];
  }
}

- (void)invalidateWindow {
  if (_window) {
    for (UIView *subview in _subviews) {
      [subview removeFromSuperview];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      [UIApplication.sharedApplication.delegate.window makeKeyAndVisible];
    });
  }
  _window = nil;
}

- (void)invalidate {
  [self invalidateWindow];
  [self.delegate removeView:self];
}

#if defined(TARGET_OS_TV) && TARGET_OS_TV == 1
  #define MA_APPLE_TV
#endif

- (void)setHighestWidthMode:(UIScreen *)screen {
#if !defined(MA_APPLE_TV)
  __block UIScreenMode *highestWidthMode = NULL;

  [screen.availableModes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    UIScreenMode *currentModeInLoop = obj;
    if (!highestWidthMode || currentModeInLoop.size.width > highestWidthMode.size.width)
      highestWidthMode = currentModeInLoop;
  }];

  screen.currentMode = highestWidthMode;
  screen.overscanCompensation = UIScreenOverscanCompensationScale;
#endif
}

- (UIWindow *)getScreenWindow {
  NSArray *screens = [UIScreen screens];
  int index = [_screen intValue];
  if (index > 0 && index < [screens count]) {
    UIScreen* screen = [screens objectAtIndex:index];

    [self setHighestWidthMode:screen];

    if (!_window) _window = [[UIWindow alloc] initWithFrame:screen.bounds];
    UIViewController *rootViewController = [UIViewController new];
    rootViewController.view = [RCTView new];
    _window.rootViewController = rootViewController;
    [_window setScreen:screen];
  }

  return _window;
}

// iOS 13+ only
- (UIWindow *)getSceneWindow {
  NSSet *scenes = [UIApplication sharedApplication].connectedScenes;

  UIWindowScene* scene = [[scenes filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"session.persistentIdentifier == %@", _screen]] anyObject];
  if (scene == nil) return _window;

  UIScreen *screen = scene.screen;
  [self setHighestWidthMode:screen];

  if (!_window) _window = scene.windows.firstObject;
  [_window setWindowScene:scene];
  return _window;
}

- (void)updateScreen {
  if ([_subviews count] == 0) {
    return;
  }

  UIWindow *window = nil;
  if (@available(iOS 13.0, tvOS 13.0, *)) {
    window = [self getSceneWindow];
  } else {
    window = [self getScreenWindow];
  }
  if (window) {
    int i = 0;
    for (UIView *subview in _subviews) {
#ifdef RCT_NEW_ARCH_ENABLED
      [subview removeFromSuperview];
      [_window.rootViewController.view mountChildComponentView:subview index:i];
#else
      [_window.rootViewController.view insertSubview:subview atIndex:i];
#endif
      i++;
    }
    [_window makeKeyAndVisible];
  } else if (_fallbackInMainScreen) {
#ifdef RCT_NEW_ARCH_ENABLED
    int i = 0;
    for (UIView *subview in _subviews) {
      [subview removeFromSuperview];
      [super mountChildComponentView:subview index:i];
      i++;
    }
#endif
  }
}


- (NSString *)screen {
  return _screen;
}

- (void)setScreen:(NSString*)screen {
  NSLog(@"[RNExternalDisplay] setScreen: %@", screen);
  if (screen != _screen) {
    [self invalidateWindow];
  }
  _screen = screen;
  [self.delegate checkScreen];
  [self updateScreen];
  [self didUpdateReactSubviews];
}

- (void)setFallbackInMainScreen:(BOOL)fallbackInMainScreen {
  _fallbackInMainScreen = fallbackInMainScreen;
  if (!_window) {
    [self updateScreen];
    [self didUpdateReactSubviews];
  }
}

#pragma mark-- Fabric specific
#ifdef RCT_NEW_ARCH_ENABLED

using namespace facebook::react;

- (instancetype)initWithFrame:(CGRect)frame
{
  _subviews = [NSMutableArray new];
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const RNExternalDisplayProps>();
    _props = defaultProps;
  }
  return self;
}

- (void)mountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index
{
  [_subviews insertObject:childComponentView atIndex:index];
  [self updateScreen];
}

- (void)unmountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index
{
  if (_window) {
    UIView *subview = [_subviews objectAtIndex:index];
    [subview removeFromSuperview];
    [_subviews removeObjectAtIndex:index];
  } else {
    [super unmountChildComponentView:childComponentView index:index];
    [_subviews removeObjectAtIndex:index];
  }
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
  const auto &oldViewProps = *std::static_pointer_cast<RNExternalDisplayProps const>(_props);
  const auto &newViewProps = *std::static_pointer_cast<RNExternalDisplayProps const>(props);

  if (oldViewProps.screen != newViewProps.screen) {
    [self setScreen:[NSString stringWithUTF8String:newViewProps.screen.c_str()]];
  }
  if (oldViewProps.fallbackInMainScreen != newViewProps.fallbackInMainScreen) {
    [self setFallbackInMainScreen:newViewProps.fallbackInMainScreen];
  }

  [super updateProps:props oldProps:oldProps];
}

+ (facebook::react::ComponentDescriptorProvider)componentDescriptorProvider
{
  return facebook::react::concreteComponentDescriptorProvider<
      facebook::react::RNExternalDisplayComponentDescriptor>();
}
#endif

@end

#ifdef RCT_NEW_ARCH_ENABLED
Class<RCTComponentViewProtocol> RNExternalDisplayCls(void)
{
  return RNExternalDisplayView.class;
}
#endif
