class Date {
  final String fullDate;

  Date({
    required this.fullDate
  });

  call() {
    switch (fullDate) {
      case "Monday":
        return "Mon";
      case "Tuesday":
        return "Tue";
      case "Wednesday":
        return "Wed";
      case "Thursday":
        return "Thu";
      case "Friday":
        return "Fri";
      case "Sunday":
        return "Sun";
      default:
        return "Sat";
    }
  }
}