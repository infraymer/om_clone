package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    ShimPluginRegistry shimPluginRegistry = new ShimPluginRegistry(flutterEngine);
    flutterEngine.getPlugins().add(new io.flutter.plugins.firebaseauth.FirebaseAuthPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.core.FirebaseCorePlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.crashlytics.firebasecrashlytics.FirebaseCrashlyticsPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.database.FirebaseDatabasePlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.storage.FirebaseStoragePlugin());
      io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin.registerWith(shimPluginRegistry.registrarFor("io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin"));
      com.example.flutter_sim_country_code.FlutterSimCountryCodePlugin.registerWith(shimPluginRegistry.registrarFor("com.example.flutter_sim_country_code.FlutterSimCountryCodePlugin"));
    flutterEngine.getPlugins().add(new io.flutter.plugins.imagepicker.ImagePickerPlugin());
    flutterEngine.getPlugins().add(new com.lyokone.location.LocationPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.pathprovider.PathProviderPlugin());
    flutterEngine.getPlugins().add(new io.flutter.plugins.share.SharePlugin());
  }
}
