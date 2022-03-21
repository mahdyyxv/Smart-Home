
_clr:

;SLAVE FIRMWARE.c,47 :: 		void clr(){
;SLAVE FIRMWARE.c,48 :: 		memset(BUFFER, 0, 17);
	MOVLW       _BUFFER+0
	MOVWF       FARG_memset_p1+0 
	MOVLW       hi_addr(_BUFFER+0)
	MOVWF       FARG_memset_p1+1 
	CLRF        FARG_memset_character+0 
	MOVLW       17
	MOVWF       FARG_memset_n+0 
	MOVLW       0
	MOVWF       FARG_memset_n+1 
	CALL        _memset+0, 0
;SLAVE FIRMWARE.c,49 :: 		}
	RETURN      0
; end of _clr

_play:

;SLAVE FIRMWARE.c,51 :: 		void play(){
;SLAVE FIRMWARE.c,52 :: 		Relay_1 = 1;
	BSF         PORTB+0, 1 
;SLAVE FIRMWARE.c,53 :: 		Relay_2 = 1;
	BSF         PORTB+0, 0 
;SLAVE FIRMWARE.c,54 :: 		Relay_3 = 1;
	BSF         PORTC+0, 5 
;SLAVE FIRMWARE.c,55 :: 		Relay_4 = 1;
	BSF         PORTC+0, 4 
;SLAVE FIRMWARE.c,56 :: 		Relay_5 = 1;
	BSF         PORTC+0, 3 
;SLAVE FIRMWARE.c,57 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_play0:
	DECFSZ      R13, 1, 0
	BRA         L_play0
	DECFSZ      R12, 1, 0
	BRA         L_play0
	NOP
	NOP
;SLAVE FIRMWARE.c,58 :: 		Relay_1 = 0;
	BCF         PORTB+0, 1 
;SLAVE FIRMWARE.c,59 :: 		Relay_2 = 0;
	BCF         PORTB+0, 0 
;SLAVE FIRMWARE.c,60 :: 		Relay_3 = 0;
	BCF         PORTC+0, 5 
;SLAVE FIRMWARE.c,61 :: 		Relay_4 = 0;
	BCF         PORTC+0, 4 
;SLAVE FIRMWARE.c,62 :: 		Relay_5 = 0;
	BCF         PORTC+0, 3 
;SLAVE FIRMWARE.c,63 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_play1:
	DECFSZ      R13, 1, 0
	BRA         L_play1
	DECFSZ      R12, 1, 0
	BRA         L_play1
	NOP
	NOP
;SLAVE FIRMWARE.c,65 :: 		}
	RETURN      0
; end of _play

_recv:

;SLAVE FIRMWARE.c,67 :: 		void recv(){
;SLAVE FIRMWARE.c,68 :: 		if(UART1_Data_Ready()==1){
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_recv2
;SLAVE FIRMWARE.c,69 :: 		Uart1_read_text(BUFFER,"B",17);
	MOVLW       _BUFFER+0
	MOVWF       FARG_UART1_Read_Text_Output+0 
	MOVLW       hi_addr(_BUFFER+0)
	MOVWF       FARG_UART1_Read_Text_Output+1 
	MOVLW       ?lstr1_SLAVE_32FIRMWARE+0
	MOVWF       FARG_UART1_Read_Text_Delimiter+0 
	MOVLW       hi_addr(?lstr1_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_UART1_Read_Text_Delimiter+1 
	MOVLW       17
	MOVWF       FARG_UART1_Read_Text_Attempts+0 
	CALL        _UART1_Read_Text+0, 0
;SLAVE FIRMWARE.c,70 :: 		}
L_recv2:
;SLAVE FIRMWARE.c,71 :: 		}
	RETURN      0
; end of _recv

_GT:

;SLAVE FIRMWARE.c,73 :: 		void GT(){
;SLAVE FIRMWARE.c,74 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,75 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_GT3:
	DECFSZ      R13, 1, 0
	BRA         L_GT3
	DECFSZ      R12, 1, 0
	BRA         L_GT3
	NOP
	NOP
;SLAVE FIRMWARE.c,76 :: 		lcd_out(1,1,"Alarm");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,77 :: 		}
	RETURN      0
; end of _GT

_conv:

;SLAVE FIRMWARE.c,80 :: 		void conv(unsigned int t,char x){
;SLAVE FIRMWARE.c,81 :: 		char txt[6]="000";
	MOVLW       48
	MOVWF       conv_txt_L0+0 
	MOVLW       48
	MOVWF       conv_txt_L0+1 
	MOVLW       48
	MOVWF       conv_txt_L0+2 
	CLRF        conv_txt_L0+3 
	CLRF        conv_txt_L0+4 
	CLRF        conv_txt_L0+5 
;SLAVE FIRMWARE.c,82 :: 		txt[0]= (t/100%10)+  48;
	MOVLW       100
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_conv_t+0, 0 
	MOVWF       R0 
	MOVF        FARG_conv_t+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       conv_txt_L0+0 
;SLAVE FIRMWARE.c,83 :: 		txt[1]= (t/10%10)+  48;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_conv_t+0, 0 
	MOVWF       R0 
	MOVF        FARG_conv_t+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       conv_txt_L0+1 
;SLAVE FIRMWARE.c,84 :: 		txt[2]= (t/1%10)+  48;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        FARG_conv_t+0, 0 
	MOVWF       R0 
	MOVF        FARG_conv_t+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R9, 0 
	MOVWF       R1 
	MOVLW       48
	ADDWF       R0, 0 
	MOVWF       conv_txt_L0+2 
;SLAVE FIRMWARE.c,85 :: 		lcd_out(x,7,txt);
	MOVF        FARG_conv_x+0, 0 
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       conv_txt_L0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(conv_txt_L0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,87 :: 		}
	RETURN      0
; end of _conv

_disp_status:

;SLAVE FIRMWARE.c,89 :: 		void disp_status(){
;SLAVE FIRMWARE.c,90 :: 		lcd_out(1,1,"R1 R2 R3 R4 R5");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,91 :: 		if(state.f0 == 0){
	BTFSC       _state+0, 0 
	GOTO        L_disp_status4
;SLAVE FIRMWARE.c,92 :: 		lcd_out(2,1,"OFF");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,93 :: 		}
	GOTO        L_disp_status5
L_disp_status4:
;SLAVE FIRMWARE.c,95 :: 		lcd_out(2,1,"ON");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,96 :: 		}
L_disp_status5:
;SLAVE FIRMWARE.c,98 :: 		if(state.f1 == 0){
	BTFSC       _state+0, 1 
	GOTO        L_disp_status6
;SLAVE FIRMWARE.c,99 :: 		lcd_out(2,4,"OFF");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,100 :: 		}
	GOTO        L_disp_status7
L_disp_status6:
;SLAVE FIRMWARE.c,102 :: 		lcd_out(2,4,"ON");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,103 :: 		}
L_disp_status7:
;SLAVE FIRMWARE.c,105 :: 		if(state.f2 == 0){
	BTFSC       _state+0, 2 
	GOTO        L_disp_status8
;SLAVE FIRMWARE.c,106 :: 		lcd_out(2,7,"OFF");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,107 :: 		}
	GOTO        L_disp_status9
L_disp_status8:
;SLAVE FIRMWARE.c,109 :: 		lcd_out(2,7,"ON");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       7
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,110 :: 		}
L_disp_status9:
;SLAVE FIRMWARE.c,111 :: 		if(state.f3 == 0){
	BTFSC       _state+0, 3 
	GOTO        L_disp_status10
;SLAVE FIRMWARE.c,112 :: 		lcd_out(2,10,"OFF");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,113 :: 		}
	GOTO        L_disp_status11
L_disp_status10:
;SLAVE FIRMWARE.c,115 :: 		lcd_out(2,10,"ON");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,116 :: 		}
L_disp_status11:
;SLAVE FIRMWARE.c,117 :: 		if(state.f4 == 0){
	BTFSC       _state+0, 4 
	GOTO        L_disp_status12
;SLAVE FIRMWARE.c,118 :: 		lcd_out(2,13,"OFF");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       13
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr12_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr12_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,119 :: 		}
	GOTO        L_disp_status13
L_disp_status12:
;SLAVE FIRMWARE.c,121 :: 		lcd_out(2,13,"ON");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       13
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr13_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr13_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,122 :: 		}
L_disp_status13:
;SLAVE FIRMWARE.c,123 :: 		}
	RETURN      0
; end of _disp_status

_to_send:

;SLAVE FIRMWARE.c,124 :: 		void to_send(char x){
;SLAVE FIRMWARE.c,125 :: 		for(i = 0; i < 11; i++){
	CLRF        _i+0 
	CLRF        _i+1 
L_to_send14:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__to_send176
	MOVLW       11
	SUBWF       _i+0, 0 
L__to_send176:
	BTFSC       STATUS+0, 0 
	GOTO        L_to_send15
;SLAVE FIRMWARE.c,126 :: 		if(i == 9){tosend[i] = x;continue;}
	MOVLW       0
	XORWF       _i+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__to_send177
	MOVLW       9
	XORWF       _i+0, 0 
L__to_send177:
	BTFSS       STATUS+0, 2 
	GOTO        L_to_send17
	MOVLW       _tosend+0
	ADDWF       _i+0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_tosend+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR1H 
	MOVF        FARG_to_send_x+0, 0 
	MOVWF       POSTINC1+0 
	GOTO        L_to_send16
L_to_send17:
;SLAVE FIRMWARE.c,127 :: 		else if(i == 10 ){tosend[i] = 'B';}
	MOVLW       0
	XORWF       _i+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__to_send178
	MOVLW       10
	XORWF       _i+0, 0 
L__to_send178:
	BTFSS       STATUS+0, 2 
	GOTO        L_to_send19
	MOVLW       _tosend+0
	ADDWF       _i+0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_tosend+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR1H 
	MOVLW       66
	MOVWF       POSTINC1+0 
	GOTO        L_to_send20
L_to_send19:
;SLAVE FIRMWARE.c,128 :: 		else{tosend[i] = i+48;}
	MOVLW       _tosend+0
	ADDWF       _i+0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_tosend+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	ADDWF       _i+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_to_send20:
;SLAVE FIRMWARE.c,129 :: 		}
L_to_send16:
;SLAVE FIRMWARE.c,125 :: 		for(i = 0; i < 11; i++){
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;SLAVE FIRMWARE.c,129 :: 		}
	GOTO        L_to_send14
L_to_send15:
;SLAVE FIRMWARE.c,130 :: 		rcen_bit=0;
	BCF         RCEN_bit+0, 3 
;SLAVE FIRMWARE.c,131 :: 		UART1_WRITE_TEXT(tosend);
	MOVLW       _tosend+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_tosend+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;SLAVE FIRMWARE.c,132 :: 		rcen_bit=1;
	BSF         RCEN_bit+0, 3 
;SLAVE FIRMWARE.c,133 :: 		}
	RETURN      0
; end of _to_send

_show_ip:

;SLAVE FIRMWARE.c,134 :: 		void show_ip(){
;SLAVE FIRMWARE.c,135 :: 		for(i=0;i<17;i++){
	CLRF        _i+0 
	CLRF        _i+1 
L_show_ip21:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__show_ip179
	MOVLW       17
	SUBWF       _i+0, 0 
L__show_ip179:
	BTFSC       STATUS+0, 0 
	GOTO        L_show_ip22
;SLAVE FIRMWARE.c,136 :: 		if(Buffer[i] == 'A'){break;}
	MOVLW       _BUFFER+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_BUFFER+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       65
	BTFSS       STATUS+0, 2 
	GOTO        L_show_ip24
	GOTO        L_show_ip22
L_show_ip24:
;SLAVE FIRMWARE.c,137 :: 		hello[i]= BUFFER[i];
	MOVLW       _hello+0
	ADDWF       _i+0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_hello+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR1H 
	MOVLW       _BUFFER+0
	ADDWF       _i+0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_BUFFER+0)
	ADDWFC      _i+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
;SLAVE FIRMWARE.c,135 :: 		for(i=0;i<17;i++){
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;SLAVE FIRMWARE.c,138 :: 		}
	GOTO        L_show_ip21
L_show_ip22:
;SLAVE FIRMWARE.c,139 :: 		lcd_out(1,1,"This is IP:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr14_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,140 :: 		lcd_out(2,1,hello);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _hello+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_hello+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,141 :: 		}
	RETURN      0
; end of _show_ip

_check_status:

;SLAVE FIRMWARE.c,142 :: 		void check_status(){
;SLAVE FIRMWARE.c,143 :: 		temp_res = ADC_Read(0)/2.048;
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _Word2Double+0, 0
	MOVLW       111
	MOVWF       R4 
	MOVLW       18
	MOVWF       R5 
	MOVLW       3
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       _temp_res+0 
	MOVF        R1, 0 
	MOVWF       _temp_res+1 
;SLAVE FIRMWARE.c,144 :: 		gas_int = (ADC_Read(1)/1023.)*200.;
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _Word2Double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       192
	MOVWF       R5 
	MOVLW       127
	MOVWF       R6 
	MOVLW       136
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Int+0, 0
	MOVF        R0, 0 
	MOVWF       _gas_int+0 
	MOVF        R1, 0 
	MOVWF       _gas_int+1 
;SLAVE FIRMWARE.c,145 :: 		if(gas_int >= 100){
	MOVLW       128
	XORWF       R1, 0 
	MOVWF       R2 
	MOVLW       128
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_status180
	MOVLW       100
	SUBWF       R0, 0 
L__check_status180:
	BTFSS       STATUS+0, 0 
	GOTO        L_check_status25
;SLAVE FIRMWARE.c,146 :: 		GT();
	CALL        _GT+0, 0
;SLAVE FIRMWARE.c,147 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_check_status26:
	DECFSZ      R13, 1, 0
	BRA         L_check_status26
	DECFSZ      R12, 1, 0
	BRA         L_check_status26
	DECFSZ      R11, 1, 0
	BRA         L_check_status26
;SLAVE FIRMWARE.c,148 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,149 :: 		lcd_out(1,1,"HIGH GAS INTENS");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr15_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr15_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,150 :: 		delay_ms(1000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_check_status27:
	DECFSZ      R13, 1, 0
	BRA         L_check_status27
	DECFSZ      R12, 1, 0
	BRA         L_check_status27
	DECFSZ      R11, 1, 0
	BRA         L_check_status27
	NOP
;SLAVE FIRMWARE.c,151 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,152 :: 		}
L_check_status25:
;SLAVE FIRMWARE.c,153 :: 		if(temp_res >= 40){
	MOVLW       128
	XORWF       _temp_res+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__check_status181
	MOVLW       40
	SUBWF       _temp_res+0, 0 
L__check_status181:
	BTFSS       STATUS+0, 0 
	GOTO        L_check_status28
;SLAVE FIRMWARE.c,154 :: 		GT();
	CALL        _GT+0, 0
;SLAVE FIRMWARE.c,155 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_check_status29:
	DECFSZ      R13, 1, 0
	BRA         L_check_status29
	DECFSZ      R12, 1, 0
	BRA         L_check_status29
	DECFSZ      R11, 1, 0
	BRA         L_check_status29
;SLAVE FIRMWARE.c,156 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,157 :: 		lcd_out(1,1,"HIGH TEMP");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr16_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr16_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,158 :: 		delay_ms(1000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_check_status30:
	DECFSZ      R13, 1, 0
	BRA         L_check_status30
	DECFSZ      R12, 1, 0
	BRA         L_check_status30
	DECFSZ      R11, 1, 0
	BRA         L_check_status30
	NOP
;SLAVE FIRMWARE.c,159 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,160 :: 		}
L_check_status28:
;SLAVE FIRMWARE.c,161 :: 		}
	RETURN      0
; end of _check_status

_interrupt:

;SLAVE FIRMWARE.c,162 :: 		void interrupt(){
;SLAVE FIRMWARE.c,163 :: 		recv();
	CALL        _recv+0, 0
;SLAVE FIRMWARE.c,164 :: 		if(T0IF_bit==1){
	BTFSS       T0IF_bit+0, 2 
	GOTO        L_interrupt31
;SLAVE FIRMWARE.c,165 :: 		TMR0L = 100;
	MOVLW       100
	MOVWF       TMR0L+0 
;SLAVE FIRMWARE.c,166 :: 		T0IF_BIT = 0;
	BCF         T0IF_bit+0, 2 
;SLAVE FIRMWARE.c,167 :: 		}
L_interrupt31:
;SLAVE FIRMWARE.c,168 :: 		if((button_R1 == 0) || (BUFFER[10] == 'Q')){state.f5 =~state.f5;}
	BTFSS       PORTA+0, 4 
	GOTO        L__interrupt156
	MOVF        _BUFFER+10, 0 
	XORLW       81
	BTFSC       STATUS+0, 2 
	GOTO        L__interrupt156
	GOTO        L_interrupt34
L__interrupt156:
	BTG         _state+0, 5 
L_interrupt34:
;SLAVE FIRMWARE.c,169 :: 		if((button_R2 == 0) || (BUFFER[10] == 'W')){state.f6 =~state.f6;}
	BTFSS       PORTA+0, 5 
	GOTO        L__interrupt155
	MOVF        _BUFFER+10, 0 
	XORLW       87
	BTFSC       STATUS+0, 2 
	GOTO        L__interrupt155
	GOTO        L_interrupt37
L__interrupt155:
	BTG         _state+0, 6 
L_interrupt37:
;SLAVE FIRMWARE.c,172 :: 		}
L__interrupt182:
	RETFIE      1
; end of _interrupt

_main:

;SLAVE FIRMWARE.c,180 :: 		void main() {
;SLAVE FIRMWARE.c,183 :: 		ADCON1= 0x04;
	MOVLW       4
	MOVWF       ADCON1+0 
;SLAVE FIRMWARE.c,184 :: 		ADC_INIT();
	CALL        _ADC_Init+0, 0
;SLAVE FIRMWARE.c,190 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;SLAVE FIRMWARE.c,191 :: 		TRISA = 0x3B;
	MOVLW       59
	MOVWF       TRISA+0 
;SLAVE FIRMWARE.c,192 :: 		TRISC = 0x87;
	MOVLW       135
	MOVWF       TRISC+0 
;SLAVE FIRMWARE.c,197 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;SLAVE FIRMWARE.c,198 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,199 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,200 :: 		Lcd_Out(1,1,"SmartRoom ....");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr17_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr17_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,201 :: 		Lcd_Out(2,3,"DESGINED BY: ** AHMED MAHDY ** ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       3
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr18_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr18_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,202 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main38:
	DECFSZ      R13, 1, 0
	BRA         L_main38
	DECFSZ      R12, 1, 0
	BRA         L_main38
	DECFSZ      R11, 1, 0
	BRA         L_main38
;SLAVE FIRMWARE.c,203 :: 		for(i=0; i<20; i++) {
	CLRF        _i+0 
	CLRF        _i+1 
L_main39:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main183
	MOVLW       20
	SUBWF       _i+0, 0 
L__main183:
	BTFSC       STATUS+0, 0 
	GOTO        L_main40
;SLAVE FIRMWARE.c,204 :: 		Lcd_Cmd(_LCD_SHIFT_LEFT);
	MOVLW       24
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,205 :: 		delay_MS(400);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main42:
	DECFSZ      R13, 1, 0
	BRA         L_main42
	DECFSZ      R12, 1, 0
	BRA         L_main42
	DECFSZ      R11, 1, 0
	BRA         L_main42
	NOP
;SLAVE FIRMWARE.c,203 :: 		for(i=0; i<20; i++) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;SLAVE FIRMWARE.c,206 :: 		}
	GOTO        L_main39
L_main40:
;SLAVE FIRMWARE.c,207 :: 		play();
	CALL        _play+0, 0
;SLAVE FIRMWARE.c,208 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main43:
	DECFSZ      R13, 1, 0
	BRA         L_main43
	DECFSZ      R12, 1, 0
	BRA         L_main43
	NOP
	NOP
;SLAVE FIRMWARE.c,210 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,216 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW       103
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;SLAVE FIRMWARE.c,217 :: 		Delay_ms(100);            // Wait for UART module to stabilize
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main44:
	DECFSZ      R13, 1, 0
	BRA         L_main44
	DECFSZ      R12, 1, 0
	BRA         L_main44
	DECFSZ      R11, 1, 0
	BRA         L_main44
;SLAVE FIRMWARE.c,222 :: 		TMR0L= 0;
	CLRF        TMR0L+0 
;SLAVE FIRMWARE.c,223 :: 		INTCON =  0xA0;
	MOVLW       160
	MOVWF       INTCON+0 
;SLAVE FIRMWARE.c,224 :: 		T0CON = 0xC8;
	MOVLW       200
	MOVWF       T0CON+0 
;SLAVE FIRMWARE.c,225 :: 		state.f5 = 0;
	BCF         _state+0, 5 
;SLAVE FIRMWARE.c,226 :: 		state.f6 = 0;
	BCF         _state+0, 6 
;SLAVE FIRMWARE.c,227 :: 		delay_Ms(200);
	MOVLW       5
	MOVWF       R11, 0
	MOVLW       15
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main45:
	DECFSZ      R13, 1, 0
	BRA         L_main45
	DECFSZ      R12, 1, 0
	BRA         L_main45
	DECFSZ      R11, 1, 0
	BRA         L_main45
;SLAVE FIRMWARE.c,233 :: 		while(1){
L_main46:
;SLAVE FIRMWARE.c,241 :: 		check_status();
	CALL        _check_status+0, 0
;SLAVE FIRMWARE.c,246 :: 		if(((BUFFER[12] == 'A')||(BUFFER[13] == 'A')||(BUFFER[14] == 'A')||(BUFFER[15] == 'A')) && (state.f5 ==  0)) {
	MOVF        _BUFFER+12, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L__main175
	MOVF        _BUFFER+13, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L__main175
	MOVF        _BUFFER+14, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L__main175
	MOVF        _BUFFER+15, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L__main175
	GOTO        L_main52
L__main175:
	BTFSC       _state+0, 5 
	GOTO        L_main52
L__main174:
;SLAVE FIRMWARE.c,247 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,248 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main53:
	DECFSZ      R13, 1, 0
	BRA         L_main53
	DECFSZ      R12, 1, 0
	BRA         L_main53
	NOP
	NOP
;SLAVE FIRMWARE.c,249 :: 		if(((BUFFER[12] == 'A')||(BUFFER[13] == 'A')||(BUFFER[14] == 'A')||(BUFFER[15] == 'A')) && (state.f5 ==  0)){
	MOVF        _BUFFER+12, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L__main173
	MOVF        _BUFFER+13, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L__main173
	MOVF        _BUFFER+14, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L__main173
	MOVF        _BUFFER+15, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L__main173
	GOTO        L_main58
L__main173:
	BTFSC       _state+0, 5 
	GOTO        L_main58
L__main172:
;SLAVE FIRMWARE.c,250 :: 		label:
___main_label:
;SLAVE FIRMWARE.c,251 :: 		rcen_bit=0;
	BCF         RCEN_bit+0, 3 
;SLAVE FIRMWARE.c,252 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main59:
	DECFSZ      R13, 1, 0
	BRA         L_main59
	DECFSZ      R12, 1, 0
	BRA         L_main59
	NOP
	NOP
;SLAVE FIRMWARE.c,253 :: 		show_ip();
	CALL        _show_ip+0, 0
;SLAVE FIRMWARE.c,254 :: 		rcen_bit=1;
	BSF         RCEN_bit+0, 3 
;SLAVE FIRMWARE.c,255 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main60:
	DECFSZ      R13, 1, 0
	BRA         L_main60
	DECFSZ      R12, 1, 0
	BRA         L_main60
	NOP
	NOP
;SLAVE FIRMWARE.c,256 :: 		while(((BUFFER[12] == 'A')||(BUFFER[13] == 'A')||(BUFFER[14] == 'A')||(BUFFER[15] == 'A')) && (state.f5 ==  0)){check_status();goto label;}
	MOVF        _BUFFER+12, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L__main171
	MOVF        _BUFFER+13, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L__main171
	MOVF        _BUFFER+14, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L__main171
	MOVF        _BUFFER+15, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L__main171
	GOTO        L_main62
L__main171:
	BTFSC       _state+0, 5 
	GOTO        L_main62
L__main170:
	CALL        _check_status+0, 0
	GOTO        ___main_label
L_main62:
;SLAVE FIRMWARE.c,257 :: 		clr();
	CALL        _clr+0, 0
;SLAVE FIRMWARE.c,258 :: 		}
L_main58:
;SLAVE FIRMWARE.c,259 :: 		}
L_main52:
;SLAVE FIRMWARE.c,261 :: 		if((BUFFER[10] == 'D') && (state.f6 == 0)){
	MOVF        _BUFFER+10, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_main69
	BTFSC       _state+0, 6 
	GOTO        L_main69
L__main169:
;SLAVE FIRMWARE.c,262 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,263 :: 		if((BUFFER[10] == 'D') && (state.f6 == 0)){
	MOVF        _BUFFER+10, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_main72
	BTFSC       _state+0, 6 
	GOTO        L_main72
L__main168:
;SLAVE FIRMWARE.c,264 :: 		labeL1:
___main_labeL1:
;SLAVE FIRMWARE.c,265 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main73:
	DECFSZ      R13, 1, 0
	BRA         L_main73
	DECFSZ      R12, 1, 0
	BRA         L_main73
	DECFSZ      R11, 1, 0
	BRA         L_main73
;SLAVE FIRMWARE.c,266 :: 		lcd_out(1,1,"Temp: ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr19_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr19_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,267 :: 		conv(temp_res,1);
	MOVF        _temp_res+0, 0 
	MOVWF       FARG_conv_t+0 
	MOVF        _temp_res+1, 0 
	MOVWF       FARG_conv_t+1 
	MOVLW       1
	MOVWF       FARG_conv_x+0 
	CALL        _conv+0, 0
;SLAVE FIRMWARE.c,268 :: 		Lcd_Chr_Cp(223);
	MOVLW       223
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;SLAVE FIRMWARE.c,269 :: 		lcd_out(1,12,"C");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr20_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr20_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,270 :: 		lcd_out(2,1,"GAS : ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr21_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr21_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,271 :: 		conv(gas_int,2);
	MOVF        _gas_int+0, 0 
	MOVWF       FARG_conv_t+0 
	MOVF        _gas_int+1, 0 
	MOVWF       FARG_conv_t+1 
	MOVLW       2
	MOVWF       FARG_conv_x+0 
	CALL        _conv+0, 0
;SLAVE FIRMWARE.c,272 :: 		lcd_out(2,11,"%");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr22_SLAVE_32FIRMWARE+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr22_SLAVE_32FIRMWARE+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;SLAVE FIRMWARE.c,273 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       8
	MOVWF       R12, 0
	MOVLW       119
	MOVWF       R13, 0
L_main74:
	DECFSZ      R13, 1, 0
	BRA         L_main74
	DECFSZ      R12, 1, 0
	BRA         L_main74
	DECFSZ      R11, 1, 0
	BRA         L_main74
;SLAVE FIRMWARE.c,274 :: 		while((BUFFER[10] == 'D') && (state.f6 == 0)){check_status();goto labeL1;}
	MOVF        _BUFFER+10, 0 
	XORLW       68
	BTFSS       STATUS+0, 2 
	GOTO        L_main76
	BTFSC       _state+0, 6 
	GOTO        L_main76
L__main167:
	CALL        _check_status+0, 0
	GOTO        ___main_labeL1
L_main76:
;SLAVE FIRMWARE.c,275 :: 		clr();
	CALL        _clr+0, 0
;SLAVE FIRMWARE.c,276 :: 		}
L_main72:
;SLAVE FIRMWARE.c,277 :: 		}
	GOTO        L_main79
L_main69:
;SLAVE FIRMWARE.c,282 :: 		disp_status();
	CALL        _disp_status+0, 0
;SLAVE FIRMWARE.c,284 :: 		if((button_R1 == 0) || (BUFFER[10] == 'Q')){
	BTFSS       PORTA+0, 4 
	GOTO        L__main166
	MOVF        _BUFFER+10, 0 
	XORLW       81
	BTFSC       STATUS+0, 2 
	GOTO        L__main166
	GOTO        L_main82
L__main166:
;SLAVE FIRMWARE.c,285 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main83:
	DECFSZ      R13, 1, 0
	BRA         L_main83
	DECFSZ      R12, 1, 0
	BRA         L_main83
	NOP
	NOP
;SLAVE FIRMWARE.c,286 :: 		if((button_R1 == 0) || (BUFFER[10] == 'Q')){
	BTFSS       PORTA+0, 4 
	GOTO        L__main165
	MOVF        _BUFFER+10, 0 
	XORLW       81
	BTFSC       STATUS+0, 2 
	GOTO        L__main165
	GOTO        L_main86
L__main165:
;SLAVE FIRMWARE.c,287 :: 		clr();
	CALL        _clr+0, 0
;SLAVE FIRMWARE.c,288 :: 		state.f0 =~ state.f0;
	BTG         _state+0, 0 
;SLAVE FIRMWARE.c,289 :: 		disp_status();
	CALL        _disp_status+0, 0
;SLAVE FIRMWARE.c,290 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main87:
	DECFSZ      R13, 1, 0
	BRA         L_main87
	DECFSZ      R12, 1, 0
	BRA         L_main87
	NOP
	NOP
;SLAVE FIRMWARE.c,291 :: 		Relay_1 = state.f0;
	BTFSC       _state+0, 0 
	GOTO        L__main184
	BCF         PORTB+0, 1 
	GOTO        L__main185
L__main184:
	BSF         PORTB+0, 1 
L__main185:
;SLAVE FIRMWARE.c,292 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main88:
	DECFSZ      R13, 1, 0
	BRA         L_main88
	DECFSZ      R12, 1, 0
	BRA         L_main88
	NOP
	NOP
;SLAVE FIRMWARE.c,293 :: 		if(state.f0 == 1){
	BTFSS       _state+0, 0 
	GOTO        L_main89
;SLAVE FIRMWARE.c,294 :: 		portA.f2 = 1;
	BSF         PORTA+0, 2 
;SLAVE FIRMWARE.c,295 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main90:
	DECFSZ      R13, 1, 0
	BRA         L_main90
	DECFSZ      R12, 1, 0
	BRA         L_main90
	DECFSZ      R11, 1, 0
	BRA         L_main90
	NOP
;SLAVE FIRMWARE.c,296 :: 		to_send('A');
	MOVLW       65
	MOVWF       FARG_to_send_x+0 
	CALL        _to_send+0, 0
;SLAVE FIRMWARE.c,297 :: 		portA.f2 = 0;
	BCF         PORTA+0, 2 
;SLAVE FIRMWARE.c,298 :: 		}
	GOTO        L_main91
L_main89:
;SLAVE FIRMWARE.c,300 :: 		portA.f2 = 1;
	BSF         PORTA+0, 2 
;SLAVE FIRMWARE.c,301 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main92:
	DECFSZ      R13, 1, 0
	BRA         L_main92
	DECFSZ      R12, 1, 0
	BRA         L_main92
	DECFSZ      R11, 1, 0
	BRA         L_main92
	NOP
;SLAVE FIRMWARE.c,302 :: 		to_send('B');
	MOVLW       66
	MOVWF       FARG_to_send_x+0 
	CALL        _to_send+0, 0
;SLAVE FIRMWARE.c,303 :: 		portA.f2 = 0;
	BCF         PORTA+0, 2 
;SLAVE FIRMWARE.c,304 :: 		}
L_main91:
;SLAVE FIRMWARE.c,305 :: 		while(button_R1 == 0){}
L_main93:
	BTFSC       PORTA+0, 4 
	GOTO        L_main94
	GOTO        L_main93
L_main94:
;SLAVE FIRMWARE.c,306 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,307 :: 		clr();
	CALL        _clr+0, 0
;SLAVE FIRMWARE.c,308 :: 		}
L_main86:
;SLAVE FIRMWARE.c,310 :: 		}
L_main82:
;SLAVE FIRMWARE.c,311 :: 		if((button_R2 == 0) || (BUFFER[10] == 'W')){
	BTFSS       PORTA+0, 5 
	GOTO        L__main164
	MOVF        _BUFFER+10, 0 
	XORLW       87
	BTFSC       STATUS+0, 2 
	GOTO        L__main164
	GOTO        L_main97
L__main164:
;SLAVE FIRMWARE.c,312 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main98:
	DECFSZ      R13, 1, 0
	BRA         L_main98
	DECFSZ      R12, 1, 0
	BRA         L_main98
	NOP
	NOP
;SLAVE FIRMWARE.c,313 :: 		if((button_R2 == 0) || (BUFFER[10] == 'W')){
	BTFSS       PORTA+0, 5 
	GOTO        L__main163
	MOVF        _BUFFER+10, 0 
	XORLW       87
	BTFSC       STATUS+0, 2 
	GOTO        L__main163
	GOTO        L_main101
L__main163:
;SLAVE FIRMWARE.c,314 :: 		clr();
	CALL        _clr+0, 0
;SLAVE FIRMWARE.c,315 :: 		state.f1 =~ state.f1;
	BTG         _state+0, 1 
;SLAVE FIRMWARE.c,316 :: 		disp_status();
	CALL        _disp_status+0, 0
;SLAVE FIRMWARE.c,317 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main102:
	DECFSZ      R13, 1, 0
	BRA         L_main102
	DECFSZ      R12, 1, 0
	BRA         L_main102
	NOP
	NOP
;SLAVE FIRMWARE.c,318 :: 		Relay_2 = state.f1;
	BTFSC       _state+0, 1 
	GOTO        L__main186
	BCF         PORTB+0, 0 
	GOTO        L__main187
L__main186:
	BSF         PORTB+0, 0 
L__main187:
;SLAVE FIRMWARE.c,319 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main103:
	DECFSZ      R13, 1, 0
	BRA         L_main103
	DECFSZ      R12, 1, 0
	BRA         L_main103
	NOP
	NOP
;SLAVE FIRMWARE.c,320 :: 		if(state.f1 == 1){
	BTFSS       _state+0, 1 
	GOTO        L_main104
;SLAVE FIRMWARE.c,321 :: 		portA.f2 = 1;
	BSF         PORTA+0, 2 
;SLAVE FIRMWARE.c,322 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main105:
	DECFSZ      R13, 1, 0
	BRA         L_main105
	DECFSZ      R12, 1, 0
	BRA         L_main105
	DECFSZ      R11, 1, 0
	BRA         L_main105
	NOP
;SLAVE FIRMWARE.c,323 :: 		to_send('C');
	MOVLW       67
	MOVWF       FARG_to_send_x+0 
	CALL        _to_send+0, 0
;SLAVE FIRMWARE.c,324 :: 		portA.f2 = 0;
	BCF         PORTA+0, 2 
;SLAVE FIRMWARE.c,325 :: 		}
	GOTO        L_main106
L_main104:
;SLAVE FIRMWARE.c,327 :: 		portA.f2 = 1;
	BSF         PORTA+0, 2 
;SLAVE FIRMWARE.c,328 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main107:
	DECFSZ      R13, 1, 0
	BRA         L_main107
	DECFSZ      R12, 1, 0
	BRA         L_main107
	DECFSZ      R11, 1, 0
	BRA         L_main107
	NOP
;SLAVE FIRMWARE.c,329 :: 		to_send('D');
	MOVLW       68
	MOVWF       FARG_to_send_x+0 
	CALL        _to_send+0, 0
;SLAVE FIRMWARE.c,330 :: 		portA.f2 = 0;
	BCF         PORTA+0, 2 
;SLAVE FIRMWARE.c,331 :: 		}
L_main106:
;SLAVE FIRMWARE.c,332 :: 		while(button_R2 == 0){}
L_main108:
	BTFSC       PORTA+0, 5 
	GOTO        L_main109
	GOTO        L_main108
L_main109:
;SLAVE FIRMWARE.c,333 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,334 :: 		clr();
	CALL        _clr+0, 0
;SLAVE FIRMWARE.c,335 :: 		}
L_main101:
;SLAVE FIRMWARE.c,336 :: 		}
L_main97:
;SLAVE FIRMWARE.c,337 :: 		if((button_R3 == 0) || (BUFFER[10] == 'E')){
	BTFSS       PORTC+0, 0 
	GOTO        L__main162
	MOVF        _BUFFER+10, 0 
	XORLW       69
	BTFSC       STATUS+0, 2 
	GOTO        L__main162
	GOTO        L_main112
L__main162:
;SLAVE FIRMWARE.c,338 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main113:
	DECFSZ      R13, 1, 0
	BRA         L_main113
	DECFSZ      R12, 1, 0
	BRA         L_main113
	NOP
	NOP
;SLAVE FIRMWARE.c,339 :: 		if((button_R3 == 0) || (BUFFER[10] == 'E')){
	BTFSS       PORTC+0, 0 
	GOTO        L__main161
	MOVF        _BUFFER+10, 0 
	XORLW       69
	BTFSC       STATUS+0, 2 
	GOTO        L__main161
	GOTO        L_main116
L__main161:
;SLAVE FIRMWARE.c,340 :: 		state.f2 =~ state.f2;
	BTG         _state+0, 2 
;SLAVE FIRMWARE.c,341 :: 		disp_status();
	CALL        _disp_status+0, 0
;SLAVE FIRMWARE.c,342 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main117:
	DECFSZ      R13, 1, 0
	BRA         L_main117
	DECFSZ      R12, 1, 0
	BRA         L_main117
	NOP
	NOP
;SLAVE FIRMWARE.c,343 :: 		Relay_3 = state.f2;
	BTFSC       _state+0, 2 
	GOTO        L__main188
	BCF         PORTC+0, 5 
	GOTO        L__main189
L__main188:
	BSF         PORTC+0, 5 
L__main189:
;SLAVE FIRMWARE.c,344 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main118:
	DECFSZ      R13, 1, 0
	BRA         L_main118
	DECFSZ      R12, 1, 0
	BRA         L_main118
	NOP
	NOP
;SLAVE FIRMWARE.c,345 :: 		if(state.f2 == 1){
	BTFSS       _state+0, 2 
	GOTO        L_main119
;SLAVE FIRMWARE.c,346 :: 		portA.f2 = 1;
	BSF         PORTA+0, 2 
;SLAVE FIRMWARE.c,347 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main120:
	DECFSZ      R13, 1, 0
	BRA         L_main120
	DECFSZ      R12, 1, 0
	BRA         L_main120
	DECFSZ      R11, 1, 0
	BRA         L_main120
	NOP
;SLAVE FIRMWARE.c,348 :: 		to_send('E');
	MOVLW       69
	MOVWF       FARG_to_send_x+0 
	CALL        _to_send+0, 0
;SLAVE FIRMWARE.c,349 :: 		portA.f2 = 0;
	BCF         PORTA+0, 2 
;SLAVE FIRMWARE.c,350 :: 		}
	GOTO        L_main121
L_main119:
;SLAVE FIRMWARE.c,352 :: 		portA.f2 = 1;
	BSF         PORTA+0, 2 
;SLAVE FIRMWARE.c,353 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main122:
	DECFSZ      R13, 1, 0
	BRA         L_main122
	DECFSZ      R12, 1, 0
	BRA         L_main122
	DECFSZ      R11, 1, 0
	BRA         L_main122
	NOP
;SLAVE FIRMWARE.c,354 :: 		to_send('F');
	MOVLW       70
	MOVWF       FARG_to_send_x+0 
	CALL        _to_send+0, 0
;SLAVE FIRMWARE.c,355 :: 		portA.f2 = 0;
	BCF         PORTA+0, 2 
;SLAVE FIRMWARE.c,356 :: 		}
L_main121:
;SLAVE FIRMWARE.c,357 :: 		while(button_R3 == 0){}
L_main123:
	BTFSC       PORTC+0, 0 
	GOTO        L_main124
	GOTO        L_main123
L_main124:
;SLAVE FIRMWARE.c,358 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,359 :: 		clr();
	CALL        _clr+0, 0
;SLAVE FIRMWARE.c,360 :: 		}
L_main116:
;SLAVE FIRMWARE.c,361 :: 		}
L_main112:
;SLAVE FIRMWARE.c,362 :: 		if((button_R4==0) || (BUFFER[10] == 'R')){
	BTFSS       PORTC+0, 1 
	GOTO        L__main160
	MOVF        _BUFFER+10, 0 
	XORLW       82
	BTFSC       STATUS+0, 2 
	GOTO        L__main160
	GOTO        L_main127
L__main160:
;SLAVE FIRMWARE.c,363 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main128:
	DECFSZ      R13, 1, 0
	BRA         L_main128
	DECFSZ      R12, 1, 0
	BRA         L_main128
	NOP
	NOP
;SLAVE FIRMWARE.c,364 :: 		if((button_R4==0) || (BUFFER[10] == 'R')){
	BTFSS       PORTC+0, 1 
	GOTO        L__main159
	MOVF        _BUFFER+10, 0 
	XORLW       82
	BTFSC       STATUS+0, 2 
	GOTO        L__main159
	GOTO        L_main131
L__main159:
;SLAVE FIRMWARE.c,365 :: 		state.f3 =~ state.f3;
	BTG         _state+0, 3 
;SLAVE FIRMWARE.c,366 :: 		disp_status();
	CALL        _disp_status+0, 0
;SLAVE FIRMWARE.c,367 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main132:
	DECFSZ      R13, 1, 0
	BRA         L_main132
	DECFSZ      R12, 1, 0
	BRA         L_main132
	NOP
	NOP
;SLAVE FIRMWARE.c,368 :: 		Relay_4 = state.f3;
	BTFSC       _state+0, 3 
	GOTO        L__main190
	BCF         PORTC+0, 4 
	GOTO        L__main191
L__main190:
	BSF         PORTC+0, 4 
L__main191:
;SLAVE FIRMWARE.c,369 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main133:
	DECFSZ      R13, 1, 0
	BRA         L_main133
	DECFSZ      R12, 1, 0
	BRA         L_main133
	NOP
	NOP
;SLAVE FIRMWARE.c,370 :: 		if(state.f3 == 0){
	BTFSC       _state+0, 3 
	GOTO        L_main134
;SLAVE FIRMWARE.c,371 :: 		portA.f2 = 1;
	BSF         PORTA+0, 2 
;SLAVE FIRMWARE.c,372 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main135:
	DECFSZ      R13, 1, 0
	BRA         L_main135
	DECFSZ      R12, 1, 0
	BRA         L_main135
	DECFSZ      R11, 1, 0
	BRA         L_main135
	NOP
;SLAVE FIRMWARE.c,373 :: 		to_send('G');
	MOVLW       71
	MOVWF       FARG_to_send_x+0 
	CALL        _to_send+0, 0
;SLAVE FIRMWARE.c,374 :: 		portA.f2 = 0;
	BCF         PORTA+0, 2 
;SLAVE FIRMWARE.c,375 :: 		}
	GOTO        L_main136
L_main134:
;SLAVE FIRMWARE.c,377 :: 		portA.f2 = 1;
	BSF         PORTA+0, 2 
;SLAVE FIRMWARE.c,378 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main137:
	DECFSZ      R13, 1, 0
	BRA         L_main137
	DECFSZ      R12, 1, 0
	BRA         L_main137
	DECFSZ      R11, 1, 0
	BRA         L_main137
	NOP
;SLAVE FIRMWARE.c,379 :: 		to_send('H');
	MOVLW       72
	MOVWF       FARG_to_send_x+0 
	CALL        _to_send+0, 0
;SLAVE FIRMWARE.c,380 :: 		portA.f2 = 0;
	BCF         PORTA+0, 2 
;SLAVE FIRMWARE.c,381 :: 		}
L_main136:
;SLAVE FIRMWARE.c,382 :: 		while(button_R4==0){}
L_main138:
	BTFSC       PORTC+0, 1 
	GOTO        L_main139
	GOTO        L_main138
L_main139:
;SLAVE FIRMWARE.c,383 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,384 :: 		clr();
	CALL        _clr+0, 0
;SLAVE FIRMWARE.c,385 :: 		}
L_main131:
;SLAVE FIRMWARE.c,386 :: 		}
L_main127:
;SLAVE FIRMWARE.c,387 :: 		if((button_R5 == 0)  || (BUFFER[10] == 'T')){
	BTFSS       PORTC+0, 2 
	GOTO        L__main158
	MOVF        _BUFFER+10, 0 
	XORLW       84
	BTFSC       STATUS+0, 2 
	GOTO        L__main158
	GOTO        L_main142
L__main158:
;SLAVE FIRMWARE.c,388 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main143:
	DECFSZ      R13, 1, 0
	BRA         L_main143
	DECFSZ      R12, 1, 0
	BRA         L_main143
	NOP
	NOP
;SLAVE FIRMWARE.c,389 :: 		if((button_R5 == 0)  || (BUFFER[10] == 'T')){
	BTFSS       PORTC+0, 2 
	GOTO        L__main157
	MOVF        _BUFFER+10, 0 
	XORLW       84
	BTFSC       STATUS+0, 2 
	GOTO        L__main157
	GOTO        L_main146
L__main157:
;SLAVE FIRMWARE.c,390 :: 		state.f4 =~ state.f4;
	BTG         _state+0, 4 
;SLAVE FIRMWARE.c,391 :: 		disp_status();
	CALL        _disp_status+0, 0
;SLAVE FIRMWARE.c,392 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main147:
	DECFSZ      R13, 1, 0
	BRA         L_main147
	DECFSZ      R12, 1, 0
	BRA         L_main147
	NOP
	NOP
;SLAVE FIRMWARE.c,393 :: 		Relay_5 = state.f4;
	BTFSC       _state+0, 4 
	GOTO        L__main192
	BCF         PORTC+0, 3 
	GOTO        L__main193
L__main192:
	BSF         PORTC+0, 3 
L__main193:
;SLAVE FIRMWARE.c,394 :: 		delay_ms(10);
	MOVLW       52
	MOVWF       R12, 0
	MOVLW       241
	MOVWF       R13, 0
L_main148:
	DECFSZ      R13, 1, 0
	BRA         L_main148
	DECFSZ      R12, 1, 0
	BRA         L_main148
	NOP
	NOP
;SLAVE FIRMWARE.c,395 :: 		if(state.f4 == 1){
	BTFSS       _state+0, 4 
	GOTO        L_main149
;SLAVE FIRMWARE.c,396 :: 		portA.f2 = 1;
	BSF         PORTA+0, 2 
;SLAVE FIRMWARE.c,397 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main150:
	DECFSZ      R13, 1, 0
	BRA         L_main150
	DECFSZ      R12, 1, 0
	BRA         L_main150
	DECFSZ      R11, 1, 0
	BRA         L_main150
	NOP
;SLAVE FIRMWARE.c,398 :: 		to_send('I');
	MOVLW       73
	MOVWF       FARG_to_send_x+0 
	CALL        _to_send+0, 0
;SLAVE FIRMWARE.c,399 :: 		portA.f2 = 0;
	BCF         PORTA+0, 2 
;SLAVE FIRMWARE.c,400 :: 		}
	GOTO        L_main151
L_main149:
;SLAVE FIRMWARE.c,402 :: 		portA.f2 = 1;
	BSF         PORTA+0, 2 
;SLAVE FIRMWARE.c,403 :: 		delay_ms(50);
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main152:
	DECFSZ      R13, 1, 0
	BRA         L_main152
	DECFSZ      R12, 1, 0
	BRA         L_main152
	DECFSZ      R11, 1, 0
	BRA         L_main152
	NOP
;SLAVE FIRMWARE.c,404 :: 		to_send('J');
	MOVLW       74
	MOVWF       FARG_to_send_x+0 
	CALL        _to_send+0, 0
;SLAVE FIRMWARE.c,405 :: 		portA.f2 = 0;
	BCF         PORTA+0, 2 
;SLAVE FIRMWARE.c,406 :: 		}
L_main151:
;SLAVE FIRMWARE.c,407 :: 		while(button_R5 == 0){}
L_main153:
	BTFSC       PORTC+0, 2 
	GOTO        L_main154
	GOTO        L_main153
L_main154:
;SLAVE FIRMWARE.c,408 :: 		lcd_cmd(_lcd_clear);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;SLAVE FIRMWARE.c,409 :: 		clr();
	CALL        _clr+0, 0
;SLAVE FIRMWARE.c,410 :: 		}
L_main146:
;SLAVE FIRMWARE.c,411 :: 		}
L_main142:
;SLAVE FIRMWARE.c,412 :: 		}
L_main79:
;SLAVE FIRMWARE.c,413 :: 		}
	GOTO        L_main46
;SLAVE FIRMWARE.c,414 :: 		}
	GOTO        $+0
; end of _main
