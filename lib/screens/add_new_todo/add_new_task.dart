import 'package:flutter/material.dart';
import 'package:medicine/database/todo_helper.dart';
import 'package:medicine/screens/add_new_todo/todo_form.dart';
import 'package:medicine/models/todo_model.dart';


class Todo extends StatefulWidget {


  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  Future<List<Todo>> _taskList;

  @override
  void initState() {
    super.initState();
    _updateTaskList();
  }

  _updateTaskList(){
    setState(() {
      _taskList = TodoDBHelper.instance.getTaskList() as Future<List<Todo>>;
    });
  }



  Widget _buildTask(Todo task){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: ListTile(
        title: Text("asda"),
        subtitle: Text("SUBTITLE"),
        trailing: Checkbox(
          onChanged: (value) {
            print(value);
          },
          activeColor: Colors.red,
          value: true,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TodoForm())
          ),
        },

      ),
      body: FutureBuilder(
        future: _taskList,
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          else {

            // final int completedTask = snapshot.data.where((Todo task) => task.status == 1).toList().length;


            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 80.0),
              itemCount: 1 + snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "My Task",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "1 of 10",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }


                return _buildTask(snapshot.data[index - 1]);
              },
            );
          }
      },
      ),
    );
  }
}
