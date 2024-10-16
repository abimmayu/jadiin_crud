import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jadiin_crud/core/routing/router.dart';
import 'package:jadiin_crud/feature/home/data/database/employee_database.dart';
import 'package:jadiin_crud/feature/home/data/model/employee.dart';
import 'package:jadiin_crud/feature/home/presentation/edit_employee.dart';
import 'package:jadiin_crud/feature/home/presentation/widget/table_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<Employee> employees = [];

  Future<void> getEmployees() async {
    setState(() {
      isLoading = true;
    });
    employees = await EmployeeDatabase.instance.readEmployees();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getEmployees();
  }

  @override
  void dispose() {
    EmployeeDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.greenAccent[900],
          ),
        ),
        onPressed: () async {
          await context.pushNamed(AppRoute.addEmployee.name);

          getEmployees();
        },
        child: const Text(
          "+ Add Employee",
          style: TextStyle(
            color: Colors.green,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: getEmployees,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            SizedBox(
              height: 100.h,
            ),
            const Center(
              child: Text(
                "Employee List",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : buildData(context),
          ],
        ),
      ),
    );
  }

  Widget buildData(BuildContext context) {
    return ListView.builder(
      itemCount: employees.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final employee = employees[index];
        return ListTile(
          leading: Text(employee.id.toString()),
          title: Text(employee.name),
          subtitle: Text(employee.nip),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TableButtonWidget(
                icon: Icons.edit,
                backgroundColor: Colors.yellow,
                iconColor: Colors.yellowAccent[700]!,
                action: () async {
                  await context.pushNamed(
                    AppRoute.editEmployee.name,
                    extra: EditEmployeeParam(
                      employee: employee,
                    ),
                  );

                  getEmployees();
                },
              ),
              SizedBox(
                width: 10.w,
              ),
              TableButtonWidget(
                icon: Icons.delete,
                backgroundColor: Colors.red,
                iconColor: Colors.redAccent[700]!,
                action: () async {
                  await EmployeeDatabase.instance.delete(employee.id!);
                  setState(() {
                    employees.removeAt(index);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
