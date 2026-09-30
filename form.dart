// import 'package:flutter/material.dart';
//
// class AddForm extends StatefulWidget {
//   const AddForm({super.key});
//
//   @override
//   State<AddForm> createState() => _AddFormState();
// }
//
// class _AddFormState extends State<AddForm> {
//
//   final _formKey = GlobalKey<FormState>();
//
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add User Form')),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _buildFormRow(
//                 'Name',
//                 TextFormField(
//                   controller: nameController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//               ),
//
//               _buildFormRow(
//                 'Email',
//                 TextFormField(
//                   controller: emailController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//               ),
//               _buildFormRow(
//                 'Age',
//                 TextFormField(
//                   controller: ageController,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.number,
//                 ),
//
//               ),
//
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     Map<String, dynamic> newUser = {
//                       "name": nameController.text.toString(),
//                       "email": emailController.text.toString(),
//                       "age" : ageController.text.toString(),
//                     };
//                     print("new User = $newUser" );
//                   }
//                 },
//                 style: ButtonStyle(
//                   backgroundColor: WidgetStateProperty.all(Colors.red),
//                 ),
//                 child: const Text(
//                   'Submit',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//
//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFormRow(String label, Widget field) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 120,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 12.0),
//               child: Text(
//                 label,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(child: field),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'apiFile.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {

  final _formKey = GlobalKey<FormState>();

  ApiHelp api = ApiHelp();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User Form'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              // Name
              _buildFormRow(
                'Name',
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // Email
              _buildFormRow(
                'Email',
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),

              // Age
              _buildFormRow(
                'Age',
                TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              const SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: () {

                  if (_formKey.currentState!.validate()) {

                    Map<String, dynamic> newUser = {
                      "name": nameController.text,
                      "email": emailController.text,
                      "age": ageController.text,
                    };

                    // API Call
                    api.getAllStudents();

                    print("User Added");

                    // Clear Form
                    nameController.clear();
                    emailController.clear();
                    ageController.clear();
                  }
                },

                style: ButtonStyle(
                  backgroundColor:
                  WidgetStateProperty.all(Colors.red),
                ),

                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Form Row
  Widget _buildFormRow(String label, Widget field) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          SizedBox(
            width: 120,

            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),

              child: Text(
                label,

                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          Expanded(
            child: field,
          ),
        ],
      ),
    );
  }
}