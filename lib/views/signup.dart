import 'package:bike/views/login.dart';
import 'package:bike/widgets/my_input_field.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {

  @override
 _SignUpstate createState() => _SignUpstate();
}

class _SignUpstate extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController firsNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void iniState (){
    super.initState();

  emailController = TextEditingController();
  passwordController = TextEditingController();
  confirmPassword = TextEditingController();
  firsNameController = TextEditingController();
  lastNameController = TextEditingController();
  }
  
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(image: AssetImage("assets/images/fundo2.jfif"),fit:BoxFit.cover),
            ),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child:Icon(Icons.keyboard_arrow_left,size:48,color:Colors.white,)),
                Text(
                  "Inscrever-se",
                  style: TextStyle(fontSize:38, color: Colors.white),
                ),
            ]
            ),
            ),
          ),
          ),
        Expanded(
          child: Container(
          decoration:BoxDecoration(
            color: Colors.white,
            borderRadius:BorderRadius.only(topLeft: Radius.circular(64))
         ),
         clipBehavior: Clip.antiAlias,
         child: SingleChildScrollView(
           child: Padding(
             padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 80,
             ),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              MyInputField(
                label: 'Primeiro nome',
                placeholder: "Primeiro nome", 
               onChange:(value){
                this.firsNameController.text = value;
              
               },
              ),
              SizedBox(height: 40),
             
               MyInputField(
                label: 'Sobrenome',
                placeholder: "Sobrenome", 
               onChange:(value){
                this.lastNameController.text = value;
               }
              ),
               SizedBox(height: 40),
              
              MyInputField(
              label: 'Email',
              placeholder: "Endereço de email" ,
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
              
              MyInputField(label: 'Confirme sua senha',
              placeholder: "Senha" ,
              onChange:(value){
                this.confirmPassword.text = value;
              },
              isPasswordField: true,
              ),
              SizedBox(height: 40),
              
            ElevatedButton(
  onPressed: () {           
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LogIn()),
    );
  },
  child: Text('Inscrever-se'),
),
              SizedBox(height: 48),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Você já tem uma conta ?", style: TextStyle(fontSize: 18), ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(
                        builder:(context)=>LogIn()),
                         (route) => false);
                    },
                    child: Text("Conecte-se", style: TextStyle(fontSize: 18),)),
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

