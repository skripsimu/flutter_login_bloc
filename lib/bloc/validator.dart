import 'dart:async';

class Validator {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
        if (email.contains('@') && email.contains('.com')) {
          sink.add(email);
        } else {
          sink.addError('Please nter a valid email');
        }
      }
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
        if (password.length >4 && password.length <12) {
          sink.add(password);
        } else {
          sink.addError('Your password must be between 4 and 12 characters');
        }
      }
  );
}
