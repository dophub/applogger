class DopLoggerUser {
  DopLoggerUser({
    this.id,
    this.username,
    this.email,
    this.ipAddress,
  });

  /// A unique identifier of the user.
  final String? id;

  /// The username of the user.
  final String? username;

  /// The email address of the user.
  final String? email;

  /// The IP of the user.
  final String? ipAddress;

  /// Produces a [Map] that can be serialized to JSON.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (ipAddress != null) 'ip_address': ipAddress,
    };
  }
}
