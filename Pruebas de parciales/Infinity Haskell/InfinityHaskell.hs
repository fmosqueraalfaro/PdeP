import Text.Show.Functions
--Parte A

--1
data Personaje = Personaje{
    nombre :: String,
    poder :: Int,
    victorias :: [Victoria],
    equipamientos :: [Equipamiento]
} deriving Show 
type Victoria = (Oponente , Año)

type Oponente = String

type Año = Int


entrenamiento::[Personaje] -> [Personaje]
entrenamiento personajes = map (entrenamientoPersonal (length personajes)) personajes

entrenamientoPersonal:: Int -> Personaje -> Personaje
entrenamientoPersonal cantidadEntrenando personaje = modificarPoder (*cantidadEntrenando) personaje

modificarPoder::(Int -> Int) -> Personaje -> Personaje
modificarPoder modificador personaje = personaje{poder = modificador.poder $ personaje}

rivalesDignos :: [Personaje] -> [Personaje]
rivalesDignos personajes =  filter rivalDigno . entrenamiento $ personajes

rivalDigno :: Personaje -> Bool
rivalDigno unPersonaje = poder unPersonaje > 500 && derrotoA "Hijo de Thanos" unPersonaje

derrotoA :: String -> Personaje -> Bool
derrotoA derrotado personaje = elem derrotado $ map (fst) . victorias $ personaje 

guerraCivil :: [Personaje] -> [Personaje] -> [Personaje]
guerraCivil unosPersonajes otrosPersonajes = zipWith pelea unosPersonajes otrosPersonajes

pelea :: Personaje -> Personaje -> Personaje
pelea unPersonaje otroPersonaje 
    | poder unPersonaje > poder otroPersonaje = ganarleA unPersonaje otroPersonaje
    | otherwise = ganarleA otroPersonaje otroPersonaje

ganarleA::Personaje -> Personaje -> Personaje
ganarleA ganador perdedor = modificaVictorias (++ [(nombre perdedor, 2018)]) ganador

modificaVictorias :: ([Victoria] -> [Victoria]) -> Personaje -> Personaje
modificaVictorias modificador personaje = personaje{victorias = modificador . victorias $ personaje}


-- Parte B

type Equipamiento = (Personaje -> Personaje)

escudo :: Equipamiento
escudo unPersonaje 
    | (<5) . cantidadDeVictorias $ unPersonaje = modificarPoder (+50) unPersonaje
    | otherwise = modificarPoder (subtract 100) unPersonaje

cantidadDeVictorias :: Personaje -> Int
cantidadDeVictorias unPersonaje = length . victorias $ unPersonaje

trajeMecanizado ::String -> Equipamiento
trajeMecanizado versionDeTraje unPersonaje = unPersonaje {nombre = "Iron" ++ nombre unPersonaje ++ versionDeTraje}

--3

stormBreaker :: Equipamiento
stormBreaker unPersonaje
    | elPersonajeEs "Thor" unPersonaje = modificarNombre (++ "diosDelTrueno") unPersonaje
    | otherwise = unPersonaje

elPersonajeEs :: String -> Personaje -> Bool
elPersonajeEs unNombre unPersonaje = nombre unPersonaje == unNombre

modificarNombre :: (String -> String) -> Personaje -> Personaje
modificarNombre modificador unPersonaje = unPersonaje{nombre = modificador . nombre $ unPersonaje}

gemaDelAlma :: Equipamiento
gemaDelAlma unPersonaje = esEquipamientoExclusivoDe "Thanos" vencerATodoElMundo unPersonaje

esEquipamientoExclusivoDe :: String -> (Personaje -> Personaje) -> Personaje -> Personaje
esEquipamientoExclusivoDe unNombre unaFuncion unPersonaje 
    | nombre unPersonaje == unNombre = unaFuncion unPersonaje
    | otherwise = unPersonaje


vencerATodoElMundo :: Personaje -> Personaje
vencerATodoElMundo unPersonaje = modificaVictorias (++ listaDeVencidos) unPersonaje

listaDeVencidos :: [Victoria]
listaDeVencidos = zip listaDeExtras listaDeAños

listaDeExtras :: [String]
listaDeExtras = map (\ unNumero -> "Extra numero" ++ show unNumero) [1..]

listaDeAños :: [Int]
listaDeAños = [2018 ..]

{- guanteleteInfinito :: Personaje -> [Equipamiento]
guanteleteInfinito unPersonaje = filter esGemaDelInfitino . equipamientos $ unPersonaje -}