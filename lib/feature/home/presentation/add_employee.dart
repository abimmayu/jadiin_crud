import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jadiin_crud/feature/home/data/database/employee_database.dart';
import 'package:jadiin_crud/feature/home/data/model/employee.dart';
import 'package:jadiin_crud/feature/home/presentation/widget/text_form.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController nipController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    nipController.dispose();
    super.dispose();
  }

  Future<void> addEmployee() async {
    final name = nameController.text;
    final nip = nipController.text;

    if (name.isEmpty || nip.isEmpty) {
      return;
    }

    final employee = Employee(
      name: name,
      nip: nip,
    );

    await EmployeeDatabase.instance.insert(employee);

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextFormWidget(
            hintText: 'Name',
            controller: nameController,
          ),
          SizedBox(
            height: 20.h,
          ),
          TextFormWidget(
            hintText: 'NIP',
            controller: nipController,
          ),
          SizedBox(
            height: 20.h,
          ),
          ElevatedButton(
            onPressed: addEmployee,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
