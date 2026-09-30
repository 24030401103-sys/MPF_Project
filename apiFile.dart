import 'package:http/http.dart' as http;

class ApiHelp {
  String url =
      "https://6abb6461b2118ed7abb8769f.mockapi.io/faculty/students";

  // GET - All Students
  void getAllStudents() async {
    var response = await http.get(
      Uri.parse(url),
    );

    print("GET DATA:");
    print(response.body);
  }

  // INSERT - Add Student
  void insertStudent() async {
    var response = await http.post(
      Uri.parse(url),
      body: {
        "name": "Harsh",
        "email": "harsh@gmail.com",
        "age": "22",
      },
    );

    print("INSERT DATA:");
    print(response.body);
  }

  // UPDATE - Update Student
  void updateStudent(String id) async {
    var response = await http.put(
      Uri.parse("$url/$id"),
      body: {
        "name": "Harsh Updated",
        "email": "updated@gmail.com",
        "age": "23",
      },
    );

    print("UPDATE DATA:");
    print(response.body);
  }

  // DELETE - Delete Student
  void deleteStudent(String id) async {
    var response = await http.delete(
      Uri.parse("$url/$id"),
    );

    print("DELETE DATA:");
    print(response.body);
  }
}

void main() {
  ApiHelp api = ApiHelp();

  // GET
 // api.getAllStudents();

  // INSERT
  //api.insertStudent();

  // UPDATE
  //api.updateStudent("1");

  // DELETE
  api.deleteStudent("1");
}