# codornices

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

metodo apra eliminar 

 onPressed: () async {
                      var codornisTemporal = listaCodornices![index].id!;
                      var response = await DBAVIPRO
                          .eliminarcodornis(listaCodornices![index].id!);
                      if (response == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Fallo al eliminar el elemento')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Eliminado correctamente')));
                        listaCodornices!.remove(codornisTemporal);
                      }
                      print('eliminando ${listaCodornices![index]}');
                      setState(() {});
                    },


                    CONFIGURACIONES PARA EL MANISFEST DE OTROS PROYECTOS

                    def localProperties = new Properties()
def localPropertiesFile = rootProject.file('local.properties')
if (localPropertiesFile.exists()) {
    localPropertiesFile.withReader('UTF-8') { reader ->
        localProperties.load(reader)
    }
}

def flutterRoot = localProperties.getProperty('flutter.sdk')
if (flutterRoot == null) {
    throw new GradleException("Flutter SDK not found. Define location with flutter.sdk in the local.properties file.")
}

def flutterVersionCode = localProperties.getProperty('flutter.versionCode')
if (flutterVersionCode == null) {
    flutterVersionCode = '1'
}

def flutterVersionName = localProperties.getProperty('flutter.versionName')
if (flutterVersionName == null) {
    flutterVersionName = '1.0'
}

apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply from: "$flutterRoot/packages/flutter_tools/gradle/flutter.gradle"

   def keystoreProperties = new Properties()
   def keystorePropertiesFile = rootProject.file('key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   }

android {
    compileSdkVersion 30

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = '1.8'
    }

    sourceSets {
        main.java.srcDirs += 'src/main/kotlin'
    }
//configuración por defecto que se cogera para  la generación de mi apk-abb
    defaultConfig {
        manifestPlaceholders = [hostName:"www.example.com"]
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "com.deditec.avipro"
        minSdkVersion 16
        targetSdkVersion 30
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
//con que se firma mi aplicación dependiendo de si esta en release debug etc...
    signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
           storePassword keystoreProperties['storePassword']
       }
   }
//tipos....variantes de compilación específicos
    debug {
                applicationIdSuffix ".debug"
                debuggable true
                //SUPUESTO EJEMPLO PARA ACCEDER A ESTOS DATOS DESDE CODIGO APP...
                buildConfigField("String", "BUILD_TIME", "\"0\"")
                resValue("string", "build_time", "0")
   }
    /**
         * The `initWith` property allows you to copy configurations from other build types,
         * then configure only the settings you want to change. This one copies the debug build
         * type, and then changes the manifest placeholder and application ID.
         */
    staging {
            initWith debug
            manifestPlaceholders = [hostName:"internal.example.com"]
            applicationIdSuffix ".debugStaging"
   }
//estos son los tipos de que tengo a la hora de producir mi app en debug o release
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
        }

         debug{
            signingConfig signingConfigs.debug

         }
    }
//esto me sirve para crear apk en modo de produccion cada uno con un id.. diferente
//variantes de productos
    flavorDimensions "mode", "api" //dimensiones de variantes
    productFlavors {

        demo {
            // Assigns this product flavor to the "version" flavor dimension.
            // If you are using only one dimension, this property is optional,
            // and the plugin automatically assigns all the module's flavors to
            // that dimension.
            dimension "mode"
            applicationIdSuffix ".demo"
            versionNameSuffix "-demo"
        }
        full {
            dimension "mode"
            applicationIdSuffix ".full"
            versionNameSuffix "-full"
        }

        minApi24 {
            dimension "api"
            minSdkVersion 24
            // To ensure the target device receives the version of the app with
            // the highest compatible API level, assign version codes in increasing
            // value with API level. To learn more about assigning version codes to
            // support app updates and uploading to Google Play, read Multiple APK Support
            versionCode 30000 + android.defaultConfig.versionCode
            versionNameSuffix "-minApi24"
            }

        minApi23 {
            dimension "api"
            minSdkVersion 23
            versionCode 20000  + android.defaultConfig.versionCode
            versionNameSuffix "-minApi23"
            ...
            }

        minApi21 {
            dimension "api"
            minSdkVersion 21
            versionCode 10000  + android.defaultConfig.versionCode
            versionNameSuffix "-minApi21"
            }

    }
//esto me sirve para ignorar algunos tipos de variantes en la compilación de mi proyecto....
    variantFilter { variant ->
      def names = variant.flavors*.name
      // To check for a certain build type, use variant.buildType.name == "<buildType>"
      if (names.contains("minApi21") && names.contains("demo")) {
          // Gradle ignores any variants that satisfy the conditions above.
          setIgnore(true)
      }
    }
}

flutter {
    source '../..'
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
}


------------ejecutar variables de entorno en flutter ------------------

0

Para ejecutar su aplicación (en flutter run)
flutter run --dart-define=EXAMPLE_API_ENDPOINT=https://api.example.com/
Para lanzar su aplicación (en flutter build)
Mi aplicación no permitía que los usuarios iniciaran sesión. Me di cuenta de que las variables de entorno eran cadenas vacías en la aplicación, en lugar de sus valores reales 😅.

iOS: flutter build ipa --dart-define=EXAMPLE_API_ENDPOINT=https://api.example.com/
Androide: flutter build apk --dart-define=EXAMPLE_API_ENDPOINT=https://api.example.com/
--dart-define documentación
Desde el flutter run --helpo flutter build ipa --help, los --dart-defineespectáculos:

Additional key-value pairs that will be available as 
constants from the String.fromEnvironment, bool.fromEnvironment, 
int.fromEnvironment, and double.fromEnvironment constructors. 
Multiple defines can be passed by repeating "--dart-define" 
multiple times.

//DOCUMENTOS Y PAGINAS A VISITAR PARA ESTAR INFORMADO
https://flutterigniter.com/env-specific-configuration/
https://binary-studio.com/2020/04/17/flutter-2/
https://efthymis.com/use-environment-variables-in-ci-cd-for-flutter-apps/
https://medium.com/litslink/flutter-using-environment-variables-24a976ae1335
https://dartcode.org/docs/using-dart-define-in-flutter/

flutter web
https://dev.to/janux_de/configure-flutter-web-apps-121c


DOCUMENTO A VER ANDROID STUDIO
https://developer.android.com/studio/build?hl=es-419