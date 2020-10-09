def shared_pods
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Performance'
end

target 'Cookbook' do
  platform :ios, '13.0'
  use_frameworks!
  # Pods for Cookbook
  shared_pods
end

target 'CookbookWidgetsExtension' do
  platform :ios, '13.0'
	use_frameworks!
  # Pods for CookbookWidgetExtension
  shared_pods
end

target 'CookbookTests' do
  use_frameworks!
  # Pods for CookbookTests
  shared_pods
end
