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

pasarPorElBanco :: Accion
pasarPorElBanco unJugador = (aumentaDinero 40 . cambiarATactica "pasarPorElBanco") unJugador

aumentaDinero ::  Jugador -> Int  -> Jugador
aumentaDinero unJugador unDinero = unJugador {cantDinero = cantDinero unJugador + unDinero}

cambiarATactica :: String -> Jugador -> Jugador
cambiarATactica unaTactica unJugador = unJugador{tactica = unaTactica }

enojarse :: Accion
enojarse unJugador = aumentaDinero 50 . agregaAccion gritar $ unJugador

agregaAccion :: Jugador -> [Accion] -> Jugador
agregaAccion unJugador unaListaDeAcciones = unJugador {acciones = acciones unJugador ++ unaListaDeAcciones}

gritar :: Accion
gritar unJugador = agregaAlNombre "AHHH" unJugador

agregaAlNombre :: Jugador -> String -> Jugador
agregaAlNombre unJugador unaPalabra = unJugador{nombre= unaPalabra ++ nombre unJugador}

subastar :: Accion
subastar unJugador = undefined

