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
  UIView *_subview;
  NSString *_screen;
  BOOL _fallbackInMainScreen;
}

- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
  if (atIndex > 0) {
    RCTLogError(@"RNExternalDisplayView only allowed one child view.");
    return;
  }
  _subview = subview;
  [super insertReactSubview:_subview atIndex:atIndex];
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

- (void)updateScreen {
  if (!_subview) {
    return;
  }
  NSArray *screens = [UIScreen screens];
  int index = [_screen intValue];
  if (index > 0 && index < [screens count]) {
    // NSLog(@"[RNExternalDisplay] Selected External Display");
    UIScreen* screen = [screens objectAtIndex:index];

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

    _window = [[UIWindow alloc] initWithFrame:screen.bounds];
    UIViewController *rootViewController = [UIViewController new];
    rootViewController.view = [RCTView new];
    [rootViewController.view insertSubview:_subview atIndex:0];
    _window.rootViewController = rootViewController;
    [_window setScreen:screen];
    [_window makeKeyAndVisible];
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
  if (self = [super initWithFrame:frame]) {
    static const auto defaultProps = std::make_shared<const RNExternalDisplayProps>();
    _props = defaultProps;
  }

  return self;
}

- (void)mountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index
{
  if (index > 0) {
    // TODO: _subviews
    RCTLogError(@"RNExternalDisplayView only allowed one child view.");
    return;
  }
  _subview = childComponentView;
  [super mountChildComponentView:childComponentView index:index];
  [super insertReactSubview:_subview atIndex:index];
  [self updateScreen];
}

- (void)unmountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index
{
  [super unmountChildComponentView:childComponentView index:index];
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
