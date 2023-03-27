#!/bin/bash
$git_count=$(git rev-list --count master)

echo "Rolling out +$git_count ..."

pause

echo "Cleaning.."
flutter clean && flutter pub get

echo "Building for Android.."
flutter build appbundle --release --build-number="$git_count"
echo "Fastlane android.."
cd android && bundle exec fastlane beta && cd ..
echo "Cleaning.."
flutter clean && flutter pub get
echo "Done"