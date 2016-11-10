
Pod::Spec.new do |s|

  s.name         = "BCHPickerView"
  s.version      = "0.0.1"
  s.summary      = "基于UIPickerView封装的简易用的控件 BCHPickerView."
  s.description  = <<-DESC
基于UIPickerView封装的简易用的控件 BCHPickerView.
                   DESC
  s.homepage     = "https://github.com/Baichenghui/BCHPickerView"
  s.license      = "MIT"
  s.author             = { "Coder_Bai" => "baichenghui88888@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Baichenghui/BCHPickerView.git", :tag => "#{s.version}" }

  s.source_files  = "BCHPickerView", "BCHPickerView/*.{h,m}"
  s.requires_arc = true

end
