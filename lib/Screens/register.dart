import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:login_using_hive/Screens/login.dart';
import 'package:login_using_hive/database/database.dart';

import '../model/usermodel.dart';



class Register_Hive extends StatelessWidget {
   Register_Hive({super.key});

  final email =TextEditingController();
  final password =TextEditingController();
final confmpasswrod =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body:
      Padding(
        padding: const EdgeInsets.only(top: 170,left: 15,right: 15),
        child: Column(
          children: [
            Icon(Icons.lock,size: 50,),
            SizedBox(height: 50,),
            TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),
              ),
            ),
            SizedBox(height: 14,),
            TextField(
              controller: password,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: "Password",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),
              ),
            ),
            SizedBox(height: 14,),
            TextField(
              controller:confmpasswrod ,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: "Confirm Password",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){


            }, child: Text("Register"),
            style: ElevatedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),backgroundColor: Colors.black,minimumSize: Size(380, 60),),),
            SizedBox(height: 50,),
            Row(
              children: [

                SizedBox(width: 40,),
                Text("Already have an account?",),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Login_Hive()));
                }, child: Text("Login")),
              ],
            )
          ],
        ),
      ),

    );
  }

  void ValidateSignUp()async{
    final email1= email.text.trim(); //email from controller
    final pswrd= password.text.trim();//password from controller
    final cnpswrd= confmpasswrod.text.trim(); //cnfrm pswrd from controller

    final emailValidationResult=EmailValidator.validate(email1);
    if(email1 !="" && pswrd !="" && cnpswrd!=""){
      if (emailValidationResult== true){
        final passValidationResult=checkPassword(pswrd,cnpswrd);
        if(passValidationResult ==true){
           final user=User(email:email1,password:pswrd);

           await DBFunction.instance.userSignUp(user);
           Get.back();
           Get.snackbar("Success", "Account created");
         }

      }
      else{
        Get.snackbar("Error","Provide a valid email");
      }
    }
    else{
Get.snackbar("Error", "Fields cannod be empty");
    }
  }

 bool checkPassword(String pswrd, String cnpswrd) {
    if(pswrd==cnpswrd){
    if(pswrd.length<6){
    Get.snackbar("Error", "Password should be greater than 6");
    return false;
    }
    else {
      return true;
    }
    }
    else{
      Get.snackbar("Error", "Password mismatch");
      return false;
    }
 }
}
