class RepeatOptions {
  int id;
  DateTime startDate;
  DateTime? endDate;
  int? numRepetition;
  int cycleLength;
  int recurUnitId;

  RepeatOptions({required this.id, required this.startDate, this.endDate, this.numRepetition, required this.cycleLength, required this.recurUnitId});
  RepeatOptions.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        startDate = data['startDate'].toDate(),
        endDate = data['endDate']?.toDate() ?? null,
        numRepetition = data['numRepetition'],
        cycleLength = data['cycleLength'],
        recurUnitId = data['recurUnitId'];

  Map<String, dynamic> toMap() {
    return {'id': id, 'startDate': startDate, 'endDate': endDate, 'numRepetition': numRepetition, 'cycleLength': cycleLength, 'recurUnitId': recurUnitId};
  }
}
