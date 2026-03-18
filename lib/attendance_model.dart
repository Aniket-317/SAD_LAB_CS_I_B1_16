class Attendance {
  String date;
  int status;

  Attendance({
    required this.date,
    required this.status,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      date: json["date"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "status": status,
    };
  }

  String getDate() {
    return date;
  }

  int getStatus() {
    return status;
  }

  void setStatus(int value) {
    status = value;
  }
}