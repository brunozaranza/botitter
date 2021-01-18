import 'package:bottiter/core/model/user.dart';
import 'package:bottiter/core/viewmodel/login_viewmodel.dart';
import 'package:bottiter/ui/custom_widget/bot_text_form_field.dart';
import 'package:bottiter/ui/page/bottom_navigation_bar_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final redirect;

  RegisterPage({this.redirect});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _textEditingControllerName = TextEditingController();
  final _textEditingControllerEmail = TextEditingController();
  final _textEditingControllerPassword = TextEditingController();

  LoginViewModel _loginViewModel;

  @override
  Widget build(BuildContext context) {
    final _focusEmail = FocusNode();
    final _focusPassword = FocusNode();

    _loginViewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Registre-se"),
      ),
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
                        BotTextFormField(
                          label: 'Nome',
                          hint: 'Digite seu nome completo',
                          controller: _textEditingControllerName,
                          icon: Icons.account_circle,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          nextFocus: _focusEmail,
                          validator: (name) {
                            return name.isEmpty
                                ? "Digite um nome válido"
                                : null;
                          },
                        ),
                        SizedBox(height: 10),
                        BotTextFormField(
                          label: 'E-mail',
                          hint: 'Digite seu e-mail',
                          controller: _textEditingControllerEmail,
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          focusNode: _focusEmail,
                          nextFocus: _focusPassword,
                          validator: (email) {
                            final bool isEmailValid = EmailValidator.validate(
                                _textEditingControllerEmail.text);

                            return isEmailValid
                                ? null
                                : "Digite um e-mail válido";
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
                            if (password.isEmpty) return "Digite uma senha";

                            if (password.length < 6)
                              return "Senha deve 6 dígitos ou mais";

                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        _buildLoginBtn(),
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

  _buildLoginBtn() {
    if (isLoading) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: CircularProgressIndicator(
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
          'REGISTRAR',
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

  showMessageDialog(String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(title: Text(msg), actions: [
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ]);
        });
  }

  void _onPressedLoginBtn() {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      setState(() {
        isLoading = true;
      });

      _loginViewModel.fetchUser(_textEditingControllerEmail.text).then((user) {

        if(user!=null){
          setState(() {
            isLoading = false;
          });
          showMessageDialog("Este e-mail já foi cadastrado por alguém. Tente um outro.");
        }
        else {
          _loginViewModel.addUser(User(
              name: _textEditingControllerName.text,
              email: _textEditingControllerEmail.text))
              .then((user) {
            setState(() {
              isLoading = false;
            });
            Navigator.pop(context, user);
          });
        }
      });


    }
  }
}
