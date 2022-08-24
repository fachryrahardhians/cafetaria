import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:cafetaria/feature/Authentication/bloc/link_email/link_email_bloc.dart';
import 'package:cafetaria/feature/Authentication/bloc/link_email/link_email_event.dart';
import 'package:cafetaria/feature/Authentication/bloc/link_email/link_email_state.dart';
import 'package:cafetaria/feature/Authentication/views/extend_page.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LinkEmailPage extends StatelessWidget {
  const LinkEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LinkEmailBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const LinkEmailPageView(),
    );
    // return const LinkEmailPageView();
  }
}

class LinkEmailPageView extends StatefulWidget {
  const LinkEmailPageView({Key? key}) : super(key: key);

  @override
  State<LinkEmailPageView> createState() => _LinkEmailPageViewState();
}

class _LinkEmailPageViewState extends State<LinkEmailPageView> {
  final TextEditingController _emailCont = TextEditingController();
  final TextEditingController _passwordCont = TextEditingController();

  bool showPassword = false;

  _togglePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextfield1(
            label: "Email",
            controller: _emailCont,
          ),
          CustomTextfield1(
            label: "Password",
            controller: _passwordCont,
            isObscure: !showPassword,
            suffix: InkWell(
              onTap: () {
                _togglePassword();
              },
              child: Icon(
                showPassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 16),
          BlocConsumer<LinkEmailBloc, LinkEmailState>(
            listener: (ctx, state) {
              if (state is LinkEmailSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => const HomePage(),
                    builder: (context) => const ExtendPage(),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is LinkEmailLoading) {
                return const SizedBox(
                  width: 100,
                  child: LinearProgressIndicator(),
                );
              }

              if (state is LinkEmailError) {
                final snackBar = SnackBar(
                  content: Text(state.error),
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              return InkWell(
                onTap: () {
                  ///todo : action link email to google
                  context.read<LinkEmailBloc>().add(DoEmailLink(
                      email: _emailCont.text, password: _passwordCont.text));
                },
                child: const Text(
                  "Sambungkan",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyColors.red2,
                      fontSize: 15,
                      letterSpacing: 1.2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
