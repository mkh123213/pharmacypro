plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.pharmacypro"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    flavorDimensions += "default"
    productFlavors {
        create("Development") {
            dimension = "default"
            applicationIdSuffix = ".dev"
            resValue("string", "app_name", "PharmaChain Dev")
        }
        create("Staging") {
            dimension = "default"
            applicationIdSuffix = ".staging"
            resValue("string", "app_name", "PharmaChain Staging")
        }
        create("Production") {
            dimension = "default"
            resValue("string", "app_name", "PharmaChain")
        }
    }

    defaultConfig {
        applicationId = "com.example.pharmacypro"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
