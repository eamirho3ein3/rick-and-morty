class GlobVariable {
  static GlobVariable _instance;
  factory GlobVariable() => _instance ??= new GlobVariable._();
  GlobVariable._();

  bool characterListHaveMoreData;

  bool getCharacterListStatus() {
    return characterListHaveMoreData ?? true;
  }

  setCharacterListStatus(bool status) {
    characterListHaveMoreData = status;
  }
}
