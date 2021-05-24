#!/bin/bash -e -o pipefail

.PHONY: help clean project requirebrew xcodegen

help: requirebrew xcodegen
	@echo Usage:
	@echo ""
	@echo "  make clean     - removes all generated products"
	@echo "  make compile   - compile package"
	@echo "  make jazzy     - generate jazzy docs (https://github.com/realm/jazzy)"
	@echo "  make project   - generates a xcode project with local dependencies"
	@echo "  make swiftdoc  - generate swift docs (https://github.com/SwiftDocOrg/swift-doc)"
	@echo "  make swiftlint - Run swiftlint"
	@echo ""

clean:
	rm -rf .build
	rm -rf .swiftpm
	rm -rf build
	rm -rf Package.resolved

swiftdoc: requireswiftdoc
	mkdir -p .build/swiftdocs
	@MK_PATH="$(shell xcodebuild -showBuildSettings | grep PROJECT_NAME | awk '{print $$NF}')"; \
	swift doc generate sources/main --module-name $$MK_PATH --format html --output .build/swiftdocs
	@echo "Docs generated at .build/swiftdocs" 
	@echo "To serve the docs run: cd .build/swiftdocs; python -m SimpleHTTPServer 8080"
	@echo "Browse the docs at http://127.0.0.1:8080"

swiftlint:
	swift run swiftlint

jazzy: requirejazzy
	mkdir -p .build/jazzy
	@MK_PATH="$(shell xcodebuild -showBuildSettings | grep PRODUCT_MODULE_NAME | awk '{print $$NF}')"; \
	jazzy --output .build/jazzy --module $$MK_PATH --swift-build-tool spm --sdk simulator --build-tool-arguments -Xswiftc,-swift-version,-Xswiftc,5,-Xswiftc,-sdk,-Xswiftc,"`xcrun --sdk iphonesimulator --show-sdk-path`",-Xswiftc,"-target",-Xswiftc,"x86_64-apple-ios14.4-simulator"
	@echo "Browse the docs at .build/jazzy/index.html"

compile:
	swift build -Xswiftc "-sdk" -Xswiftc "`xcrun --sdk iphonesimulator --show-sdk-path`" -Xswiftc "-target" -Xswiftc "x86_64-apple-ios14.4-simulator" 

project: requirexcodegen
	@MK_PATH="$(shell xcodebuild -showBuildSettings | grep PROJECT_NAME | awk '{print $$NF}')"; \
	rm -rf "${MK_PATH}.xcodeproj"; \
	xcodegen generate --project . --spec project.yml; \
	open $$MK_PATH.xcodeproj

requirebrew:
	@if ! command -v brew &> /dev/null; then echo "Please install brew from https://brew.sh/"; exit 1; fi

requirejazzy:
	@if ! command -v brew &> /dev/null; then echo "Please install jazzy with gem install jazzy"; exit 1; fi

requireswiftdoc: requirebrew
	@if ! command -v swift-doc &> /dev/null; then echo "Please install swift-doc using 'brew install swiftdocorg/formulae/swift-doc'. Check the logs if trouble arises."; exit 1; fi

requirexcodegen: requirebrew
	@if ! command -v xcodegen &> /dev/null; then echo "Please install xcodegen using 'brew install xcodegen'"; exit 1; fi
