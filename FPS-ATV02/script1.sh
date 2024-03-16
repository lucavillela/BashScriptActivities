#!/bin/bash

date=$(date '+%Y-%m-%d_%H:%M:%S') #armazena a data atual

function backup(){
	if [ -d "Backup" ]; then
    		rm -r ./Backup #apaga backup caso já exista
	fi
	
	mkdir Backup #cria uma nova pasta backup
	for arq in *
	do 
		if [ "$arq" != "Backup" ] #para cada arquivo que não é a pasta backup
		then
			cp -r $arq "./Backup/${arq}_$date" #copie o arquivo para pasta Backup com seu nome acrescido da data atual
			echo "$arq copiado para diretório ./Backup como: ${arq}_$date" #printe o que foi feito
		fi
	done
}

function temp1(){
	if [ -d "Tmp" ]; then
    		rm -r ./Tmp #caso Tmp já exista ele apaga
	fi
	
	mkdir Tmp #cria uma nova pasta Tmp
	for arq in *
	do 
		if [ "$arq" != "Tmp" ] && [ "$arq" = [a,e,i,o,u,A,E,I,O,U]* ] #para cada arquivo que não seja pasta Tmp e comece com vogal
		then
			cp -r $arq ./Tmp #copie o arquivo para pasta Tmp
			echo "$arq copiado para diretório ./Tmp" #printe o que foi feito
		fi
	done
}

function temp2(){
	if [ -d "Tmp" ]; then
    		rm -r ./Tmp #caso Tmp já exista ele apaga
	fi
	
	mkdir Tmp #cria uma nova pasta Tmp
	for arq in *
	do 
		if [ "$arq" != "Tmp" ] && [ "$arq" != [a,e,i,o,u,A,E,I,O,U]* ] #para cada arquivo que não seja pasta Tmp e comece com consoante 
		then
			cp -r $arq ./Tmp copie o arquivo para pasta Tmp
			echo "$arq copiado para diretório ./Tmp" #printe o que foi feito
		fi
	done
}

arg=$1 #armazena o primeiro argumento

case $arg in
	Backup)
		backup ;;
	BACKUP)
		backup ;;
	backup)
		backup ;;
	Temporario1)
		temp1 ;;
	TEMPORARIO1)
		temp1 ;;
	temporario1)
		temp1 ;;
	Temporario2)
		temp2 ;;
	TEMPORARIO2)
		temp2 ;;
	temporario2)
		temp2 ;;
	*) #caso argumento não seja um dos casos esperados
		if [ -d "Tmp" ]; then
    			rm -r ./Tmp #remova a pasta Tmp
    			echo "Diretório ./Tmp removido" 
		fi
		
		if [ -d "Backup" ]; then
    			rm -r ./Backup #remova a pasta Backup
			echo "Diretório ./Backup removido"
		fi ;;
esac
		
		
	



