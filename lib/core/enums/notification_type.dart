part of 'enums.dart';

enum NotificationType { taskSuccess, taskFailed, payout }

Map<int, NotificationType> notificationTypeMap = {
  0: NotificationType.taskSuccess,
  1: NotificationType.taskFailed,
  2: NotificationType.payout,
};
