ORG 00h
MOV R5, #0Ah ;ELEMAN SAYISINI TUTAR
MOV R4, #90h
MOV R3, #00h

DATATRANSFER:
	MOV DPTR, #MYDATA
	MOV A, R3
	MOVC A, @A+DPTR ;kod satirindan okur
	MOV DPH, R4
	MOV DPL, R3
	MOVX @DPTR, A   ;data memoryden okur
	INC R3
	DJNZ R5, DATATRANSFER
	
MOV R0, #0A

LOOP1:
	MOV DPTR, #9000H
	MOV A,R0
	MOV R1,A
	
	LOOP2:
		
		MOVX A, @DPTR
		MOV R2, A
		INC DPTR
		MOVX A, @DPTR
		
		SUBB A, R2
		
		JNC Continue1
		
		Swapnumbers:
		
			MOVX A,@DPTR
			XCH A,R2
			
			MOVX @DPTR, A
			DEC DPL
			MOV A, R2
			MOVX @DPTR, A
			INC DPTR
		Continue2:
				DJNZ R1,LOOP2
		Continue1:
				DJNZ R0, LOOP1
		Here: sjmp Here
ORG 300H
MYDATA:
DB 20,13,42,92,16,25,45,36,64,28
END		