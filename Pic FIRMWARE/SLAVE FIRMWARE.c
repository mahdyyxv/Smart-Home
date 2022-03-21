//////////////////////////////////////////////  LCD module connections  //////////////////////////////////////////////

sbit LCD_RS at RB7_bit;
sbit LCD_EN at RB6_bit;
sbit LCD_D4 at RB5_bit;
sbit LCD_D5 at RB4_bit;
sbit LCD_D6 at RB3_bit;
sbit LCD_D7 at RB2_bit;

sbit LCD_RS_Direction at TRISB7_bit;
sbit LCD_EN_Direction at TRISB6_bit;
sbit LCD_D4_Direction at TRISB5_bit;
sbit LCD_D5_Direction at TRISB4_bit;
sbit LCD_D6_Direction at TRISB3_bit;
sbit LCD_D7_Direction at TRISB2_bit;

//////////////////////////////////////////////  END OF LCD module connections  //////////////////////////////////////////////

//////////////////////////////////////////////  DEFINITION  //////////////////////////////////////////////

#define button_R1 portA.f4
#define button_R2 portA.f5
#define button_R3 portC.f0
#define button_R4 portC.f1
#define button_R5 portC.f2

#define Relay_1 portB.f1
#define Relay_2 portB.f0
#define Relay_3 portC.f5
#define Relay_4 portC.f4
#define Relay_5 portC.f3

//////////////////////////////////////////////  END OF DEFINITION  //////////////////////////////////////////////


//////////////////////////////////////////////  DECLARING VARIABLES  //////////////////////////////////////////////

int temp_res, gas_int, i = 0, j = 0 , q = 0 , l = 0;
char state=0;
char tosend[10];
char swstate = 0;
char BUFFER[17];
char hello[17];
char label,labeL1;
//////////////////////////////////////////////  DEFINING FUNCTIONS  //////////////////////////////////////////////

void clr(){
  memset(BUFFER, 0, 17);
}

void play(){
     Relay_1 = 1;
     Relay_2 = 1;
     Relay_3 = 1;
     Relay_4 = 1;
     Relay_5 = 1;
     delay_ms(10);
     Relay_1 = 0;
     Relay_2 = 0;
     Relay_3 = 0;
     Relay_4 = 0;
     Relay_5 = 0;
     delay_ms(10);
     
}

void recv(){
      if(UART1_Data_Ready()==1){
          Uart1_read_text(BUFFER,"B",17);
      }
}

void GT(){
     lcd_cmd(_lcd_clear);
     delay_ms(10);
     lcd_out(1,1,"Alarm");
}


void conv(unsigned int t,char x){
     char txt[6]="000";
     txt[0]= (t/100%10)+  48;
     txt[1]= (t/10%10)+  48;
     txt[2]= (t/1%10)+  48;
     lcd_out(x,7,txt);

}

void disp_status(){
    lcd_out(1,1,"R1 R2 R3 R4 R5");
    if(state.f0 == 0){
      lcd_out(2,1,"OFF");
    }
    else{
      lcd_out(2,1,"ON");
    }

    if(state.f1 == 0){
      lcd_out(2,4,"OFF");
    }
    else{
      lcd_out(2,4,"ON");
    }

    if(state.f2 == 0){
      lcd_out(2,7,"OFF");
    }
    else{
      lcd_out(2,7,"ON");
    }
    if(state.f3 == 0){
      lcd_out(2,10,"OFF");
    }
    else{
      lcd_out(2,10,"ON");
    }
    if(state.f4 == 0){
      lcd_out(2,13,"OFF");
    }
    else{
      lcd_out(2,13,"ON");
    }
}
void to_send(char x){
   for(i = 0; i < 11; i++){
      if(i == 9){tosend[i] = x;continue;}
      else if(i == 10 ){tosend[i] = 'B';}
      else{tosend[i] = i+48;}
   }
   rcen_bit=0;
   UART1_WRITE_TEXT(tosend);
   rcen_bit=1;
}
void show_ip(){
   for(i=0;i<17;i++){
      if(Buffer[i] == 'A'){break;}
      hello[i]= BUFFER[i];
   }
   lcd_out(1,1,"This is IP:");
   lcd_out(2,1,hello);
}
void check_status(){
     temp_res = ADC_Read(0)/2.048;
     gas_int = (ADC_Read(1)/1023.)*200.;
     if(gas_int >= 100){
        GT();
        delay_ms(100);
        lcd_cmd(_lcd_clear);
        lcd_out(1,1,"HIGH GAS INTENS");
        delay_ms(1000);
        lcd_cmd(_lcd_clear);
     }
     if(temp_res >= 40){
        GT();
        delay_ms(100);
        lcd_cmd(_lcd_clear);
        lcd_out(1,1,"HIGH TEMP");
        delay_ms(1000);
        lcd_cmd(_lcd_clear);
     }
}
void interrupt(){
   recv();
   if(T0IF_bit==1){
     TMR0L = 100;
     T0IF_BIT = 0;
   }
   if((button_R1 == 0) || (BUFFER[10] == 'Q')){state.f5 =~state.f5;}
   if((button_R2 == 0) || (BUFFER[10] == 'W')){state.f6 =~state.f6;}


}


 //////////////////////////////////////////////  END OF FUNCTIONS DEFINTION  //////////////////////////////////////////////


 //////////////////////////////////////////////  SETUP FUNCTION  //////////////////////////////////////////////

void main() {
  // ADC INITILIZATION

  ADCON1= 0x04;
  ADC_INIT();

  //End of init

  // PORT SET

  TRISB = 0x00;
  TRISA = 0x3B;
  TRISC = 0x87;

  // END OF PORT SET

  // LCD INIT  
  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(1,1,"SmartRoom ....");
  Lcd_Out(2,3,"DESGINED BY: ** AHMED MAHDY ** ");
  delay_ms(100);
  for(i=0; i<20; i++) {
    Lcd_Cmd(_LCD_SHIFT_LEFT);
    delay_MS(400);
  }
  play();
  delay_ms(10);
  
  lcd_cmd(_lcd_clear);

  // END OF INIT

  //UART INIT

  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);            // Wait for UART module to stabilize
  //END OF INIT

  //INTERRUPT INIT

  TMR0L= 0;
  INTCON =  0xA0;
  T0CON = 0xC8;
  state.f5 = 0;
  state.f6 = 0;
  delay_Ms(200);
  
  //END OF INIT

          //////////////////////////////////////////////  MAIN LOOP  //////////////////////////////////////////////

  while(1){

     //////////////////////////////////////////////  READING TEMP and GAS  //////////////////////////////////////////////

     /* Reading now in Check_status function */

     //////////////////////////////////////////////  TAKING DECISION FOR ALARM  //////////////////////////////////////////////

     check_status();

     //////////////////////////////////////////////  DESSICIONS for BUFFER VALUE  //////////////////////////////////////////////


     if(((BUFFER[12] == 'A')||(BUFFER[13] == 'A')||(BUFFER[14] == 'A')||(BUFFER[15] == 'A')) && (state.f5 ==  0)) {
        lcd_cmd(_lcd_clear);
        delay_ms(10);
          if(((BUFFER[12] == 'A')||(BUFFER[13] == 'A')||(BUFFER[14] == 'A')||(BUFFER[15] == 'A')) && (state.f5 ==  0)){
              label:
              rcen_bit=0;
              delay_ms(10);
              show_ip();
              rcen_bit=1;
              delay_ms(10);
              while(((BUFFER[12] == 'A')||(BUFFER[13] == 'A')||(BUFFER[14] == 'A')||(BUFFER[15] == 'A')) && (state.f5 ==  0)){check_status();goto label;}
              clr();
          }
     }

     if((BUFFER[10] == 'D') && (state.f6 == 0)){
        lcd_cmd(_lcd_clear);
        if((BUFFER[10] == 'D') && (state.f6 == 0)){
              labeL1:
              delay_ms(100);
              lcd_out(1,1,"Temp: ");
              conv(temp_res,1);
              Lcd_Chr_Cp(223);
              lcd_out(1,12,"C");
              lcd_out(2,1,"GAS : ");
              conv(gas_int,2);
              lcd_out(2,11,"%");
              delay_ms(100);
              while((BUFFER[10] == 'D') && (state.f6 == 0)){check_status();goto labeL1;}
              clr();
        }
     }

     //////////////////////////////////////////////  BUTTONS  //////////////////////////////////////////////
     
     else{
       disp_status();
       
       if((button_R1 == 0) || (BUFFER[10] == 'Q')){
          delay_ms(10);
          if((button_R1 == 0) || (BUFFER[10] == 'Q')){
             clr();
             state.f0 =~ state.f0;
             disp_status();
             delay_ms(10);
             Relay_1 = state.f0;
             delay_ms(10);
             if(state.f0 == 1){
                portA.f2 = 1;
                delay_ms(50);
                to_send('A');
                portA.f2 = 0;
             }
             else{
                portA.f2 = 1;
                delay_ms(50);
                to_send('B');
                portA.f2 = 0;
             }
             while(button_R1 == 0){}
             lcd_cmd(_lcd_clear);
             clr();
          }
          
       }
       if((button_R2 == 0) || (BUFFER[10] == 'W')){
          delay_ms(10);
          if((button_R2 == 0) || (BUFFER[10] == 'W')){
             clr();
             state.f1 =~ state.f1;
             disp_status();
             delay_ms(10);
             Relay_2 = state.f1;
             delay_ms(10);
             if(state.f1 == 1){
                portA.f2 = 1;
                delay_ms(50);
                to_send('C');
                portA.f2 = 0;
             }
             else{
                portA.f2 = 1;
                delay_ms(50);
                to_send('D');
                portA.f2 = 0;
             }
             while(button_R2 == 0){}
             lcd_cmd(_lcd_clear);
             clr();
          }
       }
       if((button_R3 == 0) || (BUFFER[10] == 'E')){
          delay_ms(10);
          if((button_R3 == 0) || (BUFFER[10] == 'E')){
             state.f2 =~ state.f2;
             disp_status();
             delay_ms(10);
             Relay_3 = state.f2;
             delay_ms(10);
             if(state.f2 == 1){
                portA.f2 = 1;
                delay_ms(50);
                to_send('E');
                portA.f2 = 0;
             }
             else{
                portA.f2 = 1;
                delay_ms(50);
                to_send('F');
                portA.f2 = 0;
             }
             while(button_R3 == 0){}
             lcd_cmd(_lcd_clear);
             clr();
          }
       }
       if((button_R4==0) || (BUFFER[10] == 'R')){
          delay_ms(10);
          if((button_R4==0) || (BUFFER[10] == 'R')){
             state.f3 =~ state.f3;
             disp_status();
             delay_ms(10);
             Relay_4 = state.f3;
             delay_ms(10);
             if(state.f3 == 0){
                portA.f2 = 1;
                delay_ms(50);
                to_send('G');
                portA.f2 = 0;
             }
             else{
                portA.f2 = 1;
                delay_ms(50);
                to_send('H');
                portA.f2 = 0;
             }
             while(button_R4==0){}
             lcd_cmd(_lcd_clear);
             clr();
          }
       }
       if((button_R5 == 0)  || (BUFFER[10] == 'T')){
          delay_ms(10);
          if((button_R5 == 0)  || (BUFFER[10] == 'T')){
             state.f4 =~ state.f4;
             disp_status();
             delay_ms(10);
             Relay_5 = state.f4;
             delay_ms(10);
             if(state.f4 == 1){
                portA.f2 = 1;
                delay_ms(50);
                to_send('I');
                portA.f2 = 0;
             }
             else{
                portA.f2 = 1;
                delay_ms(50);
                to_send('J');
                portA.f2 = 0;
             }
             while(button_R5 == 0){}
             lcd_cmd(_lcd_clear);
             clr();
          }
       }
     }
   }
}