Pod::Spec.new do |s|
s.name         = 'RENNotificationCenter'
s.version      = '0.0.1'
s.summary      = 'An easy way to use notification'
s.homepage     = 'https://github.com/REN-LEI/RENNotificationCenter'
s.license      = 'MIT'
s.authors      = {'renlei' => '568577297@qq.com'}
s.platform     = :ios, '6.0'
s.source       = {:git => 'https://github.com/REN-LEI/RENNotificationCenter.git', :tag => s.version}
s.source_files = 'RENNotificationCenter/**/*.{h,m}'
s.requires_arc = true
end
