import 'package:flutter/material.dart';
import 'package:flutter_api/componentes/message_box.dart';
import 'package:flutter_api/componentes/snack_message.dart';
import 'package:flutter_api/data/api/user_api_service.dart';
import 'package:flutter_api/data/models/post_model.dart';
import 'package:flutter_api/data/models/user_model.dart';

class ListUserPage extends StatefulWidget {
  @override
  _ListUserPageState createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
      future: UserApiService.userApiService.getUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        if (snapshot.hasError) {
          return Text('Houston, tenemos un problema');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return new ListView(
          children: _listaMapUsers(context, snapshot.data),
        );
      },
    );
  }

  List<Widget> _listaMapUsers(BuildContext context, List<UserModel> users) {
//    UserApiService.userApiService.getUserById(1).then((UserModel value) {
//      var p = value.toJson();
//      p['name'] = 'Dart Flutter';
//      p['username'] = 'dflutter';
//      UserApiService.userApiService.updateUser(UserModel.fromJson(p));
//    });
//    UserApiService.userApiService
//        .createUser(UserModel(name: 'Dart Flutter', username: 'dflutter'));

    UserApiService.userApiService.getUserById(2).then((UserModel value) {
      UserApiService.userApiService.deleteUser(value);
    });

//    UserApiService.userApiService.createUser(UserModel(name: 'Dart Flutter', username: 'dflutter'));
//    UserApiService.userApiService.updateUser(UserModel(id: 1,name: 'Dart Flutter 2do', username: 'dflutter'));
    return users.map((_user) {
      return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.redAccent,
          child: Row(
            children: [
              Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'ELIMINAR',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        secondaryBackground: Container(
          color: Colors.greenAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'ACTUALIZAR',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 10.0,
              ),
              Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ],
          ),
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            //_delete(user, _user.id);
          } else if (direction == DismissDirection.endToStart) {
            //_update(user, _user.id);
          }
        },
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.person_outline,
                color: Colors.black26,
              ),
              title: Text('${_user.name} (${_user.username.toLowerCase()})'),
              subtitle: Text(
                  'ID: ${_user.id} ${" " * 10}Company: ${_user.company.name}'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, 'user_details', arguments: 'user');
              },
            ),
            Divider(
              thickness: 2.0,
              color: Colors.lightBlue,
              indent: 70.0,
              endIndent: 20.0,
            )
          ],
        ),
      );
    }).toList();
  }

  void _delete(PostModel user, String docId) {
    messageBox(
        context: context,
        icon: Icons.delete_forever,
        title: '¿Eliminara el usuario?',
        content: Text('${user.title.toUpperCase()}'),
        onPressOkBtn: () {
          setState(() {
            //DBProvider.db.deleteUserById(user.id);
            //database.userDao.deleteUser(user);
            //FirestoreProvider.firestoreProvider.deleteUser(docId);
          });
          Navigator.of(context).pop();
        },
        onPressCancelBtn: () {
          setState(() {});
          Navigator.of(context).pop();
        });
  }

  void _update(PostModel user, String docId) {
    usernameController.text = user.title;
    lastNameController.text = user.title;
    Widget form = Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: usernameController,
            validator: (value) {
              return value.isEmpty
                  ? 'El campo username no puede estar vacio'
                  : null;
            },
            decoration: InputDecoration(
              hintText: 'Insert username',
              icon: Icon(Icons.person),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormField(
            controller: lastNameController,
            validator: (value) {
              return value.isEmpty ? 'El lastName no puede estar vacio' : null;
            },
            decoration: InputDecoration(
              hintText: 'Insert lastname',
              icon: Icon(Icons.info_outline),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          RaisedButton(
            child: Text('Actualizar'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
//                FirestoreProvider.firestoreProvider.updateUser(
//                    docId,
//                    User(
//                        active: user.active,
//                        name: usernameController.text,
//                        lastName: lastNameController.text));
                //DBProvider.db.updateUser(user);
//                database.userDao.updateUser(User(
//                    id: user.id,
//                    active: user.active,
//                    name: usernameController.text,
//                    lastName: lastNameController.text,
//                    created: user.created));
                setState(() {});
                Scaffold.of(context).showSnackBar(snackMessage(
                    'El usuario ${usernameController.text} ha sido actualizado'));
                _formKey.currentState?.reset();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
    messageBox(
      context: context,
      icon: Icons.edit,
      title: 'Actualizar el usuario',
      content: form,
      onPressCancelBtn: () {
        setState(() {});
        Navigator.of(context).pop();
      },
    );
  }
}
