;este programa enciende o apaga un ledcada vez que se presiona un boton conectado a RE0
;este est� conectado a un resistor pull down
    
    
    LIST P=18F4550
    #INCLUDE <P18F4550.INC>
    
    #DEFINE BOTON   PORTE,RE0,0
    #DEFINE LED	    PORTD,RD1,0
    
    ORG .0
    
SETTINGS
    SETF    TRISE,0
    BCF	    TRISD,1,0
    MOVLW   .15
    MOVWF   ADCON1,0
    CLRF    PORTD,0
    CLRF    PORTE,0
    MOVLW   B'11010111'
    MOVWF   T0CON,0
    
MAIN
    BTFSC  PORTE,RE0,0   ;SE PREGUNTA SI EL BOT�N1 EST� en 0
    GOTO    DELAYPRENDE    
    BTFSC  PORTE,RE1,0   ;SE PREGUNTA SI EL BOT�N2 EST� en 0
    GOTO DELAYAPAGA
    GOTO MAIN
    
DELAYAPAGA
    CALL RETARDO
    BCF  PORTD,RD1,0
    BTFSS PORTE,RE1,0
    GOTO MAIN
    GOTO DELAYAPAGA
    
DELAYPRENDE
    CALL   RETARDO  ;ESPERAR 20mS PARA QUE TERMINE EL REBOTE
    BTFSS  PORTE,RE0,0    ;SE PREGUNTA SI EL BOTON SIGUE PRESIONADO
    GOTO  ACCIONPRENDE
    GOTO  DELAYPRENDE    ;VUELVE A PREGUNTAR HASTA QUE LO SUELTEN
    
ACCIONPRENDE
    BSF	    PORTD,RD1,0	    ;ENCIENDE EL LED SEGUN SEA EL CASO
    GOTO    MAIN    ;VUELVE A PREGUNTAR POR EL BOT�N
    
RETARDO
    CLRF    TMR0L,0 ;CUENTA DE 0 A 255, PORQUE ES A 8 BITS
    MOVLW   .15
    
ASK
    CPFSEQ  TMR0L,0 ;PREGUNTA SI W=15, VALE LO MISMO QUE TMR0L
    BRA	    ASK
    RETURN
    END




