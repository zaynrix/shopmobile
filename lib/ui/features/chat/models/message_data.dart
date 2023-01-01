class MessageData {
  final String senderName;
  final String message;
  final DateTime messageDate;
  final String dateMessage;
  final String profilePicture;

  MessageData(
      {required this.message,
      required this.dateMessage,
      required this.messageDate,
      required this.profilePicture,
      required this.senderName});
}
