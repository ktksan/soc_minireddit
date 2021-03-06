import 'package:Incognichat/scoped-model/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-model/main.dart';
import 'home_page_chats.dart';

class ChatScreen extends StatefulWidget {
  final MainModel model;
  ChatScreen(this.model);
  @override
  State<StatefulWidget> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    widget.model.fetchMessage();
    super.initState();
  }
  
  Widget _drawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: null,
            accountName: Text("Random"),
            currentAccountPicture: CircleAvatar(
              child: Text("R"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text("Return to Main Page"),
            onTap: () {
              //SchedulerBinding.instance.addPersistentFrameCallback( (callback) {
              Navigator.pushReplacementNamed(context, '/chat_home');
              //});  
            }
          )
        ]
      ),
    );
  }

  Widget _bar(BuildContext context) {
    return AppBar(
        title: new Text(
          widget.model.user.id,
        ),
        centerTitle: true,
      );
  }
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder:(BuildContext context,Widget child,MainModel model){
          return Container(
      child: Scaffold(
        drawer: _drawer(context),
        appBar: _bar(context),
         body:ListView.builder(
        itemBuilder: (BuildContext context, int index){
           return Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(children: <Widget>[
                Text(model.allMessages[index]),
                Divider(),
              ],
          ),
           );
        },
        itemCount: model.allMessages.length,
      ),
        bottomNavigationBar: BottomAppBar(
          child:RaisedButton(onPressed: () { model.sendMessage('Hello Satvik');},
          child: Text('Fixed Send'))
        ),
      ),
    );
  });
  }
}