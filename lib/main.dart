import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';

late CameraDescription camera;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var x = await availableCameras();
  camera = x.first;
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 27,
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Savings",
          style: TextStyle(
            fontSize: 27,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).devicePixelRatio * 8,
                top: MediaQuery.of(context).devicePixelRatio * 5,
              ),
              child: Text(
                "Pay through UPI",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).devicePixelRatio * 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            payUpi(),
            belowPay(),
          ],
        ),
      ),
    );
  }

  // Text Form Field
  Widget payUpi() {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).devicePixelRatio * 12,
        top: MediaQuery.of(context).devicePixelRatio * 5,
        right: MediaQuery.of(context).devicePixelRatio * 12,
        bottom: MediaQuery.of(context).devicePixelRatio * 10,
      ),
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.purple),
          ),
          hintText: 'Enter UPI Number',
          hintStyle:
              TextStyle(fontSize: MediaQuery.of(context).devicePixelRatio * 8),
        ),
      ),
    );
  }

  Widget belowPay() {
    return Expanded(
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          Container(
            color: Colors.grey,
            child: TakePictureScreen(),
            // decoration: BoxDecoration(backgroundBlendMode: BlendMode.overlay, color: ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 7.5,
            left: MediaQuery.of(context).size.width / 4,
            right: MediaQuery.of(context).size.width / 4,
            bottom: MediaQuery.of(context).size.height / 2.5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: Colors.purple,
                  width: MediaQuery.of(context).devicePixelRatio * 1.5,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).devicePixelRatio * 100,
            // color: Colors.white,
            child: searchContact(),
            // color: Colors.red,
          )
        ],
      ),
    );
  }

  Widget searchContact() {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).devicePixelRatio * 8,
                  top: MediaQuery.of(context).devicePixelRatio * 8),
              child: Text(
                "Search Contact",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).devicePixelRatio * 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).devicePixelRatio * 10,
                top: MediaQuery.of(context).devicePixelRatio * 5,
                right: MediaQuery.of(context).devicePixelRatio * 10,
                bottom: MediaQuery.of(context).devicePixelRatio * 8,
              ),
              child: TextField(
                // keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.contacts_outlined,
                    color: Colors.purple,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  hintText: 'Select Number',
                  hintStyle: TextStyle(
                      fontSize: MediaQuery.of(context).devicePixelRatio * 8),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(1),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).devicePixelRatio * 8,
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://content.fakeface.rest/female_46_d9ba7704b9e60ce5d37993a0c10d3c7f7beba508.jpg',
                        width: 50.0,
                        height: 50.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).devicePixelRatio * 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).devicePixelRatio * 2),
                          child: Text(
                            "Sumanth Varma",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize:
                                    MediaQuery.of(context).devicePixelRatio *
                                        8),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.zero,
                          child: Text("753000908"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Camera Implementation

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  void tempCamera() async {
    var x = await availableCameras();
    camera = x.first;
  }

  @override
  void initState() {
    tempCamera();
    super.initState();

    _controller = CameraController(
      // widget.camera,
      camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(
              _controller,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
