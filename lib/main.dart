import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unity_ar_demo_project/view_in_unity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> models = [
    'Model1',
    'Model2',
    'Model3',
    'Model4',
    'Model5',
    'Model6',
    'Model7',
    'Model8',
    'Model9',
    'Model10'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unity AR Demo"),
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: models.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Image(
                  image: AssetImage("assets/Image1.png"),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var status = await Permission.camera.status;
                  if (status.isDenied) {
                    await Permission.camera.request();
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ViewInUnity(
                        modelName: models[index],
                      ),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(AssetImage("assets/unity_icon.png")),
                    SizedBox(
                      width: 5,
                    ),
                    Text("View in AR"),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
