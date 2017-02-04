#!/bin/sh

echo "srcroot=${SRCROOT}"
echo "project_dir=${PROJECT_DIR}"
echo "build_dir=${BUILD_DIR}"
echo "configuration=${CONFIGURATION}"
echo "project_file_path=${PROJECT_FILE_PATH}"
echo "target_name=${TARGET_NAME}"
echo "objroot=${OBJROOT}"
echo "sysroot=${SYMROOT}"

set -e

set +u
if [[ ${UF_MASTER_SCRIPT_RUNNING} ]]; then
	exit 0
fi
set -u

export UF_MASTER_SCRIPT_RUNNING=1

FRAMEWORK_VERSION="A"
BUILD_UNIVERSAL_DIR=${BUILD_DIR}/${CONFIGURATION}-universal
BUILD_IPHONEOS_DIR=${BUILD_DIR}/${CONFIGURATION}-iphoneos
BUILD_SIMULATOR_DIR=${BUILD_DIR}/${CONFIGURATION}-iphonesimulator

### Take build target.
if [[ "$SDK_NAME" =~ ([A-Za-z]+) ]];
	then
	SF_SDK_PLATFORM=${BASH_REMATCH[1]} # "iphoneos" or "iphonesimulator".
	else
		echo "Could not find platform name from SDK_NAME: $SDK_NAME"
		exit 1
fi

echo "===== Build Simulator Platform: i386 ====="
xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${BUILD_SIMULATOR_DIR}/i386" SYMROOT="${SYMROOT}" ARCHS='i386' VALID_ARCHS='i386' $ACTION

echo "===== Build Simulator Platform: x86_64 ====="
xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${BUILD_SIMULATOR_DIR}/x86_64" SYMROOT="${SYMROOT}" ARCHS='x86_64' VALID_ARCHS='x86_64' $ACTION

echo "===== Build Device Platform: armv7 ====="
xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphoneos BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}"  CONFIGURATION_BUILD_DIR="${BUILD_IPHONEOS_DIR}/armv7" SYMROOT="${SYMROOT}" ARCHS='armv7 armv7s' VALID_ARCHS='armv7 armv7s' $ACTION

echo "===== Build Device Platform: arm64 ====="
xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}" -configuration "${CONFIGURATION}" -sdk iphoneos BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}" CONFIGURATION_BUILD_DIR="${BUILD_IPHONEOS_DIR}/arm64" SYMROOT="${SYMROOT}" ARCHS='arm64' VALID_ARCHS='arm64' $ACTION

echo "========== Build Universal Platform =========="
## Copy the framework structure to the universal folder (clean it first).

if [[ -d ${BUILD_UNIVERSAL_DIR} ]]; then
	rm -rf "${BUILD_UNIVERSAL_DIR}"
fi

mkdir -p "${BUILD_UNIVERSAL_DIR}"

## Copy the last product files of xcodebuild command.
cp -R "${BUILD_IPHONEOS_DIR}/arm64/${PROJECT_NAME}.framework" "${BUILD_UNIVERSAL_DIR}/${PROJECT_NAME}.framework"
### Smash them together to combine all architectures.
lipo -create "${BUILD_SIMULATOR_DIR}/i386/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_SIMULATOR_DIR}/x86_64/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_IPHONEOS_DIR}/armv7/${PROJECT_NAME}.framework/${PROJECT_NAME}" "${BUILD_IPHONEOS_DIR}/arm64/${PROJECT_NAME}.framework/${PROJECT_NAME}" -output "${BUILD_UNIVERSAL_DIR}/${PROJECT_NAME}.framework/${PROJECT_NAME}"
