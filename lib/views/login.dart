import 'package:bike/views/home_registro.dart';
import 'package:bike/views/signup.dart';
import 'package:bike/widgets/my_input_field.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {

  @override
 _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  

  @override
  void iniState (){
    super.initState();

  emailController = TextEditingController();
  passwordController = TextEditingController();

  }
  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height *.3,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(image: AssetImage("assets/images/fundo2.jfif"),fit:BoxFit.cover),
            ),
          child: Center(
          child:Image(
            image: AssetImage("assets/images/logo.png"),
          width:100 ,
          ),
          ),
          ),
        Expanded(
          child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40,),
          decoration:BoxDecoration(
            color: Colors.white,
            borderRadius:BorderRadius.only(topLeft: Radius.circular(64))
         ),
         child: SafeArea(
          top: false,
           child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
              children: [
              Text("Login",style: TextStyle(fontSize:40),),
              SizedBox(height: 48),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
             
                children: [
              MyInputField(
                label: 'Email',
                placeholder: "Endereço de Email", 
               onChange:(value){
                this.emailController.text = value;

               },

              ),
              SizedBox(height: 40),
              MyInputField(label: 'Senha',
              placeholder: "Digite a Senha" ,
              onChange:(value){
                this.passwordController.text = value;
              },
              isPasswordField: true,
               ),
              SizedBox(height: 40),
              
         ElevatedButton(
  onPressed: () {           
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  },
  child: Text('Entra'),
),
              ],
                       ),
              SizedBox(height: 48),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Não tem uma conta?", style: TextStyle(fontSize: 18), ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: 
                    Text("Inscrever-se", style: TextStyle(fontSize: 18),)),
                ],
             ),
             ],),
           ),
         ),
       ),
      ),
  ]
  ),
    );
}
}

