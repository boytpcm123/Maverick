class Logger {
  
  class func debug(_ message: String, filename: String = #file,
                   function: String = #function, line: Int = #line) {
    #if DEBUG
      let component = filename.components(separatedBy: "/")
      if let fileName = component.last {
        print("💜[DEBUG][\(fileName):\(line)] \(function) 👉 \(message)")
      } else {
        print("💜[DEBUG][Unknown File:\(line)] \(function) 👉 \(message)")
      }
    #endif
  }
  
  class func info(_ message: String, filename: String = #file,
                  function: String = #function, line: Int = #line) {
    #if DEBUG
      let component = filename.components(separatedBy: "/")
      if let fileName = component.last {
        print("💚[INFO][\(fileName):\(line)] \(function) 👉 \(message)")
      } else {
        print("💚[INFO][Unknown File:\(line)] \(function) 👉 \(message)")
      }
    #endif
  }
  
  class func warning(_ message: String, filename: String = #file,
                     function: String = #function, line: Int = #line) {
    let component = filename.components(separatedBy: "/")
    if let fileName = component.last {
      print("💛[WARNING][\(fileName):\(line)] \(function) 👉 \(message)")
    } else {
      print("💛[WARNING][Unknown File:\(line)] \(function) 👉 \(message)")
    }
  }
  
  class func dafug(_ message: String, filename: String = #file,
                   function: String = #function, line: Int = #line) {
    let component = filename.components(separatedBy: "/")
    if let fileName = component.last {
      print("❤️[ERROR][\(fileName):\(line)] \(function) 👉 \(message)")
    } else {
      print("❤️[ERROR][Unknown File:\(line)] \(function) 👉 \(message)")
    }
  }
}

class System {
  
  class func isiPhone() -> Bool {
    return (UIDevice.current.model  == "iPhone") ||
      (UIDevice.current.model  == "iPhone Simulator")
  }
  
  class func systemVersionEqualTo(_ version: NSString) -> Bool {
    return UIDevice.current.systemVersion.compare(version as String,
                                                  options: NSString.CompareOptions.numeric) == ComparisonResult.orderedSame
  }
  
  class func systemVersionGreaterThan(_ version: NSString) -> Bool {
    return UIDevice.current.systemVersion.compare(version as String,
                                                  options: NSString.CompareOptions.numeric) == ComparisonResult.orderedDescending
  }
  
  class func systemVersionGreaterThanOrEqualTo(_ version: NSString) -> Bool {
    return UIDevice.current.systemVersion.compare(version as String,
                                                  options: NSString.CompareOptions.numeric) != ComparisonResult.orderedAscending
  }
  
  class func systemVersionLessThan(_ version: NSString) -> Bool {
    return UIDevice.current.systemVersion.compare(version as String,
                                                  options: NSString.CompareOptions.numeric) == ComparisonResult.orderedAscending
  }
  
  class func systemVersionLessThanOrEqualTo(_ version: NSString) -> Bool {
    return UIDevice.current.systemVersion.compare(version as String,
                                                  options: NSString.CompareOptions.numeric) != ComparisonResult.orderedDescending
  }
}
