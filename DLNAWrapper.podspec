Pod::Spec.new do |s|
  s.name             = 'DLNAWrapper'
  s.version          = '0.1.0'
  s.summary          = 'Encapsulate DLNA function, implement simple video projection based on Upnp.'

  s.homepage         = 'https://github.com/ramonvic/DLNAWrapper'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ramon Vicente' => 'ramonvic@me.com' }
  s.source           = { :git => 'https://github.com/ramonvic/DLNAWrapper.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Ram0nVic'

  s.ios.deployment_target = '8.0'

  non_arc_files   = 'DLNAWrapper/Classes/Libraries/**/GDataXMLNode.{h,m}'

  s.requires_arc = true

  s.default_subspec = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files = 'DLNAWrapper/Classes/**/*'
    ss.exclude_files = non_arc_files

    ss.libraries = 'icucore', 'c++', 'z'

    ss.dependency 'CocoaAsyncSocket'
    ss.dependency 'DLNAWrapper/GDataXML'
  end

  s.subspec 'GDataXML' do |sna|
    sna.requires_arc = false
    sna.source_files = non_arc_files

    sna.libraries = 'xml2'

    sna.xcconfig = {
      'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2',
    }
  end
end
