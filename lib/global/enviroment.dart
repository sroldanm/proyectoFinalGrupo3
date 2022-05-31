import 'dart:io';

class Environment {

static String apiUrl = Platform.isAndroid ? 'https://api2analisis.azurewebsites.net/api/Servicios'
: 'https://api2analisis.azurewebsites.net/api/Servicios';
}