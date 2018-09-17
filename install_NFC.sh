#!/bin/bash
echo
echo "+++ Installing NXP-NCI NFC support for PN7150 +++"

echo
echo "- removing existing implementation"
rm -rf $ANDROID_BUILD_TOP/frameworks/base/core/java/android/nfc/*
rm -rf $ANDROID_BUILD_TOP/system/nfc/* $ANDROID_BUILD_TOP/system/nfc/.git
rm -rf $ANDROID_BUILD_TOP/packages/apps/Nfc/* $ANDROID_BUILD_TOP/packages/apps/Nfc/.git

echo
echo "- copying required files"
cp -r $ANDROID_BUILD_TOP/NxpNfcAndroid/NfcAndroid_Base/core/java/android/nfc $ANDROID_BUILD_TOP/frameworks/base/core/java/android/
cp -r $ANDROID_BUILD_TOP/NxpNfcAndroid/NfcAndroid_Vendor/* $ANDROID_BUILD_TOP/
cp -r $ANDROID_BUILD_TOP/NxpNfcAndroid/NfcAndroid_libnfcNci/* $ANDROID_BUILD_TOP/system/nfc/
cp -r $ANDROID_BUILD_TOP/NxpNfcAndroid/NfcAndroid_libnfcNci/.git $ANDROID_BUILD_TOP/system/nfc/
cp -r $ANDROID_BUILD_TOP/NxpNfcAndroid/NfcAndroid_Nfc/* $ANDROID_BUILD_TOP/packages/apps/Nfc/
cp -r $ANDROID_BUILD_TOP/NxpNfcAndroid/NfcAndroid_Nfc/.git $ANDROID_BUILD_TOP/packages/apps/Nfc/

echo
echo "- removing temporary retrieved files"
rm -rf $ANDROID_BUILD_TOP/NxpNfcAndroid/NfcAndroid_Base
rm -rf $ANDROID_BUILD_TOP/NxpNfcAndroid/NfcAndroid_Vendor
rm -rf $ANDROID_BUILD_TOP/NxpNfcAndroid/NfcAndroid_libnfcNci
rm -rf $ANDROID_BUILD_TOP/NxpNfcAndroid/NfcAndroid_Nfc

echo
echo "- patching required files"
cd $ANDROID_BUILD_TOP/build
patch -p1 <$ANDROID_BUILD_TOP/NxpNfcAndroid/patch_build.txt
cd $ANDROID_BUILD_TOP/frameworks/base
patch -p1 <$ANDROID_BUILD_TOP/NxpNfcAndroid/patch_frameworks_base.txt
cd $ANDROID_BUILD_TOP/system/sepolicy
patch -p1 <$ANDROID_BUILD_TOP/NxpNfcAndroid/patch_system_sepolicy.txt
cd $ANDROID_BUILD_TOP/packages/apps/Nfc
patch -p1 <$ANDROID_BUILD_TOP/NxpNfcAndroid/patch_packages_apps_nfc.txt
cd $ANDROID_BUILD_TOP/system/nfc
patch -p1 <$ANDROID_BUILD_TOP/NxpNfcAndroid/patch_system_nfc.txt
cd $ANDROID_BUILD_TOP

echo
echo "+++ NXP-NCI NFC support installation completed +++"
exit 0

