
import 'package:bluetaxiapp/provider_practice/data/model/user_dto.dart';
import 'package:bluetaxiapp/provider_practice/provider/user_dto_state.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            MyTextField(controller: firstName, labelText: "Enter First Name"),
            MyTextField(controller: lastName, labelText: "Enter Last Name"),
            MyTextField(controller: email, labelText: "Enter Email"),
            MyTextField(controller: password, labelText: "Enter Password", isObscureText: true,),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: (){
                      UserDTO user = UserDTO(firstName: firstName.text, lastName: lastName.text, email: email.text);
                      Provider.of<UserDTOState>(context,listen: false).addUser(newUser: user);
                    },
                    child: Text("ADD")
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserListView(),));
                    },
                    child: Text("Get")
                ),
              ],

            )
          ],
        ),
      ),
    );
  }
}



class MyTextField extends StatelessWidget {
  const MyTextField({Key? key, required this.controller, required this.labelText, this.isObscureText=false}) : super(key: key);
  final TextEditingController controller;
  final String labelText;
  final bool isObscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscureText ? true : false,
      controller: controller,
     // autofocus: true,
      autocorrect: true,
      decoration: InputDecoration(
          labelText: "$labelText*"
      ),
    );
  }
}


class UserListView extends StatelessWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Users"),
        centerTitle: true,
      ),
      body: Consumer<UserDTOState>(
        builder: (context, value, child) =>
            ListView.builder(
              itemCount: value.usersList.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(child: Text(value.usersList[index].id.toString()),),
                  title: Text(value.usersList[index].firstName+" "+value.usersList[index].lastName),
                  subtitle: Text(value.usersList[index].email),
                ),
            ),
      ),
    );
  }
}

