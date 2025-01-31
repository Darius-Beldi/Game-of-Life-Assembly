.data
    formatScanf: .asciz "%d"
    formatPrintf: .asciz "%d "
    formatPrintf2: .asciz "Suma %d Coloana %d Linia %d\n"
    endl :  .asciz "\n"

    read : .asciz "r"
    write : .asciz "w"
    fisierin  : .asciz "in.txt"
    fp : .space 4
    fisierout : .asciz "out.txt"

    matrix1 : .zero 1600
    matrix2 : .zero 1600
    collumnIndex : .space 4
    lineIndex : .space 4

    m : .space 4    # linii
    n : .space 4    # coloane
    copien :.space 4 # copie n
    copiem2 : .space 4 # copie m 
    p : .space 4    # nr de celule vii in prima matrice
    x : .space 4    
    y : .space 4

    k : .space 4
    suma : .space 4
    nr_iteratii: .long 0



     
.text

.global main

main:

open:

    push $read
    push $fisierin
    call fopen
    addl $8,%esp
    
    movl %eax, fp

    push $m                 # citire numar linii
    push $formatScanf
    push fp
    call fscanf 
    addl $12,%esp


    movl m, %ebx
    addl $2, %ebx
    movl %ebx, copiem2           

    push $n                # citire numar coloane
    push $formatScanf
    push fp
    call fscanf 
    addl $12,%esp    

    movl n, %ebx
    movl %ebx, copien       #se face o copie a lui n 
    addl $2, %ebx
    movl %ebx, n            #se bordeaza

    push $p                 # citire numar coloane
    push $formatScanf
    push fp
    call fscanf 
    addl $12,%esp


    lea matrix1,%edi        #se incarca adresa primei matrici in edi
    lea matrix2,%esi        #se incarca adresa matricii 2 in esi
    xor %ebx,%ebx           # ebx = contor 

citire_perechi:

    
    cmp %ebx, p 
    je final_citire_perechi

        push $x                 # citire x
        push $formatScanf
        push fp
        call fscanf 
        addl $12,%esp
        
        push $y                 # citire y
        push $formatScanf
        push fp
        call fscanf 
        addl $12,%esp

        incl x 
        incl y

        movl x, %eax
        mull n
        addl y, %eax        # se calculeaza pozitia in matrice

        movl $1, (%edi,%eax,4)      # se pune 1 in pozitia calculata

        inc %ebx            # se creste contorul
    jmp citire_perechi

final_citire_perechi:

    push $k                 # citire k
    push $formatScanf
    push fp
    call fscanf 
    addl $12,%esp
    
close_in: 

    push fp
    call fclose
    addl $4, %esp

et_o_iteratie:
xor %ecx,%ecx
movl k, %ebx
cmp nr_iteratii, %ebx
je final_iteratii

    movl $1,lineIndex

for_lines0:
	
	mov lineIndex,%ecx
	cmp m,%ecx
	jg final_o_iteratie
	
	movl $1,collumnIndex

for_collumns0:
	
	mov collumnIndex, %ecx
	cmp copien, %ecx
	jg cont_for_lines0
	
	# movl lineIndex,%eax
	# mull n
	# add collumnIndex,%eax
	
  et_suma_vecini:

    push lineIndex
    push collumnIndex

    xor %ebx,%ebx       # ebx = suma vecinilor
    xor %eax,%eax

    decl lineIndex
    decl collumnIndex

    movl lineIndex,%eax
	mull n
	add collumnIndex,%eax

    addl (%edi,%eax,4),%ebx 

    #
    incl collumnIndex

    movl lineIndex,%eax
	mull n
	add collumnIndex,%eax

    addl (%edi,%eax,4),%ebx 

    #
    incl collumnIndex

    movl lineIndex,%eax
	mull n
	add collumnIndex,%eax

    addl (%edi,%eax,4),%ebx    

    #
    incl lineIndex
    decl collumnIndex
    decl collumnIndex

    movl lineIndex,%eax
	mull n
	add collumnIndex,%eax

    addl (%edi,%eax,4),%ebx 

    #
    incl collumnIndex
    incl collumnIndex
    
    movl lineIndex,%eax
	mull n
	add collumnIndex,%eax

    addl (%edi,%eax,4),%ebx 

    #
    incl lineIndex

    movl lineIndex,%eax
	mull n
	add collumnIndex,%eax

    addl (%edi,%eax,4),%ebx 

    #
    decl collumnIndex

    movl lineIndex,%eax
	mull n
	add collumnIndex,%eax

    addl (%edi,%eax,4),%ebx 

    #
    decl collumnIndex

    movl lineIndex,%eax
	mull n
	add collumnIndex,%eax

    addl (%edi,%eax,4),%ebx 

    # push %ecx

    # push %ebx
    # push $formatPrintf
    # call printf
    # addl $8,%esp

    # pop %ecx

et_final_suma:

    # in ebx e suma vecinilor 
    
    pop collumnIndex
    pop lineIndex
test1:
    # pop %ecx
    movl lineIndex,%eax
	mull n
	add collumnIndex,%eax

    movl (%edi,%eax,4),%edx	#pune valoarea pozitiei in eax
	
    # eax e valoarea pozitiei
    # ebx e suma vecinilor
    # ecx e pozitia

    cmpl $0,%edx
    je e_zero
    jmp e_unu

    e_zero:
        cmp $3, %ebx
        je pune_unu

        jmp moare

    e_unu:

        cmp $2, %ebx
        je pune_unu

        cmp $3, %ebx
        je pune_unu

        jmp moare

    pune_unu:
        movl $1,%edx 
        movl %edx, (%esi,%eax,4)
        jmp continua

    moare:
        movl $0,%edx 
        movl %edx, (%esi,%eax,4)
        jmp continua

continua:
    

	incl collumnIndex
	
	jmp for_collumns0

cont_for_lines0:
		
	incl lineIndex
	jmp for_lines0


final_o_iteratie:

    movl copiem2, %eax
    mull n
    # acum in eax am aria matricii
    xor %edx, %edx
    
    loop:
        cmp %edx,%eax 
        je final_loop
            movl (%esi,%edx,4),%ebx
            movl %ebx, (%edi,%edx,4)
            incl %edx
            jmp loop
    final_loop:
    incl nr_iteratii
    jmp et_o_iteratie


final_iteratii:

    push $write
    push $fisierout
    call fopen
    addl $8,%esp

    movl %eax, fp

et_afisare_matrice:
	
	movl $1,lineIndex

for_lines:
	
	mov lineIndex,%ecx
	cmp m,%ecx
	jg et_exit
	
	movl $1,collumnIndex

for_collumns:
	
	mov collumnIndex, %ecx
	cmp copien, %ecx
	jg cont_for_lines
	
	movl lineIndex,%eax
	mull n
	add collumnIndex,%eax
	

	#si afisez (%edi,%eax,4)
	movl (%edi,%eax,4),%ebx

    push %ebx               
    push $formatPrintf
    push fp
    call fprintf 
    addl $12,%esp

	incl collumnIndex
	
	jmp for_collumns

cont_for_lines:

	
    push $endl                
    push fp
    call fprintf 
    addl $8,%esp

	incl lineIndex
	jmp for_lines


et_exit:

    push fp
    call fclose
    addl $4, %esp

    mov $1 ,%eax    
    xor %ebx,%ebx
    int $0x80
