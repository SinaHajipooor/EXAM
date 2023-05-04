class Exam {
// feilds
  final int id;
  final DateTime startTime;
  final DateTime endTime;
  final String examType;
  final String examStatus;
  final int questionsCount;
  final int courseId;
  final int lessonId;
// constructor
  const Exam({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.examType,
    required this.examStatus,
    required this.questionsCount,
    required this.courseId,
    required this.lessonId,
  });
}
