import 'package:flutter/material.dart';
import 'package:flutter_notes_app/model/user_repository.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool signInForm;
  @override
  void initState() {
    super.initState();
    signInForm = true;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return WillPopScope(
      onWillPop: () async {
        if (!signInForm) {
          setState(() {
            signInForm = true;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _key,
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
                user.status == Status.Authenticating ?
                Center(child: CircularProgressIndicator(backgroundColor: Colors.white,)) :
                RaisedButton(
                  textColor: Colors.white,
                  color: Colors.red,
                  child: Text("Continue with Google"),
                  onPressed: () async {
                    if (!await user.signInWithGoogle())
                      showMessage();
                  },
                ),
                const SizedBox(height: 30.0),
                AnimatedSwitcher(
                  child: signInForm ? LoginForm(showError: (message) => showMessage(message: message),) : SignupForm(showError: (message) => showMessage(message: message),),
                  duration: Duration(milliseconds: 200),
                ),
                const SizedBox(height: 20.0),
                OutlineButton(
                  textColor: Colors.black,
                  child: signInForm
                      ? Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        )
                      : Icon(Icons.arrow_back),
                  onPressed: () {
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
  void showMessage({String message = "Something is wroing"}) {
    _key.currentState.showSnackBar(SnackBar(
                        content: Text(message),
                      ));
  }
}

class LoginForm extends StatefulWidget {
  final Function showError;

  const LoginForm({Key key, this.showError}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FocusNode passwordField = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _email;
  TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              "Login",
              style: Theme.of(context).textTheme.display1,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              validator: (val) {
                if (val.isEmpty) return "Email is required";
              },
              controller: _email,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "email address"),
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(passwordField);
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              validator: (val) {
                if (val.isEmpty) return "password is required";
              },
              obscureText: true,
              controller: _password,
              focusNode: passwordField,
              decoration: InputDecoration(labelText: "password"),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
              ),
              child: user.status == Status.Authenticating ?
                Center(child: CircularProgressIndicator()) : RaisedButton(
                textColor: Colors.white,
                child: Text("Login"),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    if(!await user.signIn(_email.text, _password.text))
                    widget.showError();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  final Function showError;

  const SignupForm({Key key, this.showError}) : super(key: key);
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final FocusNode passwordField = FocusNode();
  final FocusNode confirmPasswordField = FocusNode();
  TextEditingController _email;
  TextEditingController _password;
  TextEditingController _confirmPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              "Sign up",
              style: Theme.of(context).textTheme.display1,
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _email,
              validator: (val) {
                if (val.isEmpty) return "Email is required";
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "email address"),
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(passwordField);
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              validator: (val) {
                if (val.isEmpty) return "Password is required";
              },
              obscureText: true,
              controller: _password,
              focusNode: passwordField,
              decoration: InputDecoration(labelText: "password"),
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(confirmPasswordField),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              obscureText: true,
              controller: _confirmPassword,
              validator: (val) {
                if (val.isEmpty) return "Confirm password is required";
              },
              focusNode: confirmPasswordField,
              decoration: InputDecoration(labelText: "confirm password"),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
              ),
              child: user.status == Status.Authenticating ?
                Center(child: CircularProgressIndicator()) : RaisedButton(
                textColor: Colors.white,
                child: Text("Create Account"),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    if (_confirmPassword.text == _password.text) {
                      if(!await user.signUp(_email.text, _password.text))
                      widget.showError();
                    }
                    else
                      widget.showError("Passsword and confirm password does not match");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
