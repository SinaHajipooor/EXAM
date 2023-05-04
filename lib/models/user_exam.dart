class UserExam {
  // feilds
  final int id;
  final int examId;
  final int userId;
  final DateTime startTime;
  final DateTime endTime;
  final bool attendingStatus;
  final bool acceptanceStatus;
  final double examScore;
  final String location;
  final String file;
// constructor
  const UserExam({
    required this.id,
    required this.examId,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.attendingStatus,
    required this.acceptanceStatus,
    required this.examScore,
    required this.location,
    required this.file,
  });
}
