#配置默认 xcodeproj，路径相对于podfile的路径，这个必须配置
xcodeproj ‘GDP.xcodeproj'


target :GDP do
platform :ios,"9.0"
use_frameworks!

 pod 'SDWebImage', "4.0.0"

 pod 'SnapKit'
 
 pod 'GPUImage'

 pod ‘ObjectMapper’
 
end

post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
      if target.name == "Permission" and config.name.include?("Release")
          xcconfig_path = config.base_configuration_reference.real_path
          File.open(xcconfig_path, "a") {|file|
              file.puts "\nPERMISSION_ADDRESS_BOOK = PERMISSION_ADDRESS_BOOK"
              file.puts "\nPERMISSION_BLUETOOTH = PERMISSION_BLUETOOTH"
              file.puts "\nPERMISSION_CAMERA = PERMISSION_CAMERA"
              file.puts "\nPERMISSION_CONTACTS = PERMISSION_CONTACTS"
              file.puts "\nPERMISSION_EVENTS = PERMISSION_EVENTS"
              file.puts "\nPERMISSION_LOCATION = PERMISSION_LOCATION"
              file.puts "\nPERMISSION_MICROPHONE = PERMISSION_MICROPHONE"
              file.puts "\nPERMISSION_MOTION = PERMISSION_MOTION"
              file.puts "\nPERMISSION_NOTIFICATIONS = PERMISSION_NOTIFICATIONS"
              file.puts "\nPERMISSION_PHOTOS = PERMISSION_PHOTOS"
              file.puts "\nPERMISSION_REMINDERS = PERMISSION_REMINDERS"
              file.puts "\nPERMISSION_SPEECH_RECOGNIZER = PERMISSION_SPEECH_RECOGNIZER"
              file.puts "\nPERMISSION_MEDIA_LIBRARY = PERMISSION_MEDIA_LIBRARY"
              file.puts "\nPERMISSION_FLAGS = $(PERMISSION_ADDRESS_BOOK) $(PERMISSION_BLUETOOTH) $(PERMISSION_CAMERA) $(PERMISSION_CONTACTS) $(PERMISSION_EVENTS) $(PERMISSION_LOCATION) $(PERMISSION_MICROPHONE) $(PERMISSION_MOTION) $(PERMISSION_NOTIFICATIONS) $(PERMISSION_PHOTOS) $(PERMISSION_REMINDERS) $(PERMISSION_SPEECH_RECOGNIZER) $(PERMISSION_MEDIA_LIBRARY)"
              file.puts "\nSWIFT_ACTIVE_COMPILATION_CONDITIONS = $(inherited) $(PERMISSION_FLAGS)"
          }
      end
    end
  end
end
