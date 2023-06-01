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

pasarPorElBanco :: Accion
pasarPorElBanco unJugador = cambiarTacticaACompradorCompulsivo . aumentaDinero 40 $ unJugador

aumentaDinero ::  Int -> Jugador  -> Jugador
aumentaDinero unDinero alguienQueJuega = alguienQueJuega {cantDinero = cantDinero alguienQueJuega + unDinero}

disminuyeDinero ::  Int -> Jugador  -> Jugador
disminuyeDinero unDinero unJugador = unJugador {cantDinero = cantDinero unJugador - unDinero}

cambiarTacticaACompradorCompulsivo :: Jugador -> Jugador
cambiarTacticaACompradorCompulsivo  unJugador = unJugador {tactica = "Comprador compulsivo"}

enojarse :: Accion
enojarse unJugador = aumentaDinero 50 . agregaAccion gritar $ unJugador

agregaAccion :: Accion -> Jugador -> Jugador
agregaAccion unaAccion unJugador = unJugador {acciones = acciones unJugador ++ [unaAccion]}

gritar :: Accion
gritar unJugador = agregaAlNombre "AHHH" unJugador

agregaAlNombre :: String -> Jugador -> Jugador
agregaAlNombre unaPalabra unJugador = unJugador{nombre= unaPalabra ++ nombre unJugador}


pagarAAccionistas :: Accion
pagarAAccionistas unJugador
    | tactica unJugador == "Accionista" = aumentaDinero 200 unJugador
    | otherwise = disminuyeDinero 100 unJugador

{-subastar :: Accion
subastar unJugador = undefined

puedenGanarPropiedad :: Jugador -> Bool
puedenGanarPropiedad unJugador = tactica unJugador == "Oferente singular" || tactica unJugador == "Accionista"

subastar: al momento de una subasta solo quienes tengan como tácticas “Oferente singular” o “Accionista” podrán ganar la propiedad. 
Ganar implica restar el precio de la propiedad de su dinero y sumar la nueva adquisición a sus propiedades.

ganarPropiedad :: Accion
-}
propiedadBarata :: Propiedad -> Bool
propiedadBarata unaPropiedad = precioPropiedad unaPropiedad < 150

precioAlquiler :: Propiedad -> Int
precioAlquiler unaPropiedad
    | propiedadBarata unaPropiedad = 10
    | otherwise = 20


