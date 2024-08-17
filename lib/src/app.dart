import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_max_ject/src/controller/disa_map.dart';

class App extends GetView<Disa_map> {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("옥외 대피소"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Obx((){
          var info = controller.disaStatistic.value;
          return Column(
            children: [
              Row(children: [
                Text("기준일", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(" : ${info.ycord}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              ],)
            ],
          );
        }),
      ),
    );
  }
}
