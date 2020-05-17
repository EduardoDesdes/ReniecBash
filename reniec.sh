#!/bin/bash
# Autor: Eduardo Sarria (Desdes)

#Metodo de uso:
# ./reniec.sh APELLIDOP APELLIDOM NONMBRE DIAI DIAF MESI MESF AÑOI AÑOF
# Ejemplo:
# ./reniec.sh humala tasso ollanta 24 30 5 7 1961 1963

trap ctrl_c INT

function ctrl_c(){
	bye
	exit 0
}

function ayuda(){
    echo "*************************"
    echo -n "* Desplegando la ayuda"
    sleep 0.2
    echo -n "."
    sleep 0.2
    echo -n "."
    sleep 0.2
    echo -ne ".\n"
    echo "*************************"
    echo "* Metodo de uso del comando: "
    echo "* $0 APELLIDOP APELLIDOM NONMBRE DIAI DIAF MESI MESF AÑOI AÑOF"
    echo "* Por ejemplo: "
    echo "* $0 humala tasso ollanta 24 30 5 7 1961 1963"
    echo "* Recomendacion: Si el comando demora mucho, verifique en otra terminal"
    echo "* si es que se creo el fichero en el directorio outputs/"
    echo "***********************"
}

if [ $# == 0 ] || [ $# -lt 9 ] || [ $# -gt 9 ]; then
    if [ $# != 1 ] || [ $1 != "-h" ];then
        echo ""
        echo "[!] El comando ingresado en incorrecto"
        echo ""
    fi
    ayuda
fi

exit 0

function bye(){
    if [ -f $file ];then
        echo -e "\nPrograma Finalizado, le atinaste :D ! , se guardó el resultado en $file"
        echo "Leyendo el fichero..."
        cat $file
    else
        echo -e "\nOh! no encontramos el registro prueba con otros valores T-T"
    fi
}

function coding(){
    name=$1
    for i in `cut tabla -d "," -f 1`;do (echo $name | grep $i> /dev/null) && name=$(echo $name | sed s/$i/`grep $i tabla | cut -d "," -f 2`/g);done;echo $name
}

file=outputs/$1$2`echo $3 | sed s/" "//g`.txt

apellidop=`coding $1`
apellidom=`coding $2`
nombres=`coding "$3"`

echo "Calculando las cookies"

galletita1=`curl -s -D - http://www.reniec.gob.pe/concer/concer.do -o /dev/null | grep Cookie | cut -d " " -f 2`

echo "Cookie 1:$galletita1"

galletita2=`curl -s -D - -b "$galletita1" -d "accion=continuar&etapa=3&etapaAux=2&caso=&tipActa=01&bot_prot_continuar11.x=102&bot_prot_continuar11.y=5" -X POST http://www.reniec.gob.pe/concer/concer.do -o /dev/null | grep Cookie | cut -d " " -f 2`

echo "Cookie 2:$galletita2"

echo "Calculando la fecha de nacimiento"

for i in `seq $4 $5 | sed  's/^.$/0&/g'`;do
    for j in `seq $6 $7 | sed  's/^.$/0&/g'`;do
        for k in `seq $8 $9 | sed  's/^.$/0&/g'`;do
            (curl -b "$galletita2" -d "accion=continuar&etapa=5&etapaAux=4&caso=&tipActa=01&priApeTitular1=${apellidop^^}&segApeTitular1=${apellidom^^}&preNomTitular1=${nombres^^}&fecDiaActa=$i&fecMesActa=$j&fecAnioActa=$k&bot_prot_continuar11.x=45&bot_prot_continuar11.y=17" -X POST http://www.reniec.gob.pe/concer/concer.do 2>/dev/null | grep "Se encontr" > /dev/null && echo "Su nacimiento es el: $i/$j/$k" > $file)&
        done
    done
done;wait

bye


