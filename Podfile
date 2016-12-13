# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'SilentRunner' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for SilentRunner

end

target 'SilentRunnerEngine' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for SilentRunnerEngine
  pod 'JSONRPCom', :git => 'https://github.com/andrewBatutin/JSONRPCom.git'
  pod 'SocketRocket'
  pod 'OCMockito', '~> 4.0'

  target 'SilentRunnerEngineTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'JSONRPCom', :git => 'https://github.com/andrewBatutin/JSONRPCom.git'
    pod 'SocketRocket'
    pod 'OCMockito', '~> 4.0'
  end

end
