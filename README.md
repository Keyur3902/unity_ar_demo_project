# Flutter View in AR

This project integrates a Unity AR model into a Flutter application using the flutter_unity plugin. The objective is to visualize a 3D model in the real world using Augmented Reality (AR) capabilities provided by Unity.

## Installation
Just Export the unityExport folder provided in the link below under the android folder of your project.

[Unity Export Link](https://drive.google.com/drive/folders/1dQXHs69KQoyN7ZodJJw_Zf8K4nMaQP_i?usp=sharing)

After adding this to your project run the below command in your terminal

```
flutter pub run flutter_unity:unity_export_transmogrify
```
Include code inside <your_flutter_project>/android/unityExport/build.gradle
```
buildTypes {
    profile {}
}
```

## Additional Resource

[Flutter unity package](https://pub.dev/packages/flutter_unity)

