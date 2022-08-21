public class InwiB2C_RandomValuePinCode {
public String generator(){

//System.debug(randomNumber);

   
 Integer   randomNumber = Integer.valueof((Math.random() * 10000));
 String  PinCode = String.valueOf(randomNumber);
   System.debug(PinCode);
     return PinCode;
}}