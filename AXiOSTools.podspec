Pod::Spec.new do |s|
      s.name = "AXiOSTools"
      s.version = "1.0.0"
      s.ios.deployment_target = '7.0'
      s.summary = "个人开发工具"
      s.homepage = "https://github.com/AXinger/AXiOSTools"
      s.license = { :type => "MIT", :file => "LICENSE" }
      s.author = { "Axing" => "liu_weixing@qq.com" }
      s.social_media_url = "https://www.jianshu.com/u/332ecb51d41b"
      s.source = { :git => "https://AXinger@github.com/AXinger/AXiOSTools.git", :tag => s.version }
      s.source_files = "AXiOSTools","AXiOSTools/*.{h,m}"
      s.resources = "AXiOSTools/AXTools.bundle"
      s.requires_arc = true
  end