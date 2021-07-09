import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoForm extends StatefulWidget {


  @override
  _TodoFormState createState() => _TodoFormState();


}

class _TodoFormState extends State<TodoForm> {

  final _formKey = GlobalKey<FormState>();

  String title = '';
  String priority  = '';
  DateTime _date = DateTime.now();

  TextEditingController _dateController = TextEditingController();

  final DateFormat _dateFormat = DateFormat('MMM dd, yyyy');

  final List<String> priorities =  ['Low', 'Medium', 'High'];

  _handleDatePicker () async{
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2300),
    );

    if(date != null && date != date){
      setState(() {
        _date = date;
      });
      _dateController.text = _date.toString();
    }
  }

  _submit(){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      // Inserting task


      //Update Task


      // Delete Task



      Navigator.pop(context);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back_ios, size: 30.0, color: Colors.black,),


                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    "Add Task",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(

                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            readOnly: true,
                            style: TextStyle(fontSize: 10.0),
                            decoration: InputDecoration(
                              labelText: "Title",
                              labelStyle: TextStyle(fontSize: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              )
                            ),
                            validator: (input) => input.trim().isEmpty ? "Please Enter a title" : null,
                            onSaved: (input) => title = input,
                            initialValue: title,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                            icon: Icon(Icons.arrow_downward),
                            iconEnabledColor: Colors.red,
                            items: priorities.map((String priority) {
                              return DropdownMenuItem(
                                // value: priority,
                                  child: Text(priority,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.0,
                                  ),
                                  ),
                              );
                            }),
                            style: TextStyle(fontSize: 10.0),
                            decoration: InputDecoration(
                                labelText: "Date",
                                labelStyle: TextStyle(fontSize: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )
                            ),
                            validator: (input) => input.trim().isEmpty ? "Please Enter a title" : null,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            style: TextStyle(fontSize: 10.0),
                            onTap: () {},
                            decoration: InputDecoration(
                                labelText: "Priority",
                                labelStyle: TextStyle(fontSize: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )
                            ),
                            validator: (input) => priority == null ? "Please Enter a Priority" : null,
                            onSaved: (input) => priority = input,
                            onChanged: (value){
                              setState(() {
                                priority = value;
                              });
                            },
                          ),
                        ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        height: 62.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: FlatButton(
                          child: Text(
                              "Add",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: _submit(),
                        ),
                      ),


                      ],
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
