class VerifyOTPModel{
 final String accountNumber;

 VerifyOTPModel(this.accountNumber);

 Map<String, dynamic> toJson() {
   return {
     'AccountNumber': accountNumber,
   };
 }
}