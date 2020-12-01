import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ApiClient {
  static const _baseUrl = "http://localhost:8080/graphql";

  Future<CreateUserResult> createUser({
    @required final String name,
    @required final String email,
  }) async {
    final createUserMutation = '''
       { "query": "mutation { getOrCreateUser(record: {name: \\"$name\\", email: \\"$email\\"}) { _id, name, streamToken }}" }
    ''';

    final http.Response response = await http.post(
      _baseUrl,
      body: createUserMutation,
      headers: {
        "Content-Type": "application/json",
        'combase-organization': 'Your-Combase-Key'
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body)['data']['getOrCreateUser'];
      return CreateUserResult.fromMap(result);
    } else {
      throw StateError("Combase api returned invalid status code");
    }
  }

  Future<String> retrieveOrganizationApiKey({
    String combaseOrganizationKey = "Your-combase-key",
  }) async {
    final query =
        '{"query":" query {organizationById(_id: \\"$combaseOrganizationKey\\") {stream {key}}}"}';

    final http.Response response = await http.post(
      _baseUrl,
      body: query,
      headers: {
        "Content-Type": "application/json",
        'combase-organization': combaseOrganizationKey
      },
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body)['data']['organizationById']
          ['stream']['key'];
      return result;
    } else {
      throw StateError("Combase api returned invalid status code");
    }
  }

  Future<Client> configureUser({
    @required final String streamAPIKey,
    @required final String userId,
    @required final String userJWT,
    @required final String name,
  }) async {
    try {
      final streamClient = Client(streamAPIKey);
      streamClient.setUser(
        User(
          id: userId,
          extraData: {
            "name": name,
          },
        ),
        userJWT,
      );
      return streamClient;
    } catch (error) {
      print(error?.toString());
      throw Exception("Error initializing Stream SDK.");
    }
  }

  /// Returns channel id.
  Future<String> createTicket({
    @required final String combaseOrganizationKey,
    @required final String userId,
  }) async {
    try {
      final query =
          '{"query":"mutation {createTicket( user: \\"$userId\\", ){ agents status createdAt _id }}"}';
      final http.Response response = await http.post(
        _baseUrl,
        body: query,
        headers: {
          "Content-Type": "application/json",
          'combase-organization': combaseOrganizationKey,
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body)['data']['createTicket']['_id'];
        return result;
      } else {
        throw StateError("Something went wrong.");
      }
    } catch (error) {
      print(error);
      throw Exception("Error creating ticket for $userId.");
    }
  }
}

class CreateUserResult {
  CreateUserResult({this.userId, this.name, this.streamToken});

  final String userId;
  final String name;
  final String streamToken;

  factory CreateUserResult.fromMap(Map<String, dynamic> map) {
    return CreateUserResult(
      userId: map['_id'],
      name: map['name'],
      streamToken: map['streamToken'],
    );
  }
}
