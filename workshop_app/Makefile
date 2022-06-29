# variables
## ease of use stuff
GET = .dart_tool/package_config.json
GET_ALL = $(GET) ios/Podfile.lock
SED = $(shell sh -c "which gsed sed | head -n 1") # Use gsed if available, else sed

## Files
### Files to exclude from make clean
GIT_CLEAN_EXCLUDES = -e '!firebase_options.dart'

first: get generate

# setup
## Runs flutter pub get, if pubspec has been modified
.dart_tool/package_config.json: pubspec.yaml pubspec.lock
	flutter pub get

## Updates the Podfile.lock when flutter packages have changed
ios/Podfile.lock: .dart_tool/package_config.json
	@rm -f ios/Podfile.lock || true
	cd ios && pod install --repo-update

## alias to $(GET_ALL)
get: $(GET_ALL)

## update all dependencies
upgrade:
	flutter pub upgrade
	$(MAKE) ios/Podfile.lock

## Cleans the repository by running flutter clean, followed by git clean
clean:
	flutter clean
	git clean -dfX $(GIT_CLEAN_EXCLUDES)

## Updates the githooks if the creation script was modified
.git/hooks/pre-commit: $(GET) tool/git_hooks.dart
	dart run tool/git_hooks.dart install

## alias to .git/hooks/pre-commit
hook-install: .git/hooks/pre-commit

## Remove git hooks
hook-uninstall: $(GET)
	dart run tool/git_hooks.dart uninstall

# code generation
## Update localizations
locales:
	flutter gen-l10n

## Run build_runner in build mode
generate: $(GET)
	flutter pub run build_runner build --delete-conflicting-outputs

## Run build_runner in watch mode
generate-watch: $(GET)
	flutter pub run build_runner watch

## Recreate the splashscreen files
splashscreen: $(GET)
	flutter pub run flutter_native_splash:create

# tests
## Run unit and regression tests
test: $(GET)
	flutter test --coverage
	@genhtml --no-function-coverage -o coverage/html coverage/lcov.info | tail -n 2

## Run unit and regression tests with logging enabled
test-logging: $(GET)
	flutter test --coverage --dart-define=test-logging=true
	@genhtml --no-function-coverage -o coverage/html coverage/lcov.info | tail -n 2

## Updates all golden files
update-goldens: $(GET)
	flutter test --update-goldens --tags=golden

## Run unit tests only
unit-test: $(GET)
	flutter test test/unit

## Run regression tests only
regression-test: $(GET)
	flutter test test/regression

## Run integration tests
integration-test: $(GET_ALL)
	flutter test integration_test

## Open coverage in browser
open-coverage:
	open coverage/html/index.html

# run
## Run the application
run: $(GET_ALL)
	flutter run
