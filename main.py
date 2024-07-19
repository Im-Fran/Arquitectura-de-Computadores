def temperatura():
    while True:
        print("""
    Seleccione una opcion:
        1. Convertir de Celsius a Fahrenheit
        2. Convertir de Fahrenheit a Celsius
        3. Volver al menu principal
            """)
        opciontemp = int(input("Ingrese la seleccion: "))

        if opciontemp == 1:
            celsius = float(input("Ingresa el valor a convertir: "))
            fahrenheit = (celsius * 1.8) + 32
            f2 = round(fahrenheit, 2)
            print(f"{celsius} Grados equivale a {f2} Fahrenheit")

        elif opciontemp == 2:
            fahrenheit = float(input("Ingresa el valor a convertir: "))
            celsius = (fahrenheit - 32) / 1.8
            c2 = round(celsius, 2)
            print(f"{fahrenheit} Fahrenheit equivale a {c2} Grados")
        elif opciontemp == 3:
            break
        else:
            print("Ingresa una opción valida")


def longitud():
    while True:
        print("""
    Seleccione una opción:
        1. Convertir metros a pies
        2. Convertir pies a metros
        3. Volver al menu principal
            """)
        opcion_temp = int(input("Ingrese la selección: "))

        if opcion_temp == 1:
            metros = float(input("Ingresa el valor a convertir: "))
            pies = metros * 3.28084
            p2 = round(pies, 2)
            print(f"{metros} metros equivale a {p2} pies")
        elif opcion_temp == 2:
            pies = float(input("Ingresa el valor a convertir: "))
            metros = pies / 3.28084
            m2 = round(metros, 2)
            print(f"{pies} pies equivale a {m2} metros")
        elif opcion_temp == 3:
            break
        else:
            "Ingresa una opción valida"


def menu():
    while True:
        print("""
    Seleccione la opcion que desea utilizar:

    1. Temperatura (Celsius a Fahrenheit o viceversa)
    2. Longitud (metros a pies o viceversa)
    3. Salir
    """)

        seleccion = int(input("Ingrese una opcion valida: "))
        if seleccion == 1:
            temperatura()
        elif seleccion == 2:
            longitud()
        elif seleccion == 3:
            print("Saliendo...\n")
            break
        else:
            print("Ingresa una opcion correcta")


def main():
    print("\nBienvenido!")
    menu()


main()
