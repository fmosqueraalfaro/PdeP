data Nave = Nave{
    nombre :: String,
    durabilidad :: Int,
    escudo :: Int,
    ataque :: Int,
    poder :: [Poder]
} 

type Poder = (Nave -> Nave)

tieFighter :: Nave
tieFighter = Nave "TIE Fighter" 200 100 50 [movimientoTurbo]

movimientoTurbo :: Poder
movimientoTurbo unaNave = unaNave{ataque = ataque unaNave + 25}

xWing :: Nave
xWing = Nave "X Wing" 300 150 100 [reparacionDeEmergencia]

reparacionDeEmergencia :: Poder
reparacionDeEmergencia unaNave = unaNave{durabilidad = durabilidad unaNave + 50 , ataque = ataque unaNave - 30}

naveDeDarthVader :: Nave
naveDeDarthVader = Nave "Nave de Darth Vader" 500 300 200 [movimientoSuperTurbo]

movimientoSuperTurbo :: Poder
movimientoSuperTurbo unaNave = unaNave{ataque = ataque unaNave + 75 , durabilidad = durabilidad unaNave - 45}

millenniumFalcon :: Nave
millenniumFalcon = Nave "Millennium Falcon" 1000 500 50 [reparacionDeEmergencia , incrementoEscudosEn100]

incrementoEscudosEn100 :: Poder
incrementoEscudosEn100 unaNave = unaNave {escudo = escudo unaNave + 100}

scaloneta2022 :: Nave
scaloneta2022 = Nave "Scaloneta 2022" 5000 2500 5000 [lionelMessi]

--Lionel Messi es un poder que dobla el ataque de la Scaloneta

lionelMessi :: Poder
lionelMessi unaNave = unaNave{ataque = ataque unaNave * 2}

--2

durabilidadTotal :: [Nave] -> Int
durabilidadTotal unasNaves = sum . durabilidadDeNaves $ unasNaves

durabilidadDeNaves :: [Nave] -> [Int]
durabilidadDeNaves unasNaves = map (durabilidad) unasNaves

--3
{-
ataqueEntreNaves :: Nave -> Nave -> Nave
ataqueEntreNaves naveAtacada naveAtacante
    | (escudo . activarPoder $ naveAtacada) >= (ataque . activarPoder $ naveAtacantecada{escudo = escudo naveAtacada - ataque naveAtacante} 
    | otherwise = naveAtacada{durabilidad = durabilidad naveAtacada - diferenciaEntreAtaqueYEscudo naveAtacada naveAtacante}

activarPoder :: [Poder] -> Nave -> Nave
activarPoder unosPoderes unaNave = foldr aplicarPoderes unaNave unosPoderes

aplicarPoderes :: Poder -> Nave -> Nave
aplicarPoderes unPoder unaNave = unPoder unaNave

diferenciaEntreAtaqueYEscudo :: Nave -> Nave -> Int
diferenciaEntreAtaqueYEscudo naveAtacada naveAtacante = abs (escudo naveAtacada - ataque naveAtacante)
-}
--4

naveFueraDeCombate :: Nave -> Bool
naveFueraDeCombate unaNave = durabilidad unaNave == 0

--5

type Estrategia = (Nave -> Bool)

navesDebiles :: Estrategia
navesDebiles unaNave = escudo unaNave < 200

navesConCiertaPeligrosidad :: Int -> Estrategia
navesConCiertaPeligrosidad unValor unaNave = unValor < ataque unaNave
{-
navesQueQuedarianFueraDeCombate :: Nave -> Nave -> Bool
navesQueQuedarianFueraDeCombate naveAtacada naveAtacante = durabilidad . ataqueEntreNaves $ naveAtacada naveAtacante == 0
-}

usarALionel :: Estrategia
usarALionel unaNave = ataque unaNave > 5000

{-
misionSorpresa :: Nave -> Nave -> Nave
misionSorpresa unaNave otraNave 
    |navesDebiles unaNave = ataqueEntreNaves unaNave otraNave
    |navesConCientaPeligrosidad 300 unaNave = ataqueEntreNaves unaNave OtraNave
    |navesQueQuedarianFueraDeCombate unaNave otraNave = ataqueEntreNaves unaNave OtraNave
    |usarALionel otraNave = ataqueEntreNaves unaNave otraNave
    -}
