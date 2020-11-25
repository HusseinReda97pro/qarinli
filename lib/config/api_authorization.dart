import 'dart:convert';

const username = 'ck_f10ea57f3c106a8f392f25f3c8107c2c10aa89d4';
const password = 'cs_6b33c313f4248f69b78cc452acb89de9c611fba7';
String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
