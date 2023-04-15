#!/usr/bin/env bash

# Copied and adapted from https://gist.github.com/mmcc007/7a3b6e0daeeafb2b9126bd69ebd501d2

# remember some failed commands and report on exit
error=false

show_help() {
  printf "usage: $0 [--help] [--test] [--test-changed] [--analyze] [--report] [--clean] [--get] [--buildAndroid] [--buildIOS] [--translate] [--storybook-build]

Tool for running useful commands on all Micro Apps.

where:
    --test
        Run tests on all micro apps.
        Requires code_coverage package (install with 'pub global activate coverage')
    --test-changed
        Run testes on all changed directories
    --analyze
        Run flutter analyze on all micro apps
    --clean
        Run flutter clean on all micro apps
    --get
        Run flutter packages get on all micro apps
    --buildAndroid
        Build flutter Android base app
    --buildIOS
        Build flutter iOS base app
    --runner
        Run flutter packages pub run build_runner build with delete conflicting param on all micro apps
    --report
        Run coverage report and merge the result on one report (requires lcov installed)
    --translate
        Generate translations with release mode
    --storybook-build
        Run storybook build for web with release mode
    --help
        Print this message
"
  exit 1
}

# run unit and widget tests
runTests() {
  cd "$1" || exit

  if [ -f "pubspec.yaml" ] && [ -d "test" ]; then
    echo "running tests in $1"
    # flutter packages get > /dev/null

    # check if build_runner needs to be run
    # if grep build_runner pubspec.yaml > /dev/null ; then
    #   flutter packages pub run build_runner build --delete-conflicting-outputs
    # fi

    # run tests with coverage
    if grep flutter pubspec.yaml >/dev/null; then
      if [ "$3" == true ]; then
        flutter test || error=true
      else
        escapedPath="$(echo $1 | sed 's/\//\\\//g')"

        flutter test --coverage || error=true

        # Stop execution on errors
        if [ "$error" = true ]; then
          exit -1
        fi

        if [ -d "coverage" ]; then
          if ! [ -d "$2/.coverage" ]; then
            mkdir $2/.coverage/
          fi
          flutter test --machine > test-results.json
          # combine line coverage info from package tests to a common file
          sed "s/^SF:lib/SF:$escapedPath\/lib/g" coverage/lcov.info >>$2/.coverage/lcov.info
          rm -rf "coverage"
        fi
      fi
    fi
  fi

  cd - >/dev/null
}

# run flutter analyze
runAnalyze() {
  cd $1

  if [ -f "pubspec.yaml" ]; then
    echo "running analyze in $1"
    flutter analyze || error=true
  fi

  cd - >/dev/null
}

runReport() {
  if [ -f ".coverage/lcov.info" ]; then
    lcov --remove .coverage/lcov.info '**/*.g.dart' -o .coverage/lcov.info
    genhtml .coverage/lcov.info -o .coverage/merged --no-function-coverage -s -p $(pwd)
    if [[ "$OSTYPE" == "msys" ]]; then
      start "" ".coverage/merged/index.html"
    else
      open .coverage/merged/index.html
    fi
  else
    echo "No lcov.info found. Run --test first!"
  fi
}

runClean() {
  cd "$1" || exit

  if [ -f "pubspec.yaml" ]; then
    echo "Cleaning $1"
    rm pubspec.lock
    flutter clean >/dev/null
  fi

  cd - >/dev/null || exit
}

runGet() {
  cd "$1" || exit

  if [ -f "pubspec.yaml" ]; then
    flutter pub get
  fi

  cd - > /dev/null
}

runTranslate() {
  cd $1 || exit;

  if [ -f "pubspec.yaml" ]; then
    echo "Generating translations $1..."
    flutter gen-l10n --arb-dir=lib/core/l10n/ --template-arb-file=intl_pt.arb --output-localization-file=translations.dart --output-class=Tr --output-dir=lib/l10n --no-synthetic-package
  fi

  cd - > /dev/null

}

runBuildAndroid() {
  cd base_app || exit;

  if [ -f "pubspec.yaml" ]; then
    flutter pub run ../tools/generate_envs.dart
    if [[ "$1" = "prod" ]]; then
      echo "Building prod..."
      flutter build apk --release --flavor prod -t lib/main_prod.dart
    fi
    if [[ $1 = "hml" ]]; then
      echo "Building hml..."
      flutter build apk --release --flavor hml -t lib/main_hml.dart
    fi
    if [[ $1 = "dev" ]]; then
      echo "Building dev..."
      flutter build apk --release --flavor dev -t lib/main_dev.dart
    fi
  fi

  cd - > /dev/null

}

runBuildIOS() {
  cd base_app || exit;

  if [ -f "pubspec.yaml" ]; then
    flutter pub run ../tools/generate_envs.dart
    if [[ "$1" = "prod" ]]; then
      echo "Building prod..."
      flutter build ios --release --flavor prod -t lib/main_prod.dart
    fi
    if [[ $1 = "hml" ]]; then
      echo "Building hml..."
      flutter build ios --release --flavor hml -t lib/main_hml.dart
    fi
    if [[ $1 = "dev" ]]; then
      echo "Building dev..."
      flutter build ios --release --flavor dev -t lib/main_dev.dart
    fi
  fi

  cd - > /dev/null

}

runBuildRunner() {
  cd $1

  if [ -f "pubspec.yaml" ]; then
    if grep -q "build_runner" "pubspec.yaml"; then
      flutter packages pub run build_runner build --delete-conflicting-outputs
    fi
  fi

  cd - > /dev/null
}

runStorybookBuild() {
  cd '../core' || exit
  flutter packages get

  cd "../storybook" || exit

  flutter clean

  flutter packages get

  flutter build web --release || error=true

  if [ "$error" = true ]; then
    echo "💥 Build finished with errors!"
  else
    echo "✅ Build finished successfully"
  fi
}

if ! [ -d .git ]; then
  printf "\nError: not in root of repo"
  show_help
fi

case $1 in
--help)
  show_help
  ;;
--clean)
  rm -rf ".coverage"
  # exclude hidden
  dirs=($(find . -not -path '*/\.*' -not -path '*/storybook' -maxdepth 1 -type d))
  for dir in "${dirs[@]}"; do
    runClean "$dir"
  done
  ;;
--get)
  # exclude hidden
  dirs=($(find . -not -path '*/\.*' -not -path '*/storybook' -maxdepth 1 -type d))
  for dir in "${dirs[@]}"; do
    runGet "$dir"
  done
  ;;
--buildAndroid)
  runBuildAndroid $2
  ;;
--buildIOS)
  runBuildIOS $2
  ;;
--translate)
  runTranslate
  ;;
--runner)
  # exclude hidden
  dirs=($(find . -not -path '*/\.*' -not -path '*/storybook' -maxdepth 1 -type d))
  for dir in "${dirs[@]}"; do
    runGet $dir
    runBuildRunner $dir
  done
  ;;
--report)
  runReport
  ;;
--test)
  currentDir=$(pwd)
  rm -rf ".coverage"

  dirs=($(find . -not -path '*/\.*' -not -path '*/storybook' -maxdepth 2 -type d))
  for dir in "${dirs[@]}"; do
    runTests "$dir" "$currentDir"
  done
  ;;
--analyze)
  currentDir=$(pwd)

  dirs=($(find . -not -path '*/\.*' -not -path '*/storybook' -maxdepth 2 -type d))
  for dir in "${dirs[@]}"; do
    runAnalyze $dir $currentDir
  done
  ;;
--test-changed)
  currentDir=$(pwd)
  changed=false

  dirs=($(find . -not -path '*/\.*' -not -path '*/storybook' -maxdepth 2 -type d))
  for dir in "${dirs[@]}"; do
    result=$(git diff --quiet HEAD -- $dir || echo "changed")

    if [ "$result" == "changed" ]; then
      cd "$dir" || exit

      if [ -f "pubspec.yaml" ] && [ -d "test" ]; then
        cd "$currentDir" || exit

        changed=true
        runTests "$dir" "$currentDir" true
      fi

      cd "$currentDir" || exit
    fi
  done

  if [ "$changed" == false ]; then
    echo "Nothing to test!"
  fi
  ;;
--storybook-build)
  runStorybookBuild
  ;;
*)
  show_help
  ;;
esac

# Fail the build if there was an error
if [ "$error" = true ]; then
  exit -1
fi
