import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/pages/Home/home_controller.dart';

class HomePage extends StatelessWidget {
HomeController con = Get.put(HomeController());

  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => con.singOut(),
          child: Text("Cerrar Sesion"),
        )
      ),
    );
  }
}
