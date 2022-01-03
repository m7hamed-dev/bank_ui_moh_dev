class TransectionDetails {
  final int id;
  final int transectionId;
  final String userName;
  final String senderName;
  final double transectionAmount;
  // final bool transectionDone;

  TransectionDetails({
    required this.id,
    required this.transectionId,
    required this.userName,
    required this.transectionAmount,
    required this.senderName,
    // this.transectionDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transectionId': transectionId,
      'userName': userName,
      'senderName': senderName,
      'transectionAmount': transectionAmount,
      // 'transectionDone': transectionDone,
    };
  }
}
