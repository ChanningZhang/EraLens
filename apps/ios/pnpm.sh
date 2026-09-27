xcrun simctl list devices booted

pnpm ios:sync
xcodebuild -project apps/ios/ios/App/App.xcodeproj \
  -scheme App -configuration Debug \
  -destination 'platform=iOS Simulator,id=E7EFA5C7-E346-41FA-A50A-745B977DDE84' \
  -derivedDataPath .build/ios/DerivedData \
  -clonedSourcePackagesDirPath .build/ios/SourcePackages \
  CODE_SIGNING_ALLOWED=NO build

xcodebuild -project apps/ios/ios/App/App.xcodeproj -scheme App -configuration Debug \
  -destination 'platform=iOS Simulator,id=E7EFA5C7-E346-41FA-A50A-745B977DDE84' \
  -derivedDataPath .build/ios/DerivedData \
  -clonedSourcePackagesDirPath .build/ios/SourcePackages \
  CODE_SIGNING_ALLOWED=NO build &&
xcrun simctl install E7EFA5C7-E346-41FA-A50A-745B977DDE84 .build/ios/DerivedData/Build/Products/Debug-iphonesimulator/App.app &&
xcrun simctl launch E7EFA5C7-E346-41FA-A50A-745B977DDE84 com.eralens.app


xcodebuild -project apps/ios/ios/App/App.xcodeproj -scheme App -configuration Debug \
  -destination 'platform=iOS Simulator,id=BCFCE82E-D04A-4A73-A7AF-BF769F1CF2EB' \
  -derivedDataPath .build/ios/DerivedData \
  -clonedSourcePackagesDirPath .build/ios/SourcePackages \
  CODE_SIGNING_ALLOWED=NO build &&
xcrun simctl install BCFCE82E-D04A-4A73-A7AF-BF769F1CF2EB .build/ios/DerivedData/Build/Products/Debug-iphonesimulator/App.app &&
xcrun simctl launch BCFCE82E-D04A-4A73-A7AF-BF769F1CF2EB com.eralens.app
