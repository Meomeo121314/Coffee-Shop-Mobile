class ObjectMessage {
  late bool flagMessage;
  late String message;

  ObjectMessage.fromJson(Map<String, dynamic> json) {
    flagMessage = json['flagMessage'];
    message = json['message'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flagMessage'] = flagMessage;
    data['message'] = message;
    return data;
  }

  get getFlagMessage => flagMessage;

  set setFlagMessage(flagMessage) => this.flagMessage = flagMessage;

  get getMessage => message;

  set setMessage(message) => this.message = message;
}
