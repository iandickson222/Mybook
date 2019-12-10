import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybook/loading.dart';

class Authentication extends StatefulWidget 
{
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> 
{
  String _email;
  String _password;
  bool isRegistering = false;
  bool isLoading = false;
  
  @override
  Widget build(BuildContext context) 
  {
    return isLoading == true ? Loading() : Scaffold
    ( 
      resizeToAvoidBottomInset: false,
      body: Container
      (
        color: Colors.red,
        padding: EdgeInsets.all(20.0),
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>
          [  
            Text
            (
              "mybook",
              style: TextStyle
              (
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40.0
              ),
            ),
            SizedBox(height: 40.0),
            TextField
            (
              onChanged: (text) => _email = text,
              style: TextStyle(fontSize: 15.0),
              decoration: InputDecoration
              (
                filled: true,
                fillColor: Colors.white,
                hintText: "Email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder
                (
                  borderRadius: BorderRadius.circular(40.0)
                )
              ),
            ),
            SizedBox(height: 5.0),
            TextField
            (
              obscureText: true,
              style: TextStyle(fontSize: 15.0),
              onChanged: (text) => _password = text,
              decoration: InputDecoration
              (
                filled: true,
                fillColor: Colors.white,
                hintText: "Password",
                prefixIcon: Icon(Icons.enhanced_encryption),
                
                border: OutlineInputBorder
                (
                  borderRadius: BorderRadius.circular(40.0)
                )
              ),
            ),
            SizedBox(height: 5.0),
            isRegistering == false ? Container() : TextField
            (
              obscureText: true,
              style: TextStyle(fontSize: 15.0),
              onChanged: (text) {},
              decoration: InputDecoration
              (
                filled: true,
                fillColor: Colors.white,
                hintText: "Confirm Password",
                prefixIcon: Icon(Icons.enhanced_encryption),
                
                border: OutlineInputBorder
                (
                  borderRadius: BorderRadius.circular(40.0)
                )
              ),
            ),
            SizedBox(height: 5.0),

            isRegistering == false ? 
            RaisedButton
            (
              padding: EdgeInsets.all(20.0),
              onPressed: () async
              {
                setState(() {
                  isLoading = true;
                });

                await FirebaseAuth.instance.signInWithEmailAndPassword
                (
                  email: _email,
                  password: _password
                );

              },
              shape: RoundedRectangleBorder
              (
                borderRadius: BorderRadius.circular(40.0)
              ),
              child: Container
              (
                width: MediaQuery.of(context).size.width - 40.0,         
                child: Text
                (
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle
                  (
                    color: Colors.red,
                    fontSize: 15.0
                  ),
                )
              ),
            ) :
            RaisedButton
            (
              padding: EdgeInsets.all(20.0),
              onPressed: () async
              {
                setState(() {
                  isLoading = true;
                });

                await FirebaseAuth.instance.createUserWithEmailAndPassword
                (
                  email: _email,
                  password: _password
                );
              },
              shape: RoundedRectangleBorder
              (
                borderRadius: BorderRadius.circular(40.0)
              ),
              child: Container
              (
                width: MediaQuery.of(context).size.width - 40.0,         
                child: Text
                (
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle
                  (
                    color: Colors.red,
                    fontSize: 15.0
                  ),
                )
              ),
            ),

            SizedBox(height: 40.0),
            InkWell
            (
              onTap: ()
              {
                setState(() {
                  isRegistering = !isRegistering;
                });
              },
              child: Text
              (
                isRegistering == true ? "Login to Mybook" : "Sign Up for Mybook",
                style: TextStyle
                (
                  color: Colors.white,
                  fontSize: 15.0
                ),
              ),
            ),
            isRegistering == true ? Container() : SizedBox(height: 20.0),
            isRegistering == true ? Container() : InkWell
            (
              onTap: (){},
              child: Text
              (
                "Forgot Password?",
                style: TextStyle
                (
                  color: Colors.white,
                  fontSize: 15.0
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}