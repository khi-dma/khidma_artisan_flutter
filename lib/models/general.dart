class General<T> {
  T data;
  bool error;
  String returnMessage;
  bool exist;
  String token;
  int state;
  bool haveNext;

  General(
      {required this.data,
      this.error = false,
      this.returnMessage = "",
      this.exist = false,
      this.token = "",
      this.state = 0,
      this.haveNext = false});
}
