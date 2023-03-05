LIST P = 18F4550

#INCLUDE <P18F4550.INC>

CBLOCK H'00' ;CREAMOS LAS VARIABLES QUE GUARDARAN AL INFORMACION PARA LAS INTERRUCIONES
    WREGB
    STATUSB
    BSRB
    TMR0LB
    WREGA
    BSRA
    STATUSA
    TMR0LA
ENDC

ORG .0
GOTO SETTINGS

ORG .8
GOTO BACKUPA
    
ORG H'18'
GOTO BACKUPB

BACKUPB ;MOVEMOS ESA INFOMRACINO A LAS VARIABLES PARA DESPUES RETOMARLAS
    MOVFF WREG,WREGB
    MOVFF STATUS,STATUSB
    MOVFF BSR,BSRB
    MOVFF TMR0L,TMR0LB

ASKB
    BTFSS INTCON3,INT1IF ;�TU ME LLAMASTE?
    GOTO ASK2 ;MUEVETE A ASK2
    BCF INTCON3,INT1IF ;INICIA LA INTERUPCION
    MOVLW B'00101001' ;INTERRUPCION DE LA CARA
    MOVWF PORTD ;MOSTRAMOS LA CARA POR EL PUERTO D
    CALL DELAY ;LLAMAMOS AL DELAY
    CALL DELAY
    CALL DELAY
    CALL DELAY
    CALL DELAY
    CALL DELAY
    CALL DELAY
    CALL DELAY
    CALL DELAY
    CALL DELAY
    CLRF PORTD ;LIMPIAMOS AL PUERTO D
    
SALIR_INTB ;REGRESAMOS TODOS LOS VALORES ANTES DE QUE LA INTERRUPCION FUERA LLAMADA
    MOVFF WREGB,WREG
    MOVFF STATUSB,STATUS
    MOVFF BSRB,BSR
    MOVFF TMR0LB,TMR0L
    RETFIE
    
ASK2
    BTFSS INTCON3,INT2IF ;�ME LLAMASTE?
    BRA ASK1A ;MUEVETE A ASK1A
    BCF INTCON3,INT2IF ;INICIA LA INTERRUPCION
    MOVLW B'01111110' ;A
    MOVWF PORTD ;MOSTRAMOS LA A EN EL DISPLAY
    CALL DELAY ;LLAMAMOS AL DELAY
    CALL DELAY
    MOVLW B'01001111' ;d
    MOVWF PORTD ; MOSTRAMOS LA d EN EL DISPLAY
    CALL DELAY
    CALL DELAY
    MOVLW B'00100100' ;I
    MOVWF PORTD ; MOSTRAMOS LA I EN EL DISPLAY
    CALL DELAY
    CALL DELAY
    MOVLW B'00111111' ;O
    MOVWF PORTD ; MOSTRAMOS LA O EN EL DISPLAY
    CALL DELAY
    CALL DELAY
    MOVLW B'01110011';S
    MOVWF PORTD ; MOSTRAMOS LA S EN EL DISPLAY
    CALL DELAY
    CALL DELAY
    GOTO SALIR_INTA

BACKUPA ;GUARDAMOS LOS DATOS UN MOMENTO ANTES DE LA INTERRUPCION
    MOVFF WREG,WREGA
    MOVFF STATUS,STATUSA
    MOVFF BSR,BSRA
    MOVFF TMR0L,TMR0LA

ASK1A
    BTFSS INTCON,INT0IF ;�ME LLAMASTE?
    BRA SALIR_INTA ;MUEVETE A SALIR_INTA
    BCF INTCON,INT0IF ;COMIENSA LA INTERRUPCION
    BSF PORTC,0 ;PRENDE EL BIT0 DEL PUERTO C
    CALL DELAY ;LLAMAR A DELAY
    CALL DELAY
    CALL DELAY
    CALL DELAY
    CALL DELAY
    CALl DELAY
    CALL DELAY
    CALL DELAY
    BCF PORTC,0 ;APAGA EL BIT 0 DEL PUERTO C
    
SALIR_INTA ;REGRESA LOS DATOS UN MOMENTO ANTES DE QUE SE LLAMARA LA INTERRUPCION
    MOVFF WREGA,WREG
    MOVFF STATUSA,STATUS
    MOVFF BSRA,BSR
    MOVFF TMR0LA,TMR0L
    RETFIE
    
SETTINGS    
    CLRF PORTC ;LIMPIAMOS PUERTO C
    CLRF PORTB ;LIMPIAMOS PUERTO B
    CLRF PORTD ;LIMPIAMOS PUERTO D
    CLRF TRISC ;PUERTO C ES SALIDA
    SETF TRISB ;PUERTO B ES ENTRADA
    CLRF TRISD ;PUERTO D ES SALIDA
    MOVLW .15
    MOVWF ADCON1
    MOVLW .7
    MOVWF CMCON
    MOVLW B'11010111'
    MOVWF T0CON
    BSF RCON,IPEN    
    MOVLW B'11010000' ;CONFIGURAMO DE FORMA GENERAL LA SINTERRUPCIONES
    MOVWF INTCON
    MOVLW B'11110101' ;FLANCO DE SUBIDA PARA LA INTERUPCION 2
    MOVWF INTCON2
    MOVLW B'00011000' ;CONFIGURACION PARA LA INTERUCION 3
    MOVWF INTCON3

MAIN
    MOVLW B'01101110' ;H
    MOVWF PORTD
    CALL DELAY
    CALL DELAY
    MOVLW B'00111111' ;O
    MOVWF PORTD
    CALL DELAY
    CALL DELAY
    MOVLW B'00100101' ;L
    MOVWF PORTD
    CALL DELAY
    CALL DELAY
    MOVLW B'01111110' ;A
    MOVWF PORTD
    CALL DELAY
    CALL DELAY
    BRA MAIN

DELAY ;ESTRUCTURAMOS EL RETARDO
    CLRF TMR0L
    MOVLW .98
    MOVWF TMR0L
    CLRF WREG
    
ASK
    CPFSEQ TMR0L
    BRA ASK
    RETURN
END
   