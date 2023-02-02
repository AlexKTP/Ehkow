import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flash Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 1),
            Expanded(flex: 8, child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(child: IconButton(onPressed: () => {
                    debugPrint("Go To left!"),
                  }, icon:Icon(Icons.keyboard_double_arrow_left, color: Colors.black26),
                  )
                  ),
                ),
                Expanded(
                  flex: 6, // 60%
                  child: Container(constraints: BoxConstraints.expand() , color: Colors.green, alignment: Alignment.center, child: Text("test"),),
                ),
                Expanded(
                  flex: 2,
                  child: Container(child: IconButton(onPressed: () => {
                    debugPrint("Go To right!"),
                  }, icon:Icon(Icons.keyboard_double_arrow_right, color: Colors.black26),
                  )
                  ),
                )
              ],
            ),
            ),
            Expanded(flex: 2, child: TextButton(onPressed: () => {
              debugPrint("Logged!"),
            }, child: Text("Button"),),)

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
