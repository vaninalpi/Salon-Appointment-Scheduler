#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU() {
  # si la función recibe un argumento, lo muestra (mensajes de error, etc.)
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  # encabezado
  echo -e "\n~~~~~ MY SALON ~~~~~\n"
  echo -e "Welcome to My Salon, how can I help you?\n"

  # mostrar lista de servicios
  echo "$($PSQL "SELECT service_id, name FROM services")" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done

  # pedir elección
  read SERVICE_ID_SELECTED

  # Verificar que el input sea un número y que exista en la tabla
  SERVICE_EXISTS=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED")

  if [[ -z $SERVICE_EXISTS ]]
  then
    # Si no existe, llamamos a MAIN_MENU de nuevo con mensaje de error
    MAIN_MENU "I could not find that service. What would you like today?"
  else
    # Si existe, preguntamos el telefono 
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE

    #buscamos si el telefono se encuentra registrado
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

    if [[ -z $CUSTOMER_NAME ]]
    then
      # No está registrado, pedir nombre y registrar nuevo cliente
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME

      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    fi

    #Pregutamos la hora en la que agendamos la cita
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"

    read SERVICE_TIME

    # Buscar el customer_id usando el teléfono
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

    # Insertar la cita en appointments 
    INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")


    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."

  fi
}

MAIN_MENU