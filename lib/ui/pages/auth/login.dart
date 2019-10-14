import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool signInForm;
  @override
  void initState() {
    super.initState();
    signInForm = true;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(!signInForm) {
          setState(() {
            signInForm=true;
          });
          return false;
        }else{
          return true;
        }
      },
          child: Scaffold(
        backgroundColor: Colors.lightGreen,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
                    child: Column(
              children: <Widget>[
                const SizedBox(height: kToolbarHeight),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  width: 80.0,
                  height: 80.0,
                ),
                const SizedBox(height: 30.0),
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.red,
                  child: Text("Continue with Google"),
                  onPressed: (){},
                ),
                const SizedBox(height: 30.0),
                AnimatedSwitcher(
                  child: signInForm ? LoginForm() : SignupForm(),
                  duration: Duration(milliseconds: 200),
                ),
                const SizedBox(height: 20.0),
                OutlineButton(
                  textColor: Colors.black,
                  child: signInForm ? Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,),) : Icon(Icons.arrow_back),
                  onPressed: (){
                    setState(() {
                      signInForm = !signInForm;
                    });
                  },
                  color: Colors.white,
                  borderSide: BorderSide(color: Colors.white),
                  highlightColor: Colors.white,
                )
              ],
            ),
          ),
        ),
        
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final FocusNode passwordField = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),

      ),
      child: Column(
        children: <Widget>[
          Text("Login",style: Theme.of(context).textTheme.display1,),
          const SizedBox(height: 20.0),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: "email address"
            ),
            onEditingComplete: (){
              FocusScope.of(context).requestFocus(passwordField);
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            focusNode: passwordField,
            decoration: InputDecoration(
              labelText: "password"
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 32.0,),
            child: RaisedButton(
              textColor: Colors.white,
              child: Text("Login"),
              onPressed: (){},
            ),
          )
        ],
      ),
    );
  }
}
class SignupForm extends StatelessWidget {
  final FocusNode passwordField = FocusNode();
  final FocusNode confirmPasswordField = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),

      ),
      child: Column(
        children: <Widget>[
          Text("Sign up",style: Theme.of(context).textTheme.display1,),
          const SizedBox(height: 20.0),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: "email address"
            ),
            onEditingComplete: (){
              FocusScope.of(context).requestFocus(passwordField);
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            focusNode: passwordField,
            decoration: InputDecoration(
              labelText: "password"
            ),
            onEditingComplete: ()=>FocusScope.of(context).requestFocus(confirmPasswordField),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            focusNode: confirmPasswordField,
            decoration: InputDecoration(
              labelText: "confirm password"
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 32.0,),
            child: RaisedButton(
              textColor: Colors.white,
              child: Text("Create Account"),
              onPressed: (){},
            ),
          )
        ],
      ),
    );
  }
}