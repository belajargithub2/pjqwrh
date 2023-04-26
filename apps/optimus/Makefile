devices :
	flutter devices

docker-build :
	docker build -f Dockerfile -t deasy .

emulators :
	flutter emulators

build-apk-dev-debug :
	flutter build apk --debug --flavor dev -t lib/flavor/dev/main_dev.dart

build-apk-dev-release :
	flutter build apk --release --flavor dev -t lib/flavor/dev/main_dev.dart

build-apk-staging-debug :
	flutter build apk --debug --flavor staging -t lib/flavor/staging/main_staging.dart

build-apk-staging-release :
	flutter build apk --release --flavor staging -t lib/flavor/staging/main_staging.dart

build-apk-prod-debug :
	flutter build apk --debug --flavor prod -t lib/flavor/prod/main_prod.dart

build-apk-prod-release :
	flutter build apk --release --flavor prod -t lib/flavor/prod/main_prod.dart

build-apk-mock-debug :
	flutter build apk --debug --flavor mock -t lib/flavor/mock/main_mock.dart

build-apk-mock-release :
	flutter build apk --release --flavor mock -t lib/flavor/mock/main_mock.dart

build-appbundle-debug :
	flutter build appbundle --flavor dev -t lib/flavor/dev/main_dev.dart

build-appbundle-staging :
	flutter build appbundle --flavor staging -t lib/flavor/staging/main_staging.dart

build-appbundle-prod :
	flutter build appbundle --flavor prod -t lib/flavor/prod/main_prod.dart

build-appbundle-mock :
	flutter build appbundle --flavor mock -t lib/flavor/mock/main_mock.dart

build-web :
	flutter build web --web-renderer auto

deploy-web :
	firebase deploy

emulator-android :
	flutter emulators --launch Pixel_3a_API_30_x86

emulator-ios :
	flutter emulators --launch apple_ios_simulator

run-android-with-emulator :
	flutter emulators --launch Pixel_3a_API_30_x86
	flutter run --debug --flavor dev -t lib/flavor/dev/main_dev.dart -d "emulator-5554"

run-dev-debug :
	flutter run --debug --flavor dev -t lib/flavor/dev/main_dev.dart

run-dev-release :
	flutter run --release --flavor dev -t lib/flavor/dev/main_dev.dart

run-staging-debug :
	flutter run --debug --flavor staging -t lib/flavor/staging/main_staging.dart

run-staging-release :
	flutter run --release --flavor staging -t lib/flavor/staging/main_staging.dart

run-prod-debug :
	flutter run --debug --flavor prod -t lib/flavor/prod/main_prod.dart

run-prod-release :
	flutter run --release --flavor prod -t lib/flavor/prod/main_prod.dart

run-mock-debug :
	flutter run --debug --flavor mock -t lib/flavor/mock/main_mock.dart

run-mock-release :
	flutter run --release --flavor mock -t lib/flavor/mock/main_mock.dart

run-web-dev-debug :
	flutter run --debug --flavor dev -t lib/flavor/dev/main_dev.dart -d chrome

run-web-dev-release :
	flutter run --release --flavor dev -t lib/flavor/dev/main_dev.dart -d chrome

run-web-staging-debug :
	flutter run --debug --flavor staging -t lib/flavor/staging/main_staging.dart -d chrome

run-web-staging-release :
	flutter run --release --flavor staging -t lib/flavor/staging/main_staging.dart -d chrome

run-web-prod-debug :
	flutter run --debug --flavor prod -t lib/flavor/prod/main_prod.dart -d chrome

run-web-prod-release :
	flutter run --release --flavor prod -t lib/flavor/prod/main_prod.dart -d chrome

run-web-mock-debug :
	flutter run --debug --flavor mock -t lib/flavor/mock/main_mock.dart -d chrome

run-web-dev-release :
	flutter run --release --flavor mock -t lib/flavor/mock/main_mock.dart -d chrome

run-ios :
	flutter emulators --launch apple_ios_simulator
	flutter run --flavor develop -d "13E6CD5D-1D53-4C31-8C10-7CCFB669FCE"