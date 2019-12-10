import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mybook/authentication.dart';
import 'package:mybook/home.dart';
import 'package:mybook/profile.dart';

void main()
{
  //ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  runApp(MyApp());
}
 

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      title: 'mybook',
      theme: ThemeData
      (
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget 
{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin
{
  TabController controller;

  @override
  void initState()
  {
    super.initState();
    controller = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) 
  {
    return StreamBuilder
    (
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, firebaseUser)
      {
        return firebaseUser.data == null ? Authentication() : Scaffold
        (
          appBar: AppBar
          (
            title: Text("mybook"),
            actions: <Widget>
            [
              IconButton
              (
                icon: Icon
                (
                  Icons.search, 
                  color: Colors.white
                ),
                onPressed: (){}
              ),
              IconButton
              (
                icon: Icon
                (
                  Icons.message, 
                  color: Colors.white
                ),
                onPressed: (){}
              ),
            ],
            bottom: TabBar
            (
              controller: controller,
              tabs: <Widget>
              [
                Icon(Icons.home),
                Icon(Icons.people),
                Icon(Icons.person),
                Icon(Icons.favorite),
                Icon(Icons.notifications),
                Icon(Icons.menu),
              ],
            ),
          ),
          body: TabBarView
          (
            controller: controller,
            children: <Widget>
            [
              Home(firebaseUser: firebaseUser.data),
              Container(),
              Profile(firebaseUser: firebaseUser.data),
              Container(),
              Container(),
              Container()
            ],
          )
        );
      },
    );
  } 
}

