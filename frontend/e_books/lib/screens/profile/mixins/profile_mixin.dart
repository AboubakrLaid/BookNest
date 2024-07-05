mixin ProfileMixin{
  
  String? validateFirstName(String? value){
    return _validateName(value, "First Name");
  }
  String? validateLastName(String? value){
    return _validateName(value, "Last Name");
  }

  String? _validateName(String? value, String inputName){
    if(value == null || value.isEmpty){
      return "$inputName is required";
    }else if(!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)){
      // also spaces are valid
      return "$inputName only accepts alphabets";
    }
    return null;
  }
}