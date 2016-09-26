extension UIColor {
  convenience init(hex: Int, alpha: CGFloat = 1.0) {
    self.init(red: CGFloat((hex >> 16) & 0xff) / 255.0,
              green: CGFloat((hex >> 8) & 0xff) / 255.0,
              blue: CGFloat(hex & 0xff) / 255.0,
              alpha: alpha)
  }
  
  convenience init(hexString: String, alpha: CGFloat = 1.0) {
    if hexString.isEmpty || hexString.characters.count != 6 {
      self.init(hex: 0x000000)
    } else {
      var rgbValue: UInt32 = 0
      Scanner(string: hexString).scanHexInt32(&rgbValue)
      self.init(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
      )
    }
  }
  
  class func getRandomColor() -> UIColor {
    let r = arc4random() % 255 + 0
    let g = arc4random() % 255 + 0
    let b = arc4random() % 255 + 0
    return UIColor(red: CGFloat(r)/255.0,
                   green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
  }
}

extension UIImage {
  func crop(_ rect: CGRect) -> UIImage? {
    let imageRef = self.cgImage?.cropping(to: rect)
    let cropped = UIImage(cgImage: imageRef!)
    return cropped
  }
}

extension UITextView: UITextViewDelegate {
  var placeholder: String? {
    get {
      var placeholderText: String?
      
      if let placeHolderLabel = self.viewWithTag(100) as? UILabel {
        placeholderText = placeHolderLabel.text
      }
      return placeholderText
    }
    set {
      let placeHolderLabel = self.viewWithTag(100) as! UILabel?
      if placeHolderLabel == nil {
        self.addPlaceholderLabel(newValue!)
      }
      else {
        placeHolderLabel?.text = newValue
        placeHolderLabel?.sizeToFit()
      }
    }
  }
  
  public func textViewDidChange(_ textView: UITextView) {
    let placeHolderLabel = self.viewWithTag(100)
    if !self.hasText {
      placeHolderLabel?.isHidden = false
    }
    else {
      placeHolderLabel?.isHidden = true
    }
  }
  
  func addPlaceholderLabel(_ placeholderText: String) {
    let placeholderLabel = UILabel()
    placeholderLabel.text = placeholderText
    placeholderLabel.sizeToFit()
    placeholderLabel.frame.origin.x = 5.0
    placeholderLabel.frame.origin.y = 5.0
    placeholderLabel.font = self.font
    placeholderLabel.textColor = UIColor.lightGray
    placeholderLabel.tag = 100
    placeholderLabel.isHidden = (self.text.characters.count > 0)
    self.addSubview(placeholderLabel)
    self.delegate = self;
  }
}

public enum Result<T: Any> {
  case success(T?)
  case failure(Int)
  case cancel(T?)
  case notFound(T?)
}
