import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udemy_flutter_delivery/src/models/user.dart';
import 'package:udemy_flutter_delivery/src/providers/users_provider.dart';

class RegisterController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // Controlador para el estado del checkbox
  RxBool isTermsAccepted = false.obs;
  RxBool isPasswordVisible = true.obs; // Inicialmente la contraseña está oculta
  UsersProvider usersProvider = UsersProvider();

  //Metodo que disparara al servidor para validar la base de datos
  void register() async{//Este sera un metodo asincronico para que sea ejecutado solo cuando sea necesario
    //Capturamos con un string los datos que ingrese el usuario
    String email = emailController.text.trim();//El metodo trim es para que no permita bits vacios es decir no aceptara el espacio como dato
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    //Para mostrar en pantalla (Consola) lo que ponga el usuario
    print("email$email");
    print("password$password");


    if (isValidForm(email,name,lastName,phone, password,confirmPassword)){
      User user = User(
        email: email,
        name : name,
        lastName: lastName,
        phone: phone,
        password: password,
      );
      Response response = await usersProvider.create(user);
      print("Respuesta ${response.body}");
      Get.snackbar("Formualrio valido", "Estas listo para enviar la peticion http");
    }

  }
  //Crearemos un metodo que retone un booleano que preguntara si el form es valido obtendremos por paramotro los 2 string
  bool  isValidForm(String email,String name,String lastName,String phone, String password,String confirmPassword){
    if (email.isEmpty){//Si el email esta vacio entonces
      Get.snackbar("Fomulario no valido", "Debes ingrear el Email");
      return false;//Retornamos false despues de mostrado el mensaje
    }
    if (!GetUtils.isEmail(email)){//Esta condicion viene de Get y valida si el campo es de tipo email por ejemplo con la pregunta "Si no es un email el campo email entonces..."
      Get.snackbar("Formulario no valido", "EL email no es valido");
      return false;//Retornamos false despues de mostrado el mensaje
    }
    if (name.isEmpty){//Si el dato esta vacio entonces
      Get.snackbar("Fomulario no valido", "Debes ingrear el nombre");
      return false;//Retornamos false despues de mostrado el mensaje
    }
    if (lastName.isEmpty){//Si el dato esta vacio entonces
      Get.snackbar("Fomulario no valido", "Debes ingrear tu apellido/s");
      return false;//Retornamos false despues de mostrado el mensaje
    }
    if (phone.isEmpty){//Si el dato esta vacio entonces
      Get.snackbar("Fomulario no valido", "Debes ingrear tu numero de telefono");
      return false;//Retornamos false despues de mostrado el mensaje
    }
    if (password.isEmpty){//Si el dato esta vacio entonces
      Get.snackbar("Fomulario no valido", "Debes ingrear el password");
      return false;//Retornamos false despues de mostrado el mensaje
    }
    if (confirmPassword.isEmpty){//Si el dato esta vacio entonces
      Get.snackbar("Fomulario no valido", "Debes ingrear la confirmacion del password");
      return false;//Retornamos false despues de mostrado el mensaje
    }
    //Necesitamos validar que la clave al momento de registrarse sea la misma que ha decladrado como password confirm
    if (password != confirmPassword) {//La validacion quedaria asi "Si password es diferente de confirmpassword entonces...// "
        Get.snackbar("Formulario no valido","Las contraseñas no coinciden");
        return false;

    }
    if (!isTermsAccepted.value) {
      Get.snackbar('Error', 'Debes aceptar los términos y condiciones.');
      return false;
    }
    return true;
  }

}




