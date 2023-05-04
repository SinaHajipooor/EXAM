class VUserExam {
  final int id;
  final int examPeriod;
  final String examStartTime;
  final String examEndTime;
  final String examStatus;
  final int examQuestionsCount;
  final String courseName;
  final String lessonName;
  final int? userId;

  VUserExam({
    required this.id,
    required this.examPeriod,
    required this.examStartTime,
    required this.examEndTime,
    required this.examStatus,
    required this.examQuestionsCount,
    required this.courseName,
    required this.lessonName,
    this.userId,
  });
}
