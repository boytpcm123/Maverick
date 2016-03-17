@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [NSObject: AnyObject]?) -> Bool {
     
      let window = UIWindow(frame: UIScreen.mainScreen().bounds)
      self.window = window
      
      let rootViewController = TabBarController()
      window.rootViewController = rootViewController
      window.makeKeyAndVisible()

      return true
  }
}

