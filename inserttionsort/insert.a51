ORG 00h
	

MOV R5, #0Ah; Data sayisini tutar.
MOV R4, #90h; External memory de datanin kopyalanacagi adresin MSB byte`ini tutar.
MOV R3, #00h; External memory de datanin kopyalanacagi adresin LSB byte`ini tutar.

DATATRANSFER:
	MOV DPTR, #MYDATA
	MOV A, R3
	MOVC A, @A+DPTR ;kod satirindan okur
	MOV DPH, R4
	MOV DPL, R3
	MOVX @DPTR, A   ;data memoryden okur
	INC R3
	DJNZ R5, DATATRANSFER; Burada datanizi kod adresinden okuyup external memory adresine(9000H) kopyalayacaksiniz.
	
MOV R0, #0AH
MOV DPTR, #9000h
MOV R3,#00H

SORT:

LOOP1:
	
	MOV DPL,R3
	INC DPTR
	MOVX A,@DPTR
	MOV R2,A
	INC R3
	MOV A,R3
	MOV R1,A
	
	LOOP2:
		MOVX A, @DPTR
		MOV R2,A
		DEC DPL
		MOVX A,@DPTR
		MOV R7,A
		MOV A,R2
		SUBB R7,A
		JNC Continue1
		
		Swapnumbers:
		
			MOVX A,@DPTR
			XCH A,R2
			
			MOVX @DPTR, A
			INC DPL
			MOV A, R2
			MOVX @DPTR, A
			DEC DPL
		Continue2:
				DJNZ R1,LOOP2
		Continue1:
				DJNZ R0, LOOP1
		
			
			



SEND2PORT:

MOV DPTR, #9000H
MOV R0, #0AH
MOV R6,#250D
MOV R7,#250D
; Burada siraladiginiz datayi P2 portuna 1ms araliklarla gondereceksiniz.
LOOP3:
	INC DPTR
	MOVX A, @DPTR
	MOV P1, A
	LABEL1: DJNZ R6,LABEL1
	LABEL2: DJNZ R7,LABEL2
	DJNZ R0, LOOP3
	
Here: SJMP Here	
	
	
; Fonksiyonlarinizi buraya yazabilirsiniz.
	

	
	


ORG 300H
MYDATA:
DB 20, 13, 42, 92, 16, 25, 45, 36, 64, 28
	
END