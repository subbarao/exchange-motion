class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = CurrencyController.alloc.initWithStyle UITableViewStyleGrouped
    @window.makeKeyAndVisible
    true
  end
end
