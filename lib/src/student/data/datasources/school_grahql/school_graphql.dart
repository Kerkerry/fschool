import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(
    'https://5806cf7bf113.ngrok-free.app/graphql', // Replace with your GraphQL server URL
  );

  static WebSocketLink websocketLink = WebSocketLink(
    '', // Replace with your GraphQL WebSocket URL for subscriptions
  );

  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: Link.from([httpLink, websocketLink]), // Combine HTTP and WebSocket links
      cache: GraphQLCache(store: InMemoryStore()), // Or use HiveStore for persistent caching
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }
}

