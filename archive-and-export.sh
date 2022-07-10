# Read script input parameter and add it to your Info.plist. Values can either be CATS or DOGS
alias PlistBuddy=/usr/libexec/PlistBuddy
PLIST="CatsAndModules-DariaShevchenko-Info.plist"
PlistBuddy -c "Set :Data $1" $PLIST

# Clean build folder
PROJECT="CatsAndModules_DariaShevchenko.xcodeproj"
SCHEME="CatsAndModules_DariaShevchenko"
CONFIG=Release
DEST="generic/platform=iOS"

xcodebuild clean -project "${PROJECT}" -scheme "${SCHEME}" -configuration "${CONFIG}"

# Create archive
VERSION="v1.0.0"
ARCHIVE_PATH="./ARCHIVES/${VERSION}.xcarchive"

xcodebuild archive -archivePath "${ARCHIVE_PATH}" -project "${PROJECT}" -scheme "${SCHEME}" -configuration "${CONFIG}" -destination "${DEST}"

EXPORT_PATH="./Exported_$1/"
EXPORT_OPTIONS_PLIST="./exportOptions.plist"

xcodebuild -exportArchive -archivePath "${ARCHIVE_PATH}" -exportPath "${EXPORT_PATH}" -exportOptionsPlist "${EXPORT_OPTIONS_PLIST}"

