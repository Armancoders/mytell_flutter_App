# MyTell

Voip flutter project.

## Clone new version
    android :
        change the folowing ids :
        1. android/app/build.gradle  in android bloc change namespace
        2. android/app/build.gradle  in defaultConfig bloc change applicationId
        3. android/app/src/main/kotlin/com/armancoders/mytell/MainActivity.kt  change package name in first line
        4. android/app/src/main/AndroidManifest.xml  in application tag change android:label
    
    ios :
        open xcode and on TARGETS section click on Runner. Then in "Signign & Capabilities" tab change "Bundle Identifier"
    
    change ui per clone:
        1. add new images to assets folder
        2. change primary color in lib/src/core/theme/color_theme.dart
        3. change current logo in splash(by specifie the name of new image which you added to assets) by change the path on image in lib/src/modules/splash.dart
        4. change current app name in splash lib/src/modules/splash.dart
        5. change app name and image in onboarding screen(just like previous one you done in splash) in lib/src/modules/OnBoarding/widgets.dart
        6. change image in login screen lib/src/modules/Login/widgets.dart


After all delete the folowing paths :
    1. build folder
    2. mytell.jks

Then rerun build proccess.

## Update an existing version
    on the pubspec.yaml file and change version.
    
    note : you need to specifie new version every time on googleplay and appstore when you upload new version.
