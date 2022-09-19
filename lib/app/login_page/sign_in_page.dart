import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/app/login_page/sign_in_manager.dart';
import 'package:flutter_steps_tracker/services/auth.dart';
import 'package:flutter_steps_tracker/utils/colors.dart';
import 'package:flutter_steps_tracker/utils/show_snack_bar.dart';
import 'package:flutter_steps_tracker/widgets/loading_screen.dart';
import 'package:flutter_steps_tracker/widgets/text_field_input.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    Key? key,
    required this.manager,
    required this.isLoading,
  }) : super(key: key);
  final SignInManager manager;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (context, manager, _) => SignInPage(
              isLoading: isLoading.value,
              manager: manager,
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _nameController = TextEditingController();
  String get _name => _nameController.text;

  Future<void> _signInAnonymously() async {
    if (_name.length < 5) {
      showSnackBar(context, "Your name should be at lease 5 characters long");
      return;
    } else if (_name.length > 15) {
      showSnackBar(context, "Your name shouldn't exceed 15 characters");
      return;
    }
    try {
      await widget.manager.signInAnonymously(_name);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Widget _buildHeader() {
    if (widget.isLoading) {
      return const LoadingScreen();
    } else {
      return const Text(
        'Sign in page',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 50.0,
            child: _buildHeader(),
          ),
          const SizedBox(height: 48.0),
          TextFieldInput(
            onEditingComplete:
                widget.isLoading ? null : () => _signInAnonymously(),
            hintText: 'Enter your name',
            textInputType: TextInputType.text,
            textEditingController: _nameController,
            isEnabled: widget.isLoading ? false : true,
          ),
          const SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: widget.isLoading ? null : () => _signInAnonymously(),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: ShapeDecoration(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                color: widget.isLoading ? secondaryColor : cardBackground,
              ),
              child: const Text(
                'Log in',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
      resizeToAvoidBottomInset: false,
    );
  }
}
