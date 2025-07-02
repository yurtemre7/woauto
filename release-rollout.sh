#!/bin/sh

git_count=$(git rev-list --count main)

echo "Rolling out +$git_count ..."

read -p "Press enter to continue..."

echo "Cleaning.."
flutter clean && flutter pub get

echo "Building for Android.."
flutter build appbundle --release --build-number="$git_count"
echo "Fastlane android.."
cd android && fastlane release && cd ..
echo "Cleaning.."
flutter clean && flutter pub get
echo "Done"
