#include<p18f4550.inc>

loop_cnt1	set	0x00
loop_cnt2	set 0x01

			org	0x00
			goto start
			org	0x08
			retfie
			org	0x18
			retfie

dup_nop		macro kk
			variable i
i = 0
			while i < kk
			nop
i += 1
			endw
			endm

SHOWD		SETF	PORTD, A
			BCF		PORTD, 6, A
			RETURN

SHOWE		SETF	PORTD, A
			BCF		PORTD, 1, A
			BCF		PORTD, 2, A
			RETURN
			
SHOW9		SETF	PORTD, A
			BCF		PORTD, 4, A
			RETURN

SHOW6		SETF	PORTD, A
			BCF		PORTD, 1, A
			RETURN

SHOW5		SETF	PORTD, A
			BCF		PORTD, 1, A
			BCF		PORTD, 4, A
			RETURN

SHOW8		SETF	PORTD, A
			RETURN

CLEARled	CLRF	PORTD, A
			RETURN
			



start		CLRF	TRISD, A
			CALL	CLEARled
			CALL	SHOWD
			CALL	DELAY
			CALL	SHOWE
			CALL	DELAY
			CALL	SHOW9
			CALL	DELAY
			CALL	SHOW6
			CALL	DELAY
			CALL	SHOW5
			CALL	DELAY
			CALL	SHOW8
			CALL	DELAY
			CALL	CLEARled
			CALL	DELAY
			CALL	SHOW8


DELAY		MOVLW D'200'		;0.5sec delay subroutine for (external loop)
			MOVWF loop_cnt2,A
AGAIN1		MOVLW D'40'		;internal loop
			MOVWF loop_cnt1, A
AGAIN2		dup_nop	   D'51'
			DECFSZ	   loop_cnt1,F,A
			BRA	       AGAIN2
			DECFSZ	   loop_cnt2,F,A
			BRA		   AGAIN1
			NOP
			RETURN
			
			END