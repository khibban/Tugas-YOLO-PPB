plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.yolodetector.yolo_detector"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.yolodetector.yolo_detector"
        // Minimum SDK 24 = Android 7.0 (covers 99%+ of devices in use)
        // ultralytics_yolo requires at least SDK 21, we use 24 for better support
        minSdk = 24
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    // Prevents the .tflite model file from being compressed during build.
    // This is required so the model can be memory-mapped efficiently at runtime.
    aaptOptions {
        noCompress += listOf("tflite")
    }
}

flutter {
    source = "../.."
}
