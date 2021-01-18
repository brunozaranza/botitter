import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/core/viewmodel/login_viewmodel.dart';
import 'package:bottiter/ui/custom_widget/bot_text_form_field.dart';
import 'package:bottiter/ui/page/bottom_navigation_bar_page.dart';
import 'package:bottiter/ui/page/register_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final redirect;

  LoginPage({this.redirect});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginViewModel _viewModel;

  final _textEditingControllerLogin = TextEditingController();
  final _textEditingControllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {

    _viewModel = Provider.of<LoginViewModel>(context);

    final _focusPassword = FocusNode();

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(color: Colors.white),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 30.0,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.all(40.0),
                         child: Image(
                           height: 130.0,
                           image: AssetImage('assets/images/logo.png'),
                           fit: BoxFit.scaleDown,
                         ),
                       ),
                        BotTextFormField(
                          label: 'E-mail',
                          hint: 'Digite seu e-mail',
                          controller: _textEditingControllerLogin,
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          nextFocus: _focusPassword,
                          validator: (email) {
                            final bool isEmailValid = EmailValidator
                                .validate(_textEditingControllerLogin.text);

                            return isEmailValid ? null : "Digite um e-mail válido";
                          },
                        ),
                        SizedBox(height: 10.0),
                        BotTextFormField(
                          label: 'Senha',
                          hint: 'Digite sua senha',
                          controller: _textEditingControllerPassword,
                          password: true,
                          icon: Icons.lock,
                          focusNode: _focusPassword,
                          validator: (password) {
                            if (password.isEmpty)
                            return "Digite a senha";

                            if(password.length < 6)
                              return "Senha deve 6 dígitos ou mais";

                            return null;
                          },
                        ),
                        _buildForgotPasswordBtn(),
                        _buildRememberMeCheckbox(),
                        _buildLoginBtn(),
                        _buildSignUpBtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {},
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Esqueceu a senha?',
          style: TextStyle(
            color: Colors.grey.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black),
            child: Checkbox(
              value: _viewModel.rememberMe,
              checkColor: Colors.black,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _viewModel.rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Lembrar-me',
            style: TextStyle(
              color: Colors.grey.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _buildLoginBtn() {
    if (_viewModel.loading) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        )),
      );
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: _onPressedLoginBtn,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.orange,
        child: Text(
          'ENTRAR',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  _buildSignUpBtn() {
    return GestureDetector(
      onTap: () async {
        User user = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
        if(user!=null) showMessageDialog("Usuário cadastrado com sucesso");
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Ainda não tem conta?   ',
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Cadastre-se',
              style: TextStyle(
                color: Colors.grey.shade900,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  showMessageDialog(String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(msg),
              actions:[ FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),]
          );
        });
  }

  void _onPressedLoginBtn() {

    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      setState(() {
        _viewModel.loading = true;
      });
      _viewModel.fetchUser(_textEditingControllerLogin.text).then((user) {
        setState(() {
          _viewModel.loading = false;
        });
        if(user != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
            return BottomNavigationBarPage();
          }));
        } else {
          showMessageDialog("Usuário não encontrado");
        }
      });
    }
  }
}
