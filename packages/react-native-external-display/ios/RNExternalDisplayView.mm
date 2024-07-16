#import "RNExternalDisplayView.h"
#import <React/UIView+React.h>
#import <React/RCTShadowView.h>
#import <React/RCTLog.h>
#ifdef RCT_NEW_ARCH_ENABLED
#import <React/RCTFabricComponentsPlugins.h>
#import <react/renderer/components/RNExternalDisplaySpec/ComponentDescriptors.h>
#import <react/renderer/components/RNExternalDisplaySpec/Props.h>
#import "RCTSurfaceTouchHandler.h"
#define RCTTouchHandler RCTSurfaceTouchHandler
#else
#import <React/RCTBridge+Private.h>
#import <React/RCTTouchHandler.h>
#endif

@implementation RNExternalDisplayView {
  UIWindow *_window;
  RCTTouchHandler *_touchHandler;
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
  [_subviews removeObject:subview];
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
    for (UIView *subview in self->_subviews) {
      [subview removeFromSuperview];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
      [UIApplication.sharedApplication.delegate.window makeKeyAndVisible];
    });
  }
  _window = nil;
  _touchHandler = nil;
}

- (void)invalidate {
  dispatch_async(dispatch_get_main_queue(), ^{
    [self invalidateWindow];
    [self.delegate removeView:self];
  });
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

- (void)setViewControllerIfNeeded {
  if (!_window) return;
  if (!_window.rootViewController) {
    UIViewController *rootViewController = [UIViewController new];
    rootViewController.view = [RCTView new];
    _window.rootViewController = rootViewController;
  }
}

- (void)attachTouchHandler {
#ifdef RCT_NEW_ARCH_ENABLED
  _touchHandler = [[RCTSurfaceTouchHandler alloc] init];
#else
  _touchHandler = [[RCTTouchHandler alloc] initWithBridge:[RCTBridge currentBridge]];
#endif
  [_touchHandler attachToView:_window.rootViewController.view];
}

- (UIWindow *)getScreenWindow {
  NSArray *screens = [UIScreen screens];
  int index = [_screen intValue];
  if (index > 0 && index < [screens count]) {
    UIScreen* screen = [screens objectAtIndex:index];

    [self setHighestWidthMode:screen];

    if (!_window) {
      _window = [[UIWindow alloc] initWithFrame:screen.bounds];
      [self attachTouchHandler];
    }
    [self setViewControllerIfNeeded];
    [_window setScreen:screen];
  }

  return _window;
}

- (UIWindow *)getSceneWindow API_AVAILABLE(ios(13.0)) {
  NSSet *scenes = [UIApplication sharedApplication].connectedScenes;

  UIWindowScene* scene = [[scenes filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"session.persistentIdentifier == %@", _screen]] anyObject];
  if (scene == nil) return _window;

  UIScreen *screen = scene.screen;
  [self setHighestWidthMode:screen];

  if (!_window) {
    _window = scene.windows.firstObject;
    if (_window) [self attachTouchHandler];
  }
  if (!_window) {
    _window = [[UIWindow alloc] initWithWindowScene:scene];
    _window.frame = scene.coordinateSpace.bounds;
    [self setViewControllerIfNeeded];
    [self attachTouchHandler];
  }
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
#ifdef RCT_NEW_ARCH_ENABLED
    for (UIView *subview in _subviews) {
      [subview removeFromSuperview];
      [_window.rootViewController.view mountChildComponentView:subview index:i];
      i++;
    }
#else
    for (UIView *subview in _subviews) {
      [_window.rootViewController.view insertSubview:subview atIndex:i];
      i++;
    }
#endif
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
