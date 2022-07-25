class TaskParams {
  final bool? withProgress;
  final String? idempotencyKey;

  const TaskParams({this.withProgress, this.idempotencyKey});
}
