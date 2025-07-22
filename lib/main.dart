import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:school/src/student/data/datasources/school_grahql/school_graphql.dart';

enum UserRole {
  STUDENT,
  INSTRUCTOR,
  ADMIN
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLConfig.client,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  final String getUsersQuery = """
    query GetUsers {
     users(role:STUDENT){
        userId
        username
        email
       }
    }
  """;

  final String createUser="""
    mutation AddUser(\$username:String!,\$email:String!,\$role:UserRole!,\$firstName:String!,\$lastName:String!,\$password:String!){
        createUser(input:{
                username:\$username,
                email:\$email,
                role:\$role,
                firstName:\$firstName,
                lastName:\$lastName,
                password:\$password
              }){
                userId
                username
                email
                firstName
                lastName
                role
                password
                lastLogin
                createAt
              }
           }
  """;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  UserRole? _selectedRole;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body:Subscription(
        options: SubscriptionOptions(
            document: gql(getUsersQuery)
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          List? users = result.data?['users'];

          if (users == null || users.isEmpty) {
            return const Text('No users found.');
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user['username']),
                subtitle: Text(user['email']),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Add User"),
                content: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child:Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildTextField(_usernameController, 'Username', validator: (value) {
                            if (value == null || value.isEmpty) return 'Please enter a username';
                            return null;
                          }),
                          const SizedBox(height: 16),
                          _buildTextField(_emailController, 'Email', keyboardType: TextInputType.emailAddress, validator: (value) {
                            if (value == null || value.isEmpty) return 'Please enter an email';
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Enter a valid email';
                            return null;
                          }),
                          const SizedBox(height: 16),
                          _buildTextField(_firstNameController, 'First Name', validator: (value) {
                            if (value == null || value.isEmpty) return 'Please enter first name';
                            return null;
                          }),
                          const SizedBox(height: 16),
                          _buildTextField(_lastNameController, 'Last Name', validator: (value) {
                            if (value == null || value.isEmpty) return 'Please enter last name';
                            return null;
                          }),
                          const SizedBox(height: 16),
                          _buildTextField(_passwordController, 'Password', obscureText: true, validator: (value) {
                            if (value == null || value.isEmpty) return 'Please enter a password';
                            if (value.length < 6) return 'Password must be at least 6 characters';
                            return null;
                          }),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<UserRole>(
                            value: _selectedRole,
                            decoration: InputDecoration(
                              labelText: 'Role',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            hint: const Text('Select a role'),
                            items: UserRole.values.map((UserRole role) {
                              return DropdownMenuItem<UserRole>(
                                value: role,
                                child: Text(role.toString().split('.').last), // Display enum name nicely
                              );
                            }).toList(),
                            onChanged: (UserRole? newValue) {
                              setState(() {
                                _selectedRole = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null) return 'Please select a role';
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          Mutation(
                            options: MutationOptions(
                              document: gql(createUser),
                              onCompleted: (dynamic resultData) {
                                // Handle successful mutation
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('User "${resultData?['createUser']['username']}" created successfully!')),
                                );
                                Navigator.of(context).pop(); // Close the dialog
                                // Optionally, refetch data on the previous screen
                                // This assumes MyHomePage uses a Query widget that can be refetched
                                // For automatic updates, you might rely on pollInterval or cache updates.
                              },
                              onError: (OperationException? error) {
                                // Handle error
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error creating user: ${error.toString()}', style: TextStyle(color: Colors.white))),
                                );
                              },
                            ),
                            builder: (RunMutation runMutation, QueryResult? result) {
                              return ElevatedButton(
                                onPressed: result!.isLoading
                                    ? null // Disable button while loading
                                    : () {
                                  if (_formKey.currentState!.validate()) {
                                    runMutation({
                                      'username': _usernameController.text,
                                      'email': _emailController.text,
                                      'role': _selectedRole!.toString().split('.').last, // Pass enum as its string name
                                      'firstName': _firstNameController.text,
                                      'lastName': _lastNameController.text,
                                      'password': _passwordController.text,
                                    });
                                  }
                                },
                                child: result.isLoading
                                    ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                    : const Text('Create User'),
                              );
                            },
                          ),
                        ],
                      )
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text("okay"),
                  ),
                ],
              ),
            );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }




  Widget _buildTextField(TextEditingController controller, String label, {bool obscureText = false, TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}