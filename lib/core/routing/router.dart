import 'package:go_router/go_router.dart';
import 'package:jadiin_crud/feature/home/data/model/employee.dart';
import 'package:jadiin_crud/feature/home/presentation/add_employee.dart';
import 'package:jadiin_crud/feature/home/presentation/edit_employee.dart';
import 'package:jadiin_crud/feature/home/presentation/home_screen.dart';

enum AppRoute {
  home,
  addEmployee,
  editEmployee,
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/add-employee',
      name: AppRoute.addEmployee.name,
      builder: (context, state) => const AddEmployeeScreen(),
    ),
    GoRoute(
        path: '/edit-employee',
        name: AppRoute.editEmployee.name,
        builder: (context, state) {
          final employee = state.extra as EditEmployeeParam;
          return EditEmployeeScreen(
            param: employee,
          );
        }),
  ],
);
