#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# Funcion para salir del programa (CTRL + C)
function ctrl_c () {
  echo -e "\n${redColour}[!]${endColour} ${yellowColour}Saliendo...${endColour}\n"
  exit 1
}

# Capturando CTRL + C
trap ctrl_c INT

# Funcion para mostrar el panel de ayuda
function helpPanel () {
  echo -e "\n${greenColour}[i]${endColour} ${grayColour}Para el uso correcto de la herramienta se debe proporcionar los siguientes parametros:${endColour}\n"
  echo -e "\t${blueColour}[+]${endColour} ${greenColour}-m${endColour} ${yellowColour}<numero>${endColour}\t ${grayColour}Dinero a utilizar (ficticio)${endColour}"
  echo -e "\t${blueColour}[+]${endColour} ${greenColour}-t${endColour} ${yellowColour}<nombre>${endColour}\t ${grayColour}Tecnica a utilizar [ martingala, labouchereInversa ]${endColour}\n"
}

# Funcion tecnica martingala
funcion martingala () {
  echo -e "\n${greenColour}[+]${endColour} Utilizando tecnica ${yellowColour}Martingala${endColour}\n"
}

# Funcion tecnica labouchere inversa
function labouchereInversa () {
  echo -e "\n${greenColour}[+]${endColour} Utilizando tecnica ${yellowColour}Labouchere Inversa${endColour}\n"
}

# Definiendo opciones validas del programa
while getopts "m:t:h" arg; do
  case $arg in
    m) money=$OPTARG;;
    t) technique=$OPTARG;;
    h) helpPanel;;
  esac
done

# Condicionales para la ejecucion de funciones
if [ $money ] && [ $technique ]; then
  echo -e "\n${greenColour}[+]${endColour} ${grayColour}Se dará incio al juego. Propiedades indicadas:${endColour}\n"
  echo -e "\t${blueColour}[i]${endColour} ${grayColour}Dinero:${endColour}\t ${greenColour}\$$money${endColour}"
  echo -e "\t${blueColour}[i]${endColour} ${grayColour}Tecnica:${endColour}\t ${yellowColour}$technique${endColour}"
  if [ $technique = "martingala" ]; then
    martingala
  elif [ $technique = "labouchereInversa" ]; then
    labouchereInversa
  else
    echo -e "\n${redColour}[!]${endColour} ${grayColour}Tecnica invalida. Las tecnicas disponible son:${endColour}\n"
    echo -e "\t${blueColour}I.${endColour}\t${yellowColour}martingala${endColour}"
    echo -e "\t${blueColour}II.${endColour}\t${yellowColour}labouchereInversa${endColour}\n"
    exit 1
  fi
else
  helpPanel
  exit 1
fi
