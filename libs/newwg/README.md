# FLUTTER AAR LIBRARY

A new Flutter module project.

### Getting Started

- clone this project
- run `fluter pub get`
- build AAR `flutter build aar`

### SETUP EXISTING PROJECT ANDROID

- setup `build.gradle` file at `app` level

```groovy
android {
    namespace 'com.example.consumeaar'
    compileSdk 33

    defaultConfig {
        applicationId "com.example.consumeaar"
        minSdk 22
        targetSdk 33
        versionCode 1
        versionName "1.0"

        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
    }
    // ...
}

String storageUrl = System.env.FLUTTER_STORAGE_BASE_URL ?: "https://storage.googleapis.com"
repositories {
    maven {
        url '/Users/asani/IhsanBagus/Projects/Flutter/new_wg/build/host/outputs/repo'
    }
    maven {
        url "$storageUrl/download.flutter.io"
    }
    google()
    mavenCentral()
}

dependencies {
    // ...
    debugImplementation 'com.example.new_wg:flutter_debug:1.0'
    profileImplementation 'com.example.new_wg:flutter_profile:1.0'
    releaseImplementation 'com.example.new_wg:flutter_release:1.0'
}
```

### ADD TO SCREEN

- Add the following XML to your `AndroidManifest.xml` file under your application tag:

```manifest
<activity
  android:name="io.flutter.embedding.android.FlutterActivity"
  android:theme="@style/LaunchTheme"
  android:configChanges="orientation|keyboardHidden|keyboard|screenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
  android:hardwareAccelerated="true"
  android:windowSoftInputMode="adjustResize"
  />
```

- MainActivity.kt sample code

```kotlin
package com.example.consumeaar

import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterActivity


class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val flutter: Button = findViewById(R.id.flutter)
        flutter.setOnClickListener {
            startActivity(FlutterActivity.createDefaultIntent(this))
        }
    }
}
```

- MainActivity.xml layout file

```xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools" android:layout_width="match_parent"
    android:layout_height="match_parent" tools:context=".MainActivity">

    <Button android:id="@+id/flutter" android:layout_width="wrap_content"
        android:layout_height="wrap_content" android:text="Hello World!"
        android:background="@color/purple_700" app:layout_constraintBottom_toBottomOf="parent"
        app:layout_constraintEnd_toEndOf="parent" app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintTop_toTopOf="parent" />

</androidx.constraintlayout.widget.ConstraintLayout>
```

- SecondActivity.kt sample code

```kotlin
package com.example.consumeaar

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

const val FLUTTER_ENGINE_ID = "flutter_engine"
const val CHANNEL = "deasy.newwg"

class FlutterXActivity : AppCompatActivity() {
    private lateinit var flutterEngine: FlutterEngine
    private lateinit var channel: MethodChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        flutterEngine = FlutterEngine(this)
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        channel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        )
        appConfig()
        FlutterEngineCache
            .getInstance()
            .put(FLUTTER_ENGINE_ID, flutterEngine)
        startActivity(FlutterActivity.withCachedEngine(FLUTTER_ENGINE_ID).build(this))
        finish()
    }

    private fun appConfig() {
        val maap = mapOf(
            "app_config" to mapOf(
                "statusBarColor" to "#3700B3",
                "appBarColor" to "#FFFFFF",
                "buttonPrimaryColor" to "#F46363"
            ),
            "auth_config" to mapOf("appSource" to "SALLY"),
            "network_config" to mapOf("baseUrl" to "https://google.com")
        )
        channel.invokeMethod(
            "base_config",
            maap
        )
    }
}
```

### AVAILABLE PARAMETER
* libs/newwg/lib/config/app_config.dart

```dart
appBarColor
statusBarColor
buttonPrimaryColor
buttonTextPrimaryColor
buttonSecondaryColor
buttonTextSecondaryColor
textButtonOutlineTextColor
textButtonTextColor
iconButtonColor
iconButtonTextColor
iconButtonActiveColor
iconButtonUnactiveTextColor
stepperActiveColor
stepperUnactiveColor
formTitleColor
```

* libs/newwg/lib/config/app_config.dart

```dart
authentication
appSource
deviceId
orderId
```
* libs/newwg/lib/config/network_config.dart

```dart
baseUrl
secretKey
apiKey
```

For more information,
see the [add-to-app documentation](https://flutter.dev/docs/development/add-to-app).
