import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late StateMachineController? stateMachineController;
  var animationLink = "assets/login.riv";
  late SMITrigger failTrigger, SuccessTrigger;
  late SMIBool lookBool, closeBool;
  Artboard? artboard;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initArtBoard();
  }

  initArtBoard() {
    print("init");
    rootBundle.load(animationLink).then((value) {
      final file = RiveFile.import(value);
      print("file${file}");
      final art = file.mainArtboard;
      print("file${art}");
      stateMachineController =
          StateMachineController.fromArtboard(art, "Login Machine")!;
      if (stateMachineController != null) {
        print("not null");
        art.addController(stateMachineController!);
        for (var element in stateMachineController!.inputs) {
          print("for loop");
          print(element.name);
        }
      }
      setState(() {
        artboard = art;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd6e2ea),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          artboard != null
              ? SizedBox(
                  width: 400,
                  height: 300,
                  child: Rive(artboard: artboard!),
                )
              : SizedBox(),
          Container(
            width: 400,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(25),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffd6e2ea),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: "Email",
                      fillColor: const Color(0xffd6e2ea),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(width: 2, color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffd6e2ea),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: "Password",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(width: 2, color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(width: 2, color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (value) {},
                        ),
                        const Text("Remember Me"),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
