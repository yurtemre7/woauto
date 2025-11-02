import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keyProperties = Properties().apply {
    // load your *.properties file
    load(FileInputStream(file("key.properties")))
}

val localProperties = Properties().apply {
    // load your *.properties file
    load(FileInputStream(file("local.properties")))
}

var mapsApiKey = localProperties.getProperty("MAPS_API_KEY")
if (mapsApiKey == null) {
    mapsApiKey = ""
    project.logger.error("Google Maps Api Key not configured. Set it in `local.properties`")
}

android {
    namespace = "de.emredev.woauto"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion
    // ndkVersion = "27.0.12077973"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }


    defaultConfig {
        manifestPlaceholders["MAPS_API_KEY"] = mapsApiKey
        applicationId = "de.emredev.woauto"
        // You can update the following values to match your application needs.
        // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-build-configuration.
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keyProperties.getProperty("keyAlias")
            keyPassword = keyProperties.getProperty("keyPassword")
            storeFile = file(keyProperties.getProperty("storeFile"))
            storePassword = keyProperties.getProperty("storePassword")
        }
    }

     buildTypes {
        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")
        }
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
        }
    }
    
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("androidx.window:window:1.0.0")
    implementation("androidx.window:window-java:1.0.0")
}
