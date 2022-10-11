import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Vucut(),
    );
  }
}

class _Vucut extends StatefulWidget {
  const _Vucut({Key? key}) : super(key: key);

  @override
  State<_Vucut> createState() => _VucutState();
}

class _VucutState extends State<_Vucut> {
  TextEditingController TamAd = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP POST İŞLEMİ"),
      ),
      body: _buildBody(),
    );

  }
  Widget _buildBody() {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Bosluk(),
                _buildImage(),
                _Bosluk(),
                _Bosluk(),
                _Bosluk(),
                _buildUsernameTextField(),
                _Bosluk(),
                _buildButton()
              ],
          ),
        ),
      );
  }

  Widget _Bosluk() {
    return SizedBox(
        height: 10,
    );
  }

  Widget _buildButton() {
    return ElevatedButton(onPressed: () async {
      final controller = Get.put(EklemeController());
      try{
        var response = await http.post(Uri.parse("https://mobiluygulama.adixi.net/"),
            body : {
              "yazi":controller.ad.text,
            }
        );
        print(response.body);
      }catch (e){
        print(e);
      }
    }, child: Text("ADINIZI KAYDEDİN"));
  }


  Widget _buildUsernameTextField(){
    final controller = Get.put(EklemeController());

    return Material(
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(200),
          bottomLeft: Radius.circular(200),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 2, 8, 2),
        child: TextField(
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "LÜTFEN ADINIZI GİRİNİZ",
          ),
         controller: controller.ad,
       //   controller: controller.usernameController,
        ),
      ),
    );
  }
  Widget _buildImage() {
    return
      Center(child: Image.network("https://play-lh.googleusercontent.com/PCpXdqvUWfCW1mXhH1Y_98yBpgsWxuTSTofy3NGMo9yBTATDyzVkqU580bfSln50bFU=w240-h480-rw"));
  }
}


class EklemeController extends GetxController {
  final  TextEditingController ad = TextEditingController();
}
