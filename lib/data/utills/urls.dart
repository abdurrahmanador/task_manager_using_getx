import 'package:task_manager_using_getx/data/models/task_status_model.dart';

class Urls{
  Urls._();

  static const String _baseUrl="https://task.teamrabbil.com/api/v1";
  static const String registration="$_baseUrl/registration";
  static const String login="$_baseUrl/login";
  static const String createTask="$_baseUrl/createTask";
  static const String taskStatusCount="$_baseUrl/taskStatusCount";
  static const String newTasks="$_baseUrl/listTaskByStatus/New";
  static const String recoverResetPass="$_baseUrl/RecoverResetPass";
  static String inProgressTasks = '$_baseUrl/listTaskByStatus/Progress';
  static String completedTasks = '$_baseUrl/listTaskByStatus/Completed';
  static String cancelledTasks = '$_baseUrl/listTaskByStatus/Cancelled';
  static String deleteTask(String id) => '$_baseUrl/deleteTask/$id';
  static String reecoverVerifyEmail(String id) => '$_baseUrl//RecoverVerifyEmail/$id';
  static String recoverVerifyOTP(String id,String otp) => '$_baseUrl//RecoverVerifyOTP/$id/$otp';

  static String updateTask(String id,String status)=> '$_baseUrl/updateTaskStatus/$id/$status';
  static String updateProfile = '$_baseUrl/profileUpdate';

}