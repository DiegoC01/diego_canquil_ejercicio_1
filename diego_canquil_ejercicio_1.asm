title Fibonacci
 
include 'emu8086.inc' 
 
datos segment
    ;inicio declaracion de variables
    ;byte
    varbyte db 255 
    
    ;word
    varword dw 65535
    
    f1 dw 0, 65535  
    f2 dw 0, 65535
    f3 dw 0, 65535
    f4 dw 0, 65535 
    aux dw 0, 65535
    numero_inicial db 1,2,3,4,5,6,7,8
    fib db 10 dup(0)

    ;fin declaracion de variables
datos ends

pila segment

    db 64 dup(0)

pila ends

codigo segment
    
    inicio proc far
        assume ds:datos, cs:codigo, ss:pila
        push ds
        mov ax,0
        push ax
        
        mov ax,datos
        mov ds,ax
        mov es, ax 
        

        
        ;codigo del programa -----------------------------------------

            
            ;Se ingresa la posicion del termino de la sucesion
            ;de fibonacci deseado
            
            print 'Ingrese un numero: ' 
            call scan_num
            
            ;Inicializa el contador en el registro dx
            
            mov dx,1
            
            ;Guarda la posicion ingresada en una variable auxiliar
            
            mov aux,cx
            
            ;Las siguientes lineas definen en f1=0, f2=1, f3=1 y f4=2, que son
            ;los valores de fibonacci con los que se comenzaran. Tambien se
            ;usan cmp (comparacion) y saltos (jump) para terminar el programa
            ;si uno de los terminos que se pidieron son los cuatro definido
            ;anteriormente.
            
            mov f1,0    
            mov ax,f1
            GOTOXY 5,2
            call print_num
            print '   '
            cmp dx,cx                 ;Se revisa si el contador es igual a la posicion
            je exit                   ;ingresada deseada. Si lo es se termina el programa
            add dx,1
            mov f2,1
            mov ax,f2
            call print_num
            print '   '
            cmp dx,cx                 ;Se revisa si el contador es igual a la posicion
            je exit                   ;ingresada deseada. Si lo es se termina el programa
            add dx,1
            mov f3,1 
            mov ax,f3    
            call print_num
            print '   '
            cmp dx,cx                 ;Se revisa si el contador es igual a la posicion
            je exit                   ;ingresada deseada. Si lo es se termina el programa
            add dx,1
            mov f4,2
            mov ax,f4   
            call print_num
            print '   '
            cmp dx,cx                 ;Se revisa si el contador es igual a la posicion
            je exit                   ;ingresada deseada. Si lo es se termina el programa
            add dx,1
            mov bx,f4
            
              
      ;Se inicia un ciclo que genera los siguientes terminos de fibonacci
      ;hasta que se llega al termino en la posicion deseada ingresada por
      ;teclado
            
      ciclo:
            mov ax,f3                 ;ax guarda el numero en la posicion n-2.
            add ax,bx                 ;bx guarda el termino en n-1 y lo suma con
            call print_num            ;el termino n-2 (como dice la definicion
            print '   '               ;de fibonacci). El termino n resultante esta dado
                                      ;por el nuevo valor de ax.
            
            mov f3,bx                 ;f3 almacena el n-1 termino. bx almacena el n termino. 
            mov bx,ax                 ;Estos se convertiran el los terminos n-2 y n-1
                                      ;respectivamente en otro pasada del ciclo
                                      
            add dx,1                  ;El contador aumenta hasta que sea mayor que
            cmp dx,aux                ;el numero ingresado por teclado.
            jle ciclo
      
      
      ;Esta parte indica el fin del programa.
      
      exit:
            GOTOXY 10,5
            print 'Fin'
      
    
        ret
    inicio endp 
    
    
codigo ends

    DEFINE_PRINT_STRING  
    DEFINE_GET_STRING  
    DEFINE_SCAN_NUM
    DEFINE_PRINT_NUM 
    DEFINE_PRINT_NUM_UNS
    end inicio
