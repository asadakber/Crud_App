import 'package:flutter/material.dart';
import 'package:todo_app_firebase/modal/crud.dart';
import 'package:todo_app_firebase/screens/add_crud.dart';
import 'package:todo_app_firebase/screens/details_crud.dart';
import 'package:todo_app_firebase/services/crud_services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CrudApp'),
      ),
      body: StreamBuilder(
        stream: CrudServices().getCrud(),
        builder: (BuildContext context, AsyncSnapshot<List<Crud>> snapshot) {
          if(snapshot.hasError || !snapshot.hasData)
            return CircularProgressIndicator();

            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Crud crud = snapshot.data[index];
                  return ListTile(
                    title: Text(crud.title),
                    subtitle: Text(crud.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          color: Colors.blue,
                          icon: Icon(Icons.edit),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(
                              builder: (_) => AddCrud(crud: crud)
                          )),
                        ),
                        IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.delete),
                            onPressed: () => _delete(context, crud.id)
                        )
                      ],
                    ),
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (_) => DetailsCrud(crud: crud)
                    )),
                  );
                }
            );

        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (_) => AddCrud()
          ));
        },
      ),
    );
  }
}

void _delete(BuildContext context, String id) async {
  if(await _showConfirmationDialog(context)) {
    try {
      await CrudServices().delete(id);
    } catch(e) {
      print(e);
    }
  }
}

Future<bool> _showConfirmationDialog(BuildContext context) async {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        content: Text("Are you sure you want to delete?"),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.red,
            child: Text("Delete"),
            onPressed: () => Navigator.pop(context, true),
          ),
          FlatButton(
            textColor: Colors.black,
            child: Text("No"),
            onPressed: () => Navigator.pop(context, false),
          )
        ],
      )
  );
}

