import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jadiin_crud/feature/home/data/database/employee_database.dart';
import 'package:jadiin_crud/feature/home/data/model/employee.dart';
import 'package:jadiin_crud/feature/home/presentation/widget/text_form.dart';

class EditEmployeeParam {
  final Employee employee;
  EditEmployeeParam({
    required this.employee,
  });
}

class EditEmployeeScreen extends StatefulWidget {
  const EditEmployeeScreen({super.key, required this.param});

  final EditEmployeeParam param;

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController nipController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    nipController.dispose();
    super.dispose();
  }

  Future<void> editEmployee() async {
    final name = nameController.text;
    final nip = nipController.text;

    final employee = widget.param.employee.copy(
      name: name,
      nip: nip,
    );
    await EmployeeDatabase.instance.update(employee);

    context.pop();
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.param.employee.name;
    nipController.text = widget.param.employee.nip;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Employee'),
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
            onPressed: editEmployee,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
