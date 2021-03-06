#! /bin/bash
ver="1.0.1"
path='python /home/pi/Desktop/BotSonja/googleserver.py'

if [ "$1" == "start" ];
then
 processId=$(ps -ef | grep 'googleserver.py' | grep -v 'grep' | awk '{ printf $2 }')
 if [[ $processId ]];
 then
  echo "Server gia' attivo!"
 else
  if [ "$2" != "lx" ];
  then
   python ../googleserver.py &
  else
   lxterminal -t "GOOGLEServer" -e bash -c "$path"
  fi
  sleep 1
  processId=$(ps -ef | grep 'googleserver.py' | grep -v 'grep' | awk '{ printf $2 }')
  if [[ $processId ]];
  then
   echo "Server START"
  else
   echo "Server ERRORE: Il comando python non ha avviato il processo!"
   exit
  fi
 fi
fi

if [ "$1" == "stop" ];
then
 processId=$(ps -ef | grep 'googleserver.py' | grep -v 'grep' | awk '{ printf $2 }')
 if [[ $processId ]];
 then
  sudo kill $processId
  processId=$(ps -ef | grep 'googleserver.py' | grep -v 'grep' | awk '{ printf $2 }')
  if [[ $processId ]];
  then
   echo "Server ERRORE: Il comando kill non ha fermato il processo!"
   exit
  else
   echo "Server STOP"
  fi
 else
  echo "Server non attivo!"
 fi
fi

if [ "$1" == "pid" ];
then
 processId=$(ps -ef | grep 'googleserver.py' | grep -v 'grep' | awk '{ printf $2 }')
 echo "Server PID:" $processId
fi

if [ "$1" == "status" ];
then
 processId=$(ps -ef | grep 'googleserver.py' | grep -v 'grep' | awk '{ printf $2 }')
 if [[ $processId ]];
 then
  echo "Server ON "
 else
  echo "Server OFF"
 fi
fi

if [ "$1" == "restart" ];
then
 processId=$(ps -ef | grep 'googleserver.py' | grep -v 'grep' | awk '{ printf $2 }')
 if [[ $processId ]];
 then
  echo "Bot PID:" $processId
  sudo kill $processId
  processId=$(ps -ef | grep 'googleserver.py' | grep -v 'grep' | awk '{ printf $2 }')
  if [[ $processId ]];
  then
   echo "Server ERRORE: Il comando kill non ha fermato il processo!"
   exit
  else
   echo "Server STOP"
  fi
  if [ "$2" != "lx" ];
  then
   python ../googleserver.py &
  else
   lxterminal -t "GOOGLEServer" -e bash -c "$path"
  fi
  sleep 1
  processId=$(ps -ef | grep 'googleserver.py' | grep -v 'grep' | awk '{ printf $2 }')
  if [[ $processId ]];
  then
   echo "Server RESTART"
  else
   echo "Server ERRORE: Il comando python non ha avviato il processo!"
   exit
  fi
 fi
fi

if [ "$1" == "version" ];
then
 echo "googlesvrcmd " $ver
fi



if [ "$1" == "help" ];
then
 echo "Elenco Comandi: "
 echo "pid		-- Ritorna PID processo del Server"
 echo "status		-- Indica stato Server ON/OFF e PID"
 echo "stop		-- Termina l'esecuzione del Server"
 echo "start		-- Avvia l'esecuzione del Server"
 echo "restart		-- Riavvia l'esecuzione del Server"
 echo "help		-- Mostra elenco comandi script."
 echo "version		-- Mostra versione script."
fi

