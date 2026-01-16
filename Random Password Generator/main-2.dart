import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentListScreen(),
    );
  }
}

class StudentListScreen extends StatefulWidget {
  @override
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  final List<Student> students = [];
  final _formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final gpdController = TextEditingController();

  void _addStudent() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        students.add(Student(
          id: int.parse(idController.text),
          name: nameController.text,
          surname: surnameController.text,
          gpd: double.parse(gpdController.text),
        ));
      });

      idController.clear();
      nameController.clear();
      surnameController.clear();
      gpdController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Week 4 Assignment', style: TextStyle(color: Colors.white), ),  backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: idController,
                    decoration: InputDecoration(labelText: 'ID'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an ID';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: surnameController,
                    decoration: InputDecoration(labelText: 'Surname'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a surname';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: gpdController,
                    decoration: InputDecoration(labelText: 'GPD'),
                    keyboardType: TextInputType.number,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter GPD';
                      }
                      return null;
                    },

                  ),

                  TextButton(
                    onPressed: _addStudent,
                    child: Text('Add Student', style: TextStyle(color: Colors.blue, fontSize: 20),),
                  ),
                ],
              ),
            ),
          ),
          // List of students
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Id: ${student.id}', style: TextStyle(fontSize: 16)),
                            Text('GPD: ${student.gpd}', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: ${student.name}', style: TextStyle(fontSize: 16)),
                            Text('Surname: ${student.surname}', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class Student {
  int id;
  String name;
  String surname;
  double gpd;

 Student({required this.id, required this.name, required this.surname, required this.gpd});

}
