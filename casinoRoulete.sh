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
  tput cnorm && exit 1
}

# Capturando CTRL + C
trap ctrl_c INT

# Funcion para mostrar el panel de ayuda
function helpPanel () {
  echo -e "\n${greenColour}[i]${endColour} ${grayColour}Para el uso correcto de la herramienta se debe proporcionar los siguientes parametros:${endColour}\n"
  echo -e "\t${blueColour}[+]${endColour} ${greenColour}-m${endColour} ${yellowColour}<numero>${endColour}\t ${grayColour}Dinero a utilizar (ficticio)${endColour}"
  echo -e "\t${blueColour}[+]${endColour} ${greenColour}-t${endColour} ${yellowColour}<nombre>${endColour}\t ${grayColour}Tecnica a utilizar${endColour} [ ${yellowColour}martingala${endColour}${grayColour},${endColour} ${yellowColour}labouchereInversa${endColour} ${grayColour}]${endColour}\n"
}

# Funcion tecnica martingala
funcion martingala () {
  echo -e "\n${greenColour}[+]${endColour} ${grayColour}Utilizando tecnica${endColour} ${yellowColour}Martingala${endColour} ${grayColour}en la ruleta${endColour}\n"
  echo -ne "${greenColour}[?]${endColour} ${grayColour}¿Cuanto${endColour} ${yellowColour}dinero${endColour} ${grayColour}desea apostar?:${endColour} ${greenColour}\$${endColour}" && read bet
  while [[ ! "$bet" =~ ^[0-9]+$ ]]; do
    echo -ne "${greenColour}[?]${endColour} ${grayColour}¿Cuanto${endColour} ${yellowColour}dinero${endColour} ${grayColour}desea apostar?:${endColour} ${greenColour}\$${endColour}" && read bet
  done
  echo -ne "${greenColour}[?]${endColour} ${grayColour}¿A que desea apostar${endColour} ${yellowColour}continuamente${endColour}${grayColour}?${endColour} ${greenColour}[par/impar]${endColour}${grayColour}:${endColour} " && read place_bet
  while [ "$place_bet" != "par" ] && [ "$place_bet" != "impar" ]; do 
    echo -ne "${greenColour}[?]${endColour} ${grayColour}¿A que desea apostar${endColour} ${yellowColour}continuamente${endColour}${grayColour}?${endColour} ${greenColour}[par/impar]${endColour}${grayColour}:${endColour} " && read place_bet
  done
  echo -e "\n${blueColour}[i]${endColour} ${grayColour}Realizando apuesta de ${greenColour}\$$bet${endColour} ${grayColour}continuamente a los numeros${endColour} ${yellowColour}$place_bet${endColour}\n"
  tput civis
  bet_backup=$bet
  total_plays=0
  bad_results=""
  max_money_ammount=$money
  max_money_ammount_play=0
  total_win=0
  total_lose=0
  while true; do
    if [ "$money" -eq 0 ]; then
      echo -e "${redColour}[!] Te has quedado sin dinero \$$money${endColour}\n"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha habido un total de${endColour} ${yellowColour}$total_plays${yellowColour} ${grayColour}jugadas${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha llegado a tener un maximo de${endColour} ${greenColour}\$$max_money_ammount${endColour} ${grayColour}en la jugada${endColour} ${yellowColour}$max_money_ammount_play${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha llegado a ganar un total de${endColour} ${greenColour}$total_win${endColour} ${grayColour}veces${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha llegado a perder un total de${endColour} ${redColour}$total_lose${endColour} ${grayColour}veces${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Los resultados malos obtenidos son:${endColourColour} ${yellowColour}$bad_results${yellowColour}\n"
      tput cnorm && exit 1
    elif [ "$bet" -gt "$money" ]; then
      echo -e "${redColour}[!] No hay dinero para realizar la apuesta de${endColour} ${yellowColour}$bet${endColour}"
      echo -e "${redColour}[!]${endColour} ${grayColour}Dinero actual:${endColour} ${greenColour}\$$money${endColour}\n"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha habido un total de${endColour} ${yellowColour}$total_plays${yellowColour} ${grayColour}jugadas${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha llegado a tener un maximo de${endColour} ${greenColour}\$$max_money_ammount${endColour} ${grayColour}en la jugada${endColour} ${yellowColour}$max_money_ammount_play${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha llegado a ganar un total de${endColour} ${greenColour}$total_win${endColour} ${grayColour}veces${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha llegado a perder un total de${endColour} ${redColour}$total_lose${endColour} ${grayColour}veces${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Los resultados malos obtenidos son:${endColourColour} ${yellowColour}$bad_results${yellowColour}\n"
      tput cnorm && exit 1
    fi
    money=$(($money-$bet))
    random_number="$(($RANDOM % 37))"
    let total_plays+=1
    echo -e "${greenColour}[+]${endColour} ${grayColour}Apostando:${endColour} ${yellowColour}\$$bet${endColour} ${grayColour}| Dinero Restante:${endColour} ${greenColour}\$$money${endColour}"
    echo -e "${greenColour}[+]${endColour} ${grayColour}Ha salido el numero:${endColour} ${yellowColour}$random_number${endColour}"
    if [ "$(($random_number % 2))" -eq 0 ]; then
      if [ "$random_number" -eq 0 ]; then
        echo -e "\t${blueColour}[i]${endColour} ${grayColour}El numero es${endColour} ${yellowColour}0${endColour}${grayColour}. Hemos perdido${endColour}"
        bad_results+="$random_number "
      fi
      echo -e "\t${blueColour}[i]${endColour} ${grayColour}El numero es${endColour} ${yellowColour}par${endColour}"
      if [ "$place_bet" = "par" ]; then
        reward=$(($bet*2))
        money=$(($money+$reward))
        bad_results=""
        let total_win+=1
        if [ $money -ge $max_money_ammount ]; then
          max_money_ammount=$money
          max_money_ammount_play=$total_plays
        fi
        echo -e "\t${greenColour}[+] ¡Has Ganado \$$reward!${endColour}"
        echo -e "\t${blueColour}[i]${endColour} ${grayColour}Dinero Actual:${endColour} ${greenColour}\$$money${endColour}\n"
        bet=$bet_backup
      else
        bet=$(($bet*2))
        bad_results+="$random_number "
        let total_lose+=1
        echo -e "\t${redColour}[!] ¡Has Perdido!${redColour}"
        echo -e "\t${redColour}[!]${endColour} ${grayColour}Apostando el doble${endColour} ${yellowColour}\$$bet${endColour}\n"
      fi
    else
      echo -e "\t${blueColour}[i]${endColour} ${grayColour}El numero es${endColour} ${yellowColour}impar${endColour}"
      if [ "$place_bet" = "impar" ]; then
        reward=$(($bet*2))
        money=$(($money+$reward))
        bad_results=""
        let total_win+=1
        if [ $money -ge $max_money_ammount ]; then
          max_money_ammount=$money
          max_money_ammount_play=$total_plays
        fi
        echo -e "\t${greenColour}[+] ¡Has Ganado \$$reward!${endColour}"
        echo -e "\t${blueColour}[i]${endColour} ${grayColour}Dinero Actual:${endColour} ${greenColour}\$$money${endColour}\n"
        bet=$bet_backup
      else
        bet=$(($bet*2))
        bad_results+="$random_number "
        let total_lose+=1
        echo -e "\t${redColour}[!] ¡Has Perdido!${redColour}"
        echo -e "\t${redColour}[!]${endColour} ${grayColour}Apostando el doble${endColour} ${yellowColour}\$$bet${endColour}\n"
      fi
    fi
    sleep 0.25
  done
  tput cnorm
}

# Funcion tecnica labouchere inversa
function labouchereInversa () {
  echo -e "\n${greenColour}[+]${endColour} ${grayColour}Utilizando tecnica${endColour} ${yellowColour}Labouchere Inversa${endColour} ${grayColour}en la ruleta${endColour}\n"
  echo -ne "${greenColour}[?]${endColour} ${grayColour}¿A que desea apostar${endColour} ${yellowColour}continuamente${endColour}${grayColour}?${endColour} ${greenColour}[par/impar]${endColour}${grayColour}:${endColour} " && read place_bet
  while [ "$place_bet" != "par" ] && [ "$place_bet" != "impar" ]; do 
    echo -ne "${greenColour}[?]${endColour} ${grayColour}¿A que desea apostar${endColour} ${yellowColour}continuamente${endColour}${grayColour}?${endColour} ${greenColour}[par/impar]${endColour}${grayColour}:${endColour} " && read place_bet
  done
  declare -a my_sequence=(1 2 3 4)
  tput civis
  reward=0
  total_plays=0
  max_money_ammount=0
  max_money_ammount_play=0
  total_win=0
  total_lose=0
  bad_results=""
  while true; do
    echo -e "\n${blueColour}[i]${endColour} ${grayColour}Nuestra secuencia es${endColour} ${greenColour}[ ${my_sequence[@]} ]${endColour}"
    if [ "${#my_sequence[@]}" -gt 1 ]; then
      bet=$((${my_sequence[1]} + ${my_sequence[-1]}))
    elif [ "${#my_sequence[@]}" -eq 1 ]; then
      bet=${my_sequence[1]}
    elif [ "${#my_sequence[@]}" -eq 0 ]; then
      my_sequence=(1 2 3 4)
      bet=$((${my_sequence[1]} + ${my_sequence[-1]}))
      echo -e "${redColour}[!] No hay elementos en la sequencia para realizar la apuesta${endColour}"
      echo -e "${greenColour}[+]${endColour} ${grayColour}Reestableciendo la secuencia a:${endColour} ${greenColour}[ ${my_sequence[@]} ]${endColour}\n" 
    fi
    if [ "$money" -eq 0 ]; then
      echo -e "${redColour}[!] Te has quedado sin dinero \$$money${endColour}\n"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha habido un total de${endColour} ${yellowColour}$total_plays${yellowColour} ${grayColour}jugadas${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha llegado a tener un maximo de${endColour} ${greenColour}\$$max_money_ammount${endColour} ${grayColour}en la jugada${endColour} ${yellowColour}$max_money_ammount_play${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha llegado a ganar un total de${endColour} ${greenColour}$total_win${endColour} ${grayColour}veces${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha llegado a perder un total de${endColour} ${redColour}$total_lose${endColour} ${grayColour}veces${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Los resultados malos obtenidos son:${endColourColour} ${yellowColour}$bad_results${yellowColour}\n"
      tput cnorm && exit 1
    elif [ "$bet" -gt "$money" ]; then
      echo -e "${redColour}[!] No hay dinero para realizar la apuesta de${endColour} ${yellowColour}\$$bet${endColour}"
      echo -e "${redColour}[!]${endColour} ${grayColour}Dinero actual:${endColour} ${greenColour}\$$money${endColour}\n"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha habido un total de${endColour} ${yellowColour}$total_plays${yellowColour} ${grayColour}jugadas${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha llegado a tener un maximo de${endColour} ${greenColour}\$$max_money_ammount${endColour} ${grayColour}en la jugada${endColour} ${yellowColour}$max_money_ammount_play${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha llegado a ganar un total de${endColour} ${greenColour}$total_win${endColour} ${grayColour}veces${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Ha llegado a perder un total de${endColour} ${redColour}$total_lose${endColour} ${grayColour}veces${endColour}"
      echo -e "${blueColour}[i]${endColour} ${grayColour}Los resultados malos obtenidos son:${endColourColour} ${yellowColour}$bad_results${yellowColour}\n"
      tput cnorm && exit 1
    fi
    money=$(($money-$bet))
    random_number=$(($RANDOM % 37))
    let total_plays+=1
    echo -e "${blueColour}[i]${endColour} ${grayColour}Realizando apuesta de ${greenColour}\$$bet${endColour} ${grayColour}continuamente a los numeros${endColour} ${yellowColour}$place_bet${endColour}\n"
    echo -e "${greenColour}[+]${endColour} ${grayColour}Apostando:${endColour} ${yellowColour}\$$bet${endColour} ${grayColour}| Dinero Restante:${endColour} ${greenColour}\$$money${endColour}"
    echo -e "${greenColour}[+]${endColour} ${grayColour}Ha salido el numero:${endColour} ${yellowColour}$random_number${endColour}"
    if [ "$(($random_number % 2))" -eq 0 ]; then
      if [ "$random_number" -eq 0 ]; then
        bad_results+="$random_number "
        let total_lose+=1
        unset 'my_sequence[1]'
        unset 'my_sequence[-1]' 2>/dev/null
        my_sequence=(${my_sequence[@]})
        echo -e "\t${redColour}[!] ¡Has Perdido!${redColour}"
        echo -e "\t${blueColour}[!]${endColour} ${grayColour}La secuencia se ha actualizando.${endColour} ${yellowColour}Eliminando extremos.${endColour}\n"
      fi
      echo -e "\t${blueColour}[i]${endColour} ${grayColour}El numero es${endColour} ${yellowColour}par${endColour}"
      if [ "$place_bet" = "par" ]; then
        reward=$(($bet*2))
        money=$(($money+$reward))
        bad_results=""
        let total_win+=1
        if [ $money -ge $max_money_ammount ]; then
          max_money_ammount=$money
          max_money_ammount_play=$total_plays
        fi
        my_sequence+=($bet)
        my_sequence=(${my_sequence[@]})
        echo -e "\t${greenColour}[+] ¡Has Ganado \$$reward!${endColour}"
        echo -e "\t${blueColour}[i]${endColour} ${grayColour}Dinero Actual:${endColour} ${greenColour}\$$money${endColour}\n"
      else
        bad_results+="$random_number "
        let total_lose+=1
        unset 'my_sequence[1]'
        unset 'my_sequence[-1]' 2>/dev/null
        my_sequence=(${my_sequence[@]})
        echo -e "\t${redColour}[!] ¡Has Perdido!${redColour}"
        echo -e "\t${blueColour}[!]${endColour} ${grayColour}La secuencia se ha actualizando.${endColour} ${yellowColour}Eliminando extremos.${endColour}\n"
      fi
    else
      echo -e "\t${blueColour}[i]${endColour} ${grayColour}El numero es${endColour} ${yellowColour}impar${endColour}"
      if [ "$place_bet" = "impar" ]; then
        reward=$(($bet*2))
        money=$(($money+$reward))
        let total_win+=1
        bad_results=""
        if [ $money -ge $max_money_ammount ]; then
          max_money_ammount=$money
          max_money_ammount_play=$total_plays
        fi
        my_sequence+=($bet)
        my_sequence=(${my_sequence[@]})
        echo -e "\t${greenColour}[+] ¡Has Ganado \$$reward!${endColour}"
        echo -e "\t${blueColour}[i]${endColour} ${grayColour}Dinero Actual:${endColour} ${greenColour}\$$money${endColour}\n"
      else
        bad_results+="$random_number "
        let total_lose+=1
        unset 'my_sequence[1]'
        unset 'my_sequence[-1]' 2>/dev/null
        my_sequence=(${my_sequence[@]})
        echo -e "\t${redColour}[!] ¡Has Perdido!${redColour}"
        echo -e "\t${blueColour}[!]${endColour} ${grayColour}La secuencia se ha actualizando.${endColour} ${yellowColour}Eliminando extremos.${endColour}\n"
      fi
    fi
    sleep 0.25
  done
  tput cnorm
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
