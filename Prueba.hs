--Tp Monopoly
import Text.Show.Functions ()

type Nombre = String
type Precio = Int
type Propiedad = (Nombre , Precio)

data Jugador = UnJugador{
    nombre :: String,
    cantDinero :: Int,
    tactica :: String,
    propiedadesCompradas :: [Propiedad],
    acciones :: [Accion]
} deriving Show

carolina :: Jugador
carolina = UnJugador{
    nombre = "Carolina",
    cantDinero = 0,
    tactica = "Accionista",
    propiedadesCompradas = [],
    acciones = [pasarPorElBanco]
}
manuel :: Jugador
manuel = UnJugador{
    nombre = "Manuel",
    cantDinero = 0,
    tactica = "Oferente singular",
    propiedadesCompradas = [],
    acciones = [pasarPorElBanco]
}

type Accion = Jugador -> Jugador

precioPropiedad :: Propiedad -> Int
precioPropiedad unaPropiedad = snd unaPropiedad

aumentaDinero ::  Int -> Jugador  -> Jugador
aumentaDinero unDinero alguienQueJuega = alguienQueJuega {cantDinero = cantDinero alguienQueJuega + unDinero}

disminuyeDinero ::  Int -> Jugador  -> Jugador
disminuyeDinero unDinero unJugador = unJugador {cantDinero = cantDinero unJugador - unDinero}

cambiarTacticaACompradorCompulsivo :: Jugador -> Jugador
cambiarTacticaACompradorCompulsivo  unJugador = unJugador {tactica = "Comprador compulsivo"}


agregaAccion :: Accion -> Jugador -> Jugador
agregaAccion unaAccion unJugador = unJugador {acciones = acciones unJugador ++ [unaAccion]}


agregaAlNombre :: String -> Jugador -> Jugador
agregaAlNombre unaPalabra unJugador = unJugador{nombre= unaPalabra ++ nombre unJugador}

propiedadBarata :: Propiedad -> Bool
propiedadBarata unaPropiedad = precioPropiedad unaPropiedad < 150

precioAlquiler :: Propiedad -> Int
precioAlquiler unaPropiedad
    | propiedadBarata unaPropiedad = 10
    | otherwise = 20

pasarPorElBanco :: Accion
pasarPorElBanco unJugador = cambiarTacticaACompradorCompulsivo . aumentaDinero 40 $ unJugador

enojarse :: Accion
enojarse unJugador = aumentaDinero 50 . agregaAccion gritar $ unJugador

gritar :: Accion
gritar unJugador = agregaAlNombre "AHHH" unJugador

subastar :: Propiedad -> Accion
subastar unaPropiedad unJugador 
    | tactica unJugador == "Oferente singular" || tactica unJugador == "Accionista" = unJugador{cantDinero = cantDinero unJugador - precioPropiedad unaPropiedad, propiedadesCompradas = propiedadesCompradas unJugador ++ [unaPropiedad]}
    | otherwise = unJugador


pagarAAccionistas :: Accion
pagarAAccionistas unJugador
    | tactica unJugador == "Accionista" = aumentaDinero 200 unJugador
    | otherwise = disminuyeDinero 100 unJugador

{-cobrarAlquileres :: Accion
cobrarAlquileres unJugador = 
-}