#!/bin/bash -e
#
# ==============================================================================
# PAQUETE: canaima-desarrollador
# ARCHIVO: canaima-desarrollador.sh
# DESCRIPCIÓN: Script de bash principal del paquete canaima-desarrollador
# COPYRIGHT:
#  (C) 2010 Luis Alejandro Martínez Faneyth <martinez.faneyth@gmail.com>
#  (C) 2010 Diego Alberto Aguilera Zambrano <daguilera85@gmail.com>
#  (C) 2010 Carlos Alejandro Guerrero Mora <guerrerocarlos@gmail.com>
#  (C) 2010 Francisco Javier Vásquez Guerrero <franjvasquezg@gmail.com>
# LICENCIA: GPL3
# ==============================================================================
#
# Este programa es software libre. Puede redistribuirlo y/o modificarlo bajo los
# términos de la Licencia Pública General de GNU (versión 3).

VARIABLES="/usr/share/canaima-desarrollador/variables.conf"

# Inicializando variables
. ${VARIABLES}

# Cargando configuración
. ${CONF}

# Cargando funciones
. ${FUNCIONES}

# Función para chequear que ciertas condiciones se cumplan para el
# correcto funcionamiento de canaima-desarrollador
# Ver /usr/share/canaima-desarrollador/scripts/funciones-desarrollador.sh
CHECK

# Función para cargar los datos del desarrollador especificados en
# ${CONF} (nombre, correo, etc.)
# Ver /usr/share/canaima-desarrollador/scripts/funciones-desarrollador.sh
DEV-DATA


PARAMETROS=${@}
PARAMETROS=${PARAMETROS#${1}}

for ARGUMENTO in ${PARAMETROS}; do

ARG_VARIABLE=${ARGUMENTO#--}
ARG_VARIABLE=${ARG_VARIABLE%=*}
ARG_VALOR=${ARGUMENTO#--${ARG_VARIABLE}=}
ARG_VARIABLE=$( echo ${ARG_VARIABLE} | tr '[:lower:]' '[:upper:]' )
ARG_VARIABLE=$( echo ${ARG_VARIABLE} | tr '-' '_' )
eval "${ARG_VARIABLE}=${ARG_VALOR}"

done

# Case encargado de interpretar los parámetros introducidos a
# canaima-desarrollador y ejecutar la función correspondiente
case ${1} in

#------ AYUDANTES CREADORES --------------------------------------------------------------------------------------#
#=================================================================================================================#

crear-proyecto|debianizar)
if [ "${2}" == "--ayuda" ] || [ "${2}" == "--help" ] || [ -z "${2}" ]; then
cat "${DIR_AYUDA}/crear-proyecto"
else
# Guardemos los parámetros en variables para usarlos después
opcion=${OPCION}
nombre=${NOMBRE}
version=${VERSION}
destino=${DESTINO}
licencia=${LICENCIA}
CREAR-PROYECTO
fi
;;

crear-fuente)
if [ "${2}" == "--ayuda" ] || [ "${2}" == "--help" ] || [ -z "${2}" ]; then
cat "${DIR_AYUDA}/crear-fuente"
else
# Guardando directorio en variable para utilizarlo después
directorio=${DIRECTORIO}
CREAR-FUENTE
fi
;;

empaquetar)
if [ "${2}" == "--ayuda" ] || [ "${2}" == "--help" ] || [ -z "${2}" ]; then
cat "${DIR_AYUDA}/empaquetar"
else
# Guardamos los parámetros en variables para usarlas después
directorio=${DIRECTORIO}
mensaje=${MENSAJE}
procesadores=${PROCESADORES}
EMPAQUETAR
fi
;;

#------ AYUDANTES GIT --------------------------------------------------------------------------------------------#
#=================================================================================================================#
descargar|clonar|clone)
if [ "${2}" == "--ayuda" ] || [ "${2}" == "--help" ] || [ -z "${2}" ]; then
cat "${DIR_AYUDA}/descargar"
else
# Guardemos el segundo argumento en la varible "proyecto"
proyecto=${PROYECTO}
# Ejecutemos la función correspondiente
DESCARGAR
fi
;;

registrar|commit)
if [ "${2}" == "--ayuda" ] || [ "${2}" == "--help" ] || [ -z "${2}" ]; then
cat "${DIR_AYUDA}/registrar"
else
# Guardemos los parámetros en variables para usarlos después
directorio=${DIRECTORIO}
mensaje=${MENSAJE}
REGISTRAR
fi
;;

enviar|push)
if [ "${2}" == "--ayuda" ] || [ "${2}" == "--help" ] || [ -z "${2}" ]; then
cat "${DIR_AYUDA}/enviar"
else
# Guardando directorio en variable para utilizarlo después
directorio=${DIRECTORIO}
ENVIAR
fi
;;

actualizar|pull)
if [ "${2}" == "--ayuda" ] || [ "${2}" == "--help" ] || [ -z "${2}" ]; then
cat "${DIR_AYUDA}/actualizar"
else
# Guardando directorio en variable para utilizarlo después
directorio=${DIRECTORIO}
ACTUALIZAR
fi
;;

#------ AYUDANTES MASIVOS ----------------------------------------------------------------------------------------#
#=================================================================================================================#

descargar-todo|clonar-todo)
if [ "${2}" == "--ayuda" ] || [ $"{2}" == "--help" ]; then
cat "${DIR_AYUDA}/descargar-todo"
else
DESCARGAR-TODO
fi
;;

registrar-todo|commit-todo)
if [ "${2}" == "--ayuda" ] || [ $"{2}" == "--help" ]; then
cat "${DIR_AYUDA}/registrar-todo"
else
mensaje="auto"
REGISTRAR-TODO
fi
;;

enviar-todo|push-todo)
if [ "${2}" == "--ayuda" ] || [ $"{2}" == "--help" ]; then
cat "${DIR_AYUDA}/enviar-todo"
else
ENVIAR-TODO
fi
;;

actualizar-todo|pull-todo)
if [ "${2}" == "--ayuda" ] || [ $"{2}" == "--help" ]; then
cat "${DIR_AYUDA}/actualizar-todo"
else
ACTUALIZAR-TODO
fi
;;

empaquetar-varios)
if [ "${2}" == "--ayuda" ] || [ "${2}" == "--help" ] || [ -z "${2}" ]; then
cat "${DIR_AYUDA}/empaquetar-varios"
else
# Guardamos los parámetros en variables para usarlas después
para_empaquetar=${PARA_EMPAQUETAR}
mensaje="auto"
procesadores=${PROCESADORES}
EMPAQUETAR-VARIOS
fi
;;

empaquetar-todo)
if [ "${2}" == "--ayuda" ] || [ "${2}" == "--help" ] || [ -z "${2}" ]; then
cat "${DIR_AYUDA}/empaquetar-todo"
else
mensaje="auto"
procesadores=${PROCESADORES}
EMPAQUETAR-TODO
fi
;;


#------ AYUDANTES INFORMATIVOS -----------------------------------------------------------------------------------------#
#=======================================================================================================================#

listar-remotos)
if [ "${2}" == "--ayuda" ] || [ $"{2}" == "--help" ]; then
cat "${DIR_AYUDA}/listar-remotos"
else
LISTAR-REMOTOS
fi
;;

listar-locales)
if [ "${2}" == "--ayuda" ] || [ $"{2}" == "--help" ]; then
cat "${DIR_AYUDA}/listar-locales"
else
LISTAR-LOCALES
fi
;;

--ayuda|--help|'')
# Imprimiendo la ayuda
cat "${DIR_AYUDA}/canaima-desarrollador"
;;

*)
ERROR "No conozco el ayudante '"${1}"', échale un ojo a la documentación (man canaima-desarrollador)"
;;
esac

exit 0
