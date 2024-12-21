part of 'enums.dart';

enum RunningTaskStatus { none, accepted, started, captureVideo, completed }

enum TaskResult { success, failed }

Map<int, RunningTaskStatus> taskStatusMap = {
  0: RunningTaskStatus.none,
  1: RunningTaskStatus.accepted,
  2: RunningTaskStatus.started,
  3: RunningTaskStatus.captureVideo,
  4: RunningTaskStatus.completed,
};
