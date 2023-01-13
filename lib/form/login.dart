import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loginshose/cubit/logic.dart';
import 'package:loginshose/cubit/states.dart';
import 'package:loginshose/form/register.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyLogin extends StatelessWidget {
  final GlobalKey<FormState> globalKey = GlobalKey();
  bool visible = true;
  Map<String, String> _map = {"email": "", "password": ""};
  @override
  Widget build(BuildContext context) {
    double the_size_height = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    double the_size_width = MediaQuery.of(context).size.width;

    // final  _password_controller = TextEditingController();
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var db = AppCubit.get(context);

        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 100,
              backgroundColor: Colors.white,
              title: Center(
                child: Text(
                  "Clean Shoes",
                  style: TextStyle(
                      color: Color.fromARGB(255, 23, 111, 183), fontSize: 40),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: Container(
                alignment: Alignment.topCenter,
                width: the_size_width * 0.8,
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      child: Form(
                        key: globalKey,
                        child: Column(
                          children: [
                            TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty || !val.contains("@")) {
                                    return "invalid E-mail";
                                  }
                                  return null;
                                },
                                onSaved: ((newValue) =>
                                    _map["email"] = newValue as String),
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Color.fromARGB(255, 23, 111, 183),
                                decoration: InputDecoration(
                                  label: Text("E-Mail"),
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 23, 111, 183),
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: Icon(Icons.email,
                                      color: Color.fromARGB(255, 23, 111, 183)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 23, 111, 183)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 23, 111, 183)),
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                )),
                            SizedBox(
                              height: the_size_height * 0.04,
                            ),
                            TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty || val.length <= 5) {
                                    return "invalid password";
                                  }
                                  return null;
                                },
                                onSaved: ((newValue) =>
                                    _map["password"] = newValue as String),
                                // controller: _password_controller,
                                obscureText: visible,
                                cursorColor: Color.fromARGB(255, 23, 111, 183),
                                decoration: InputDecoration(
                                  label: Text("password"),
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 23, 111, 183),
                                      fontWeight: FontWeight.bold),
                                  prefixIcon: IconButton(
                                      icon: visible
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                      onPressed: null,
                                      color: Color.fromARGB(255, 23, 111, 183)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 23, 111, 183)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 23, 111, 183)),
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                )),
                            SizedBox(
                              height: the_size_height * 0.04,
                            ),
                          ],
                        ),
                      ),
                    ),
                    MaterialButton(
                        minWidth: double.infinity,
                        height: 58,
                        color: Color.fromARGB(255, 44, 121, 184),
                        shape: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 23, 111, 183)),
                            borderRadius: BorderRadius.circular(50)),
                        onPressed: () {
                          if (!globalKey.currentState!.validate()) {
                            return;
                          } else {
                            globalKey.currentState!.save();

                            if (db.checkAcount(_map)) {
                              Alert(
                                context: context,
                                type: AlertType.success,
                                title: "success",
                              ).show();
                            } else {
                              Alert(
                                context: context,
                                type: AlertType.error,
                                title: "LOIN FAILD",
                              ).show();
                            }
                          }
                        },
                        child: Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )),
        TextButton(onPressed: (){
          Navigator.push(
                                context,
                                PageTransition(
                                    child: MyRegister(),
                                    type: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 500),
                                    reverseDuration: Duration(milliseconds: 500)));
        }, child: Text('I dont have account'))

                  ]),
                ),
              ),
            ));
      },
    );
  }
}
