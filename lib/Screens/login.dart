import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:login_using_hive/Screens/register.dart';
import 'package:login_using_hive/model/usermodel.dart';

import '../database/database.dart';
import 'Home.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.openBox<User>('user');



  runApp(
      GetMaterialApp(debugShowCheckedModeBanner: false,
    home: Login_Hive(),));
}

class Login_Hive extends StatelessWidget {
  Login_Hive({super.key});

  final email1 = TextEditingController();
  final paswrd1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body:
      Padding(
        padding: const EdgeInsets.only(top: 180, left: 20, right: 20),
        child: Column(
          children: [
            Icon(Icons.lock, size: 50,),
            SizedBox(height: 50,),
            TextField(
              controller: email1,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),),
              ),
            ),
            SizedBox(height: 12,),
            TextField(
              controller: paswrd1,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),),
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: () async {
              final userList = await DBFunction.instance.getUser();
              findUser(userList);
            }, child: Text("Login"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  minimumSize: Size(370, 70)),
            ),
            SizedBox(height: 50,),
            Row(
              children: [
                SizedBox(width: 40,),
                Text("Create an account!",),
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Register_Hive()));
                }, child: Text("Register")),
              ],
            )
          ],
        ),
      ),

    );
  }

  Future<void> findUser(List<User> userlist) async {
    final email = email1.text.trim();
    final password = paswrd1.text.trim();

    bool userFound = false;
    final validate = await validatelogin(email, password);


    if (validate == true) {
      await Future.forEach(userlist, (user) {
        if (user.email == email && user.password == password) {
          userFound = true;
        } else {
          userFound = false;
        }
      });
      if (userFound == true) {
        Get.offAll(() => Homehive(email: email));
        Get.snackbar("Success", "Login success", backgroundColor: Colors.green);
      } else {
        Get.snackbar(
            "Error", "Incorrect email/password", backgroundColor: Colors.red);
      }
    }
  }

  Future<bool> validatelogin(String email, String password) async {
    if (email != "" && password != "") {
      return true;
    } else {
      Get.snackbar("title", "message");
    }
    return false;
  }
}
