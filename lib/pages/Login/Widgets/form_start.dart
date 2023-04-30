import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/models/regsiter_response.dart';
import 'package:frontend_tesis_glp/pages/cliente.dart';
import 'package:frontend_tesis_glp/pages/distribuidor.dart';
import 'package:frontend_tesis_glp/pages/ubicacion.dart';
import 'package:frontend_tesis_glp/services/request.dart';
import 'package:frontend_tesis_glp/utils/local_storage.dart';
import 'package:frontend_tesis_glp/utils/responsive.dart';
import 'package:frontend_tesis_glp/widgets/input_text_login.dart';
import 'package:frontend_tesis_glp/widgets/roudend_button.dart';

class formStart extends StatefulWidget {
  const formStart({super.key});

  @override
  State<formStart> createState() => _formStartState();
}

class _formStartState extends State<formStart> {
  final RequestHttp requestHttp = RequestHttp();
  final localStorage localstorage = localStorage();

  final GlobalKey<InputTextState> phoneKeyText = GlobalKey();
  final GlobalKey<InputTextState> codeKeyText = GlobalKey();

  bool _showCodeInput = false;
  bool _showButton = true;
  bool _showTimer = false;
  int _timerSeconds = 60;
  Timer? _timer;

  _startTimer() {
    _timerSeconds = 10;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          _timer!.cancel();
          _showTimer = false;
        }
      });
    });
  }

  _submit() async {
    String? phoneText = phoneKeyText.currentState!.value;
    try {
      RegisterResult response = await requestHttp.register(phoneText!);
      if (response.statusCode == 200) {
        setState(() {
          _showCodeInput = true;
          _showButton = false;
          _showTimer = true;
          // _timerSeconds = 60;
        });
        _startTimer();
      } else {}

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  _verifyCode() async {
    String? codeText = codeKeyText.currentState!.value;
    try {
      print('haciendos');
      RegisterResult response = await requestHttp.verifyCode(codeText!);
      if (response.statusCode == 200) {
        // Usuario ya registrado
        // print(object)
        if (response.typeUser == 'Distribuidor') {
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DistribuidorPage()));
        } else {
          // ignore: use_build_context_synchronously
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ClientePage()));
        }

        localstorage.guardarToken(response.token!);
      } else if (response.statusCode == 201) {
        // Usuario nuevo
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ubicacion()));
        localstorage.guardarToken(response.token!);
      } else {
        // hacer algo si hay otro tipo de error
      }
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  _resendCode() async {
    _startTimer();
    _submit();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    return Container(
      padding: EdgeInsets.all(responsive.width * 0.05),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '+593',
                style: TextStyle(
                  fontSize: responsive.width * 0.04,
                ),
              ),
              SizedBox(width: responsive.width * 0.01),
              Expanded(
                child: InputText(
                  key: phoneKeyText,
                  label: 'Teléfono',
                  textInputType: TextInputType.phone,
                  size: responsive.width,
                  enabled: _showCodeInput ? false : true,
                ),
              )
            ],
          ),
          SizedBox(height: responsive.height * 0.02),
          Visibility(
            visible: _showCodeInput,
            child: InputText(
              key: codeKeyText,
              label: 'Código de verificación',
              textInputType: TextInputType.phone,
              size: responsive.width,
              onChange: (value) {
                if (value.length == 6) {
                  _verifyCode();
                }
              },
            ),
          ),
          SizedBox(height: responsive.height * 0.02),
          Column(
            children: [
              Visibility(
                visible: _showCodeInput && _timerSeconds > 1 ? true : false,
                child: Column(
                  children: [
                    Text(
                      'Puede solicitar un código nuevamente en ',
                      style: TextStyle(
                        fontSize: responsive.width * 0.03,
                      ),
                    ),
                    Text(
                      '$_timerSeconds segundos',
                      style: TextStyle(
                        fontSize: responsive.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    width: responsive.width * 0.7,
                    child: Center(
                      child: Visibility(
                        visible: _timerSeconds < 1,
                        child: TextButton(
                          onPressed: _resendCode,
                          child: Text(
                            'Reenviar código',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: responsive.height * 0.03),
          Visibility(
            visible: _showButton,
            child: RoundedButton(
              onPressed: _submit,
              label: 'Siguiente',
              backgroundColor: Color(0xFFA72138),
              size: responsive.width,
            ),
          ),
        ],
      ),
    );
  }
}
