//
//  API.swift
//  PolarIOS
//
//  Created by Oscar San juan on 4/1/20.
//  Copyright © 2020 Oscar San juan. All rights reserved.
//

import Foundation

let URL_SERVER = "https://appis.autoservicio.com.mx"

let API_KEY = "AIzaSyDguo0Dr8jYjvuB_1XBTx_TIOKq3myasqo"

/*** OPEN PAY SANDBOX ***/
/*let OPENDAY_ID = "m4tzxvoqsrbwdwueceeq"
let OPENPAY_PRIVATE_KEY = "sk_5a1c498f8e9f4b118a83fc5355a39053"
let OPENPAY_PUBLIC_KEY = "pk_c4959aea8ebb4d4f94d9255a46c0eca1"
let OPENPAY_URL = "https://sandbox-api.openpay.mx/v1"
let OPENPAY_PRODUCTION_MODE = false*/

/*** OPEN PAY PROD ***/
let OPENDAY_ID = "m4puwlmcsisiixkrjer9"
let OPENPAY_PRIVATE_KEY = "sk_4f75371aa7b2410aa9a1a1fa8139b7b4"
let OPENPAY_PUBLIC_KEY = "pk_cf106319591147c4bea14f78044a0a30"
let OPENPAY_URL = "https://api.openpay.mx/v1"
let OPENPAY_PRODUCTION_MODE = true

/***************************** URLS ******************************/

let URL_LOGIN = "\(URL_SERVER)/login.php"
let URL_ADD_USER = "\(URL_SERVER)/usuariosService.php"
let URL_ADD_VEHICLE = "\(URL_SERVER)/autosService.php"
let URL_ADD_PROGRAM_SERVICE = URL_SERVER + "/servicios_programados.php"

let URL_RECOVERY_PWD = "\(URL_SERVER)/recuperarpassword.php"
let URL_EXIST_USER = "\(URL_SERVER)/esUsuario.php"
let URL_VALIDATE_CODE = "\(URL_SERVER)/validaCodigo.php"
let URL_UPDATE_USER = "\(URL_SERVER)/UsuariosUpdateService.php"

let URL_GET_VEHICLES = "\(URL_SERVER)/vautosService.php?CORREO="
let URL_GET_TRACING = "\(URL_SERVER)/vseguimientoService.php?PK_USUARIO="
let URL_GET_STATUS = "\(URL_SERVER)/estatus.php"
let URL_GET_SETTINGS = "\(URL_SERVER)/configuracionService.php"
let URL_GET_BRANDS = "\(URL_SERVER)/marcasService.php"
let URL_GET_MODELS = "\(URL_SERVER)/modelosService.php?PK_MARCA="
let URL_GET_STATES = "\(URL_SERVER)/estadosService.php"
let URL_GET_CATEGORY_SERVICES = "\(URL_SERVER)/getServicesByCategoryJson.php"

let URL_PRIVACY = "http://autoservicio.com.mx/avisodeprivacidad.html"
let URL_TERMS = "http://autoservicio.com.mx/terminosycondiciones.html"

let URL_GET_PLACE_AUTOCOMPLETE = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=address&language=es&components=country:mx&key=%@"
let URL_GET_PLACE_DETAIL = "https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@"
let URL_GET_ADDRESS_FROM_LATLNG = "https://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&key=%@"

/***
 *  OPENPAY URLS
 */

let URL_ADD_CARD = "\(OPENPAY_URL)/\(OPENDAY_ID)/customers/%@/cards"
let URL_GET_CARDS = "\(OPENPAY_URL)/\(OPENDAY_ID)/customers/%@/cards"
let URL_DELETE_CARD = "\(OPENPAY_URL)/\(OPENDAY_ID)/customers/%@/cards/%@"
