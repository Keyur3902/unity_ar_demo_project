import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_unity/flutter_unity.dart';

class ViewInUnity extends StatefulWidget {
  final String modelName;

  const ViewInUnity({super.key, required this.modelName});

  @override
  State<ViewInUnity> createState() => _ViewInUnityState();
}

class _ViewInUnityState extends State<ViewInUnity> {
  UnityViewController? unityViewController;
  bool isLoading = true;

  @override
  void deactivate() {
    if (Platform.isAndroid) unityViewController?.reset();
    print("deactivated call");
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _goBack();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: isLoading
          ? UnityView(
              onCreated: onUnityCreated,
              onMessage: onUnityMessage,
              onReattached: onUnityViewReattached,
            )
          : const CircularProgressIndicator(),
    );
  }

  void onUnityCreated(UnityViewController? controller) {
    unityViewController = controller;
    _reportID();
    unityViewController?.send(
      'XR Origin (XR Rig)',
      'ChangeModel',
      widget.modelName,
    );
  }

  void onUnityMessage(_, message) {
    final data = jsonDecode(message);
    switch (data['subject']) {
      case 'boot_scene_loaded':
        Navigator.of(context).pop();
        break;
    }
  }

  void _goBack() {
    unityViewController?.send(
      'XR Origin (XR Rig)',
      'LoadBootScene',
      '',
    );
    Navigator.of(context).pop();
  }

  void _reportID() {
    unityViewController?.send(
      'FlutterMessanger',
      'GetViewID',
      '',
    );
  }

  void onUnityViewReattached(UnityViewController controller) {
    unityViewController = controller;
    unityViewController?.send(
      'XR Origin (XR Rig)',
      'ChangeModel',
      widget.modelName,
    );
  }
}
