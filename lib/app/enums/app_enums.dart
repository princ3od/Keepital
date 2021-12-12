enum LoadingType {
  coinSpining,
  foldingCube,
}

enum SignInType {
  withGoogle,
  withFacebook,
}

enum TimeRange { day, week, month, quarter, year, all }

enum CategoryType { expense, income }

extension CategoryTypeTransform on CategoryType {
  String str() {
    return this.toString().split('.').last;
  }
}

CategoryType categoryFromString(String value) {
  return CategoryType.values.firstWhere((element) => element.str() == value, orElse: () => CategoryType.income);
}
