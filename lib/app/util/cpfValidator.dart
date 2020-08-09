class CPFValidator {
  static bool validate(String cpf){
    try {
      if(cpf == null || cpf.trim().isEmpty || cpf.length <= 10 ) return false;
      List cpfSplit = cpf.split('');
      int counter = 10;
      int repeat  = 0;
      int verifyDigit1  = 0;
      int verifyDigit2  = 0;

      for(var i =1; i< cpfSplit.length; i++) {
        if(cpfSplit[i] == cpfSplit[i-1]) repeat++;
      } // for(var i =0; i<= cpfSplit.length; i++) { .. }

      if(repeat >= 4) return false;

      for (var i = 0; i < 9; i++) {
        verifyDigit1 = verifyDigit1 + (int.parse(cpfSplit[i]) * counter);
        counter --;
      } // for (var i = 0; i < 9; i++) { ... }

      verifyDigit1  = ((verifyDigit1*10)%11);

      if(verifyDigit1.toString() != cpfSplit[9]) return false;

      // Envia o counter para 11
      counter  = 11;
      for (var i = 0; i <= 9; i++) {
        verifyDigit2 = verifyDigit2 + (int.parse(cpfSplit[i]) * counter);
        counter --;
      } // for (var i = 0; i < 9; i++) { ... }

      verifyDigit2  = ((verifyDigit2*10)%11);
      if(verifyDigit2.toString() != cpfSplit[10]) return false;

      return true;
    }
    catch(error) {
      print(error);
      return false;
    }
  } // static bool validate(String cpf){ ... }
}