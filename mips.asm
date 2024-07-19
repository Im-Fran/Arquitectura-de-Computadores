# Inicio del programa
.data
mensaje_bienvenida: .asciiz "\n¡Bienvenido!"
menu_principal: .asciiz "\nSeleccione la opción que desea utilizar:\n\n1. Temperatura (Celsius a Fahrenheit o viceversa)\n2. Longitud (metros a pies o viceversa)\n3. Salir\n"
menu_temperatura: .asciiz "\nSeleccione una opción:\n1. Convertir de Celsius a Fahrenheit\n2. Convertir de Fahrenheit a Celsius\n3. Volver al menú principal\n"
menu_longitud: .asciiz "\nSeleccione una opción:\n1. Convertir metros a pies\n2. Convertir pies a metros\n3. Volver al menú principal\n"
ingrese_opcion: .asciiz "Ingrese la selección: "
ingrese_valor: .asciiz "Ingresa el valor a convertir: "
resultado_temp_c_a_f: .asciiz " Grados equivale a "
resultado_temp_f_a_c: .asciiz " Fahrenheit equivale a "
resultado_long_m_a_p: .asciiz " metros equivale a "
resultado_long_p_a_m: .asciiz " pies equivale a "
opcion_invalida: .asciiz "Ingresa una opción válida\n"
salto_linea: .asciiz "\n"
mensaje_despedida: .asciiz "Saliendo...\n"

.text
.globl main

# Función principal
main:
    # Imprimir mensaje de bienvenida
    li $v0, 4
    la $a0, mensaje_bienvenida
    syscall

    # Llamar a la función del menú
    jal menu

    # Salir del programa
    li $v0, 10
    syscall

# Función del menú
menu:
    bucle_menu:
        # Imprimir menú principal
        li $v0, 4
        la $a0, menu_principal
        syscall

        # Leer opción del usuario
        li $v0, 5
        syscall
        move $t0, $v0

        # Comparar opción
        beq $t0, 1, opcion_menu_temperatura
        beq $t0, 2, opcion_menu_longitud
        beq $t0, 3, salir_programa
        j opcion_invalida_menu

    opcion_menu_temperatura:
        jal temperatura
        j bucle_menu

    opcion_menu_longitud:
        jal longitud
        j bucle_menu

    salir_programa:
        # Imprimir mensaje de salida
        li $v0, 4
        la $a0, mensaje_despedida
        syscall
        j salir  # Salir del programa

    opcion_invalida_menu:
        # Imprimir mensaje de opción inválida
        li $v0, 4
        la $a0, opcion_invalida
        syscall
        j bucle_menu

# Función de temperatura
temperatura:
    bucle_temp:
        # Imprimir menú de temperatura
        li $v0, 4
        la $a0, menu_temperatura
        syscall

        # Leer opción del usuario
        li $v0, 5
        syscall
        move $t0, $v0

        # Comparar opción
        beq $t0, 1, celsius_a_fahrenheit
        beq $t0, 2, fahrenheit_a_celsius
        beq $t0, 3, volver_menu_temp
        j opcion_invalida_temp

    celsius_a_fahrenheit:
        # Leer valor en Celsius
        li $v0, 4
        la $a0, ingrese_valor
        syscall
        li $v0, 6
        syscall
        mov.s $f12, $f0

        # Convertir a Fahrenheit: fahrenheit = (celsius * 1.8) + 32
        li $t1, 0x3fcccccd  # 1.8 en punto flotante
        mtc1 $t1, $f2
        mul.s $f4, $f12, $f2
        li $t2, 0x42000000  # 32.0 en punto flotante
        mtc1 $t2, $f6
        add.s $f8, $f4, $f6

        # Imprimir resultado
        li $v0, 4
        la $a0, salto_linea
        syscall
        li $v0, 2
        mov.s $f12, $f8
        syscall

        # Volver al menú
        j bucle_temp

    fahrenheit_a_celsius:
        # Leer valor en Fahrenheit
        li $v0, 4
        la $a0, ingrese_valor
        syscall
        li $v0, 6
        syscall
        mov.s $f12, $f0

        # Convertir a Celsius: celsius = (fahrenheit - 32) / 1.8
        li $t2, 0x42000000  # 32.0 en punto flotante
        mtc1 $t2, $f2
        sub.s $f4, $f12, $f2
        li $t3, 0x3fcccccd  # 1.8 en punto flotante
        mtc1 $t3, $f6
        div.s $f8, $f4, $f6

        # Imprimir resultado
        li $v0, 4
        la $a0, salto_linea
        syscall
        li $v0, 2
        mov.s $f12, $f8
        syscall

        # Volver al menú
        j bucle_temp

    volver_menu_temp:
        jr $ra

    opcion_invalida_temp:
        # Imprimir mensaje de opción inválida
        li $v0, 4
        la $a0, opcion_invalida
        syscall
        j bucle_temp

# Función de longitud
longitud:
    bucle_longitud:
        # Imprimir menú de longitud
        li $v0, 4
        la $a0, menu_longitud
        syscall

        # Leer opción del usuario
        li $v0, 5
        syscall
        move $t0, $v0

        # Comparar opción
        beq $t0, 1, metros_a_pies
        beq $t0, 2, pies_a_metros
        beq $t0, 3, volver_menu_longitud
        j opcion_invalida_longitud

    metros_a_pies:
        # Leer valor en metros
        li $v0, 4
        la $a0, ingrese_valor
        syscall
        li $v0, 6
        syscall
        mov.s $f12, $f0

        # Convertir a pies: pies = metros * 3.28084
        li $t1, 0x4054b000  # 3.28084 en punto flotante
        mtc1 $t1, $f2
        mul.s $f4, $f12, $f2

        # Imprimir resultado
        li $v0, 4
        la $a0, salto_linea
        syscall
        li $v0, 2
        mov.s $f12, $f4
        syscall

        # Volver al menú
        j bucle_longitud

    pies_a_metros:
        # Leer valor en pies
        li $v0, 4
        la $a0, ingrese_valor
        syscall
        li $v0, 6
        syscall
        mov.s $f12, $f0

        # Convertir a metros: metros = pies / 3.28084
        li $t1, 0x4054b000  # 3.28084 en punto flotante
        mtc1 $t1, $f2
        div.s $f4, $f12, $f2

        # Imprimir resultado
        li $v0, 4
        la $a0, salto_linea
        syscall
        li $v0, 2
        mov.s $f12, $f4
        syscall

        # Volver al menú
        j bucle_longitud

    volver_menu_longitud:
        jr $ra

    opcion_invalida_longitud:
        # Imprimir mensaje de opción inválida
        li $v0, 4
        la $a0, opcion_invalida
        syscall
        j bucle_longitud

salir:
    # Salir del programa
    li $v0, 10
    syscall
