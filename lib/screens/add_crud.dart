import 'package:flutter/material.dart';
import 'package:todo_app_firebase/modal/crud.dart';
import 'package:todo_app_firebase/services/crud_services.dart';

class AddCrud extends StatefulWidget {

  final Crud crud;

  AddCrud({Key key, this.crud}) : super(key : key);

  @override
  _AddCrudState createState() => _AddCrudState();
}

class _AddCrudState extends State<AddCrud> {

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _title;
  TextEditingController _description;
  FocusNode _descriptionNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _title = TextEditingController(text: isEditMode ? widget.crud.title : '');
    _description = TextEditingController(text: isEditMode ? widget.crud.description : '');
    _descriptionNode = FocusNode();
  }

  get isEditMode => widget.crud != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Crud' : 'Add Crud'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_descriptionNode);
                },
                controller: _title,
                validator: (value) {
                  if(value == null || value.isEmpty)
                    return "Title cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "title",
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                focusNode: _descriptionNode,
                controller: _description,
                maxLines: 4,
                decoration: InputDecoration(
                    labelText: "desc",
                    border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(isEditMode ? "Update" : "Save"),
                onPressed: () async {
                  if(_key.currentState.validate()) {
                    try {
                      if(isEditMode) {
                        Crud crud = Crud(
                          description: _description.text,
                          title: _title.text,
                          id: widget.crud.id
                        );
                        await CrudServices().update(crud);
                      } else {
                        Crud crud = Crud(
                            description: _description.text,
                            title: _title.text,
                        );
                        await CrudServices().addCrud(crud);
                      }
                      Navigator.pop(context);
                    } catch(e) {
                      print(e);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
