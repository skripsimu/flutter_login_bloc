import 'package:flutter/material.dart';
import 'bloc/bloc_pattern.dart';
import 'bloc/provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Login validator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Login bloc'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool VisibilityPassword = false;
  void initState() {
    VisibilityPassword = !VisibilityPassword;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            logo(),
            new Column(
              children: <Widget>[
                fieldUname(bloc),
                SizedBox(
                  height: 10,
                ),
                fieldPassword(bloc),
                buttonLogin(bloc)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget logo() {
    return new InkWell(
      child: Image.asset(
        'assets/images/logo.png',
        width: 150,
        height: 150,
      ),
    );
  }

  Widget fieldUname(bloc) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      width: MediaQuery.of(context).size.width,
      child: new StreamBuilder(
          stream: bloc.email,
          builder: (context, snapshot) {
            return TextField(
              onChanged: bloc.changeEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'you@example.com',
                  labelText: 'Email Address',
                  errorText: snapshot.error,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.blue,
                    ),
                  )),
            );
          }),
    );
  }

  Widget fieldPassword(bloc) {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        width: MediaQuery.of(context).size.width,
        child: new StreamBuilder(
            stream: bloc.password,
            builder: (context, snapshot) {
              return TextField(
                obscureText: VisibilityPassword,
                onChanged: bloc.changePassword,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Must contain 8 characters',
                    labelText: 'Password',
                    errorText: snapshot.error,
                    suffixIcon: IconButton(
                      icon: Icon(
                        VisibilityPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          VisibilityPassword = !VisibilityPassword;
                        });
                      },

                    )),
              );
            }));
  }

  Widget buttonLogin(bloc) {
    return StreamBuilder<bool>(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          return FlatButton(
            padding: EdgeInsets.only(top: 10.0),
            child: Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            onPressed: snapshot.hasData ? bloc.submit : null,
          );
        });
  }
}
