.PHONY: help install remove_unused_imports sort_imports format build_runner analyze test simulator-ios emulator-android run-ios run-android build-ios build-android

help:
	@echo "  make install               - 依存関係をインストール"
	@echo "  make remove_unused_imports - 未使用のimportを削除"
	@echo "  make sort_imports          - importをソート"
	@echo "  make format                - コードをフォーマット"
	@echo "  make build_runner          - ビルドランナーを実行"
	@echo "  make analyze               - コードを解析"
	@echo "  make test                  - テストを実行"
	@echo "  make simulator-ios         - iOSシミュレータを起動"
	@echo "  make emulator-android      - Androidエミュレータを起動"
	@echo "  make run-ios               - iOSシミュレータでアプリを実行"
	@echo "  make run-android           - Androidエミュレータでアプリを実行"
	@echo "  make build-ios             - iOSアプリをビルド"
	@echo "  make build-android         - Androidアプリをビルド"

install:
	flutter clean && flutter pub get && cd ios && pod install && cd ..

remove_unused_imports:
	dart fix --apply --code=unused_import lib
	dart fix --apply --code=unused_import test

sort_imports:
	flutter pub run import_sorter:main

format:
	dart format .

build_runner:
	flutter pub run build_runner build --delete-conflicting-outputs

analyze:
	flutter analyze

test:
	flutter test --coverage

simulator-ios:
	open -a Simulator

emulator-android:
	@flutter emulators
	@flutter emulators --launch $(shell flutter emulators | grep -m 1 "android" | awk '{print $$1}' || echo "")

run-ios:
	flutter run

run-android:
	flutter run

build-ios:
	flutter build ipa -v

build-android:
	flutter build appbundle -v
