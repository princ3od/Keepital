class RepeatOptions {
  int id;
  DateTime startDate;
  DateTime? endDate;
  int? numRepetition;
  int cycleLength;
  int recurUnitId;
  int count;

  RepeatOptions({required this.id, required this.startDate, this.endDate, this.numRepetition, required this.cycleLength, required this.recurUnitId, this.count = 0});
  RepeatOptions.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        startDate = data['startDate'].toDate(),
        endDate = data['endDate']?.toDate() ?? null,
        numRepetition = data['numRepetition'],
        cycleLength = data['cycleLength'],
        recurUnitId = data['recurUnitId'],
        count = data['count'] ?? 0;

  Map<String, dynamic> toMap() {
    return {'id': id, 'startDate': startDate, 'endDate': endDate, 'numRepetition': numRepetition, 'cycleLength': cycleLength, 'recurUnitId': recurUnitId, 'count': count};
  }

  DateTime nextOcurrence() {
    switch (recurUnitId) {
      case 0:
        return startDate.add(Duration(days: cycleLength));
      case 1:
        return startDate.add(Duration(days: cycleLength * 7));
      case 2:
        return startDate.add(Duration(days: cycleLength * 30));
      case 3:
        return startDate.add(Duration(days: cycleLength * 365));
      default:
        throw Exception();
    }
  }
}
