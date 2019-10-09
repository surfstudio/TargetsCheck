platform :ios, '10.0'

use_frameworks!
inhibit_all_warnings!

def utils
    pod 'SwiftGen', '~> 6.1.0'
    pod 'SwiftLint', '~> 0.30.1'
end

def surf_utils
	# Put needed utils from SurfUtils here
end

def surf_lib
    pod 'PluggableApplicationDelegate', :git => 'https://github.com/surfstudio/PluggableApplicationDelegate.git', :commit => 'b24aabe3f34d51072cee5cac3b576dbb1f4ca9ec'
    # And other Surf pods, like NodeKit
end

def common_pods
    utils
    surf_utils
    surf_lib

    # Put your pods here
end

target 'TargetsCheck' do
    common_pods
end

target 'TargetsCheck Debug' do
    common_pods
end
