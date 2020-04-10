import 'package:sliclone/services/auth.dart';
import 'package:sliclone/shared/constants.dart';
import 'package:sliclone/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = new TextEditingController();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  

  @override
  Widget build(BuildContext context) {
              void _showVerifyEmailSentDialog() {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Verify your account"),
                      content: new Text("Link to verify account has been sent to your email"),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("Dismiss"),
                          onPressed: () {
                            //_changeFormToLogin();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Sign up to Sliclone'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Expanded(
               child: Container(
                    padding: new EdgeInsets.all(20.0),
                    child:new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlutterLogo(
                        size: 120.0,
                      ),
                    ],
                  )
                )
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'email', labelText: 'E-mail Address', icon: new Icon(Icons.email)),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'password', labelText: 'Password', icon: new Icon(Icons.lock)),
                obscureText: true,
                controller: _passwordController,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Confirm password', labelText: 'confirm Password', icon: new Icon(Icons.lock)),
                obscureText: true,
                validator: (val) =>  _passwordController.text != val  ? 'Passwords do not match' : null,
                //onChanged: (val) {
                  //setState(() => password = val);
                //},
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    _auth.sendEmailVerification();
                    _showVerifyEmailSentDialog();
                    if(result == null) {
                      setState(() {
                        loading = false;
                        error = 'Please supply a valid email';
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}