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
ataqueEntreNaves naveAtacada naveQueAtaca
    | (escudo . activarPoder $ naveAtacada) >= (ataque . activarPoder $ naveQueAtaca) = naveAtacada{escudo = escudo naveAtacada - ataque naveQueAtaca} 
    | otherwise = naveAtacada{durabilidad = durabilidad naveAtacada - diferenciaEntreAtaqueYEscudo naveAtacada naveQueAtaca}


activarPoder :: [Poder] -> Nave -> Nave
activarPoder unosPoderes unaNave = foldr aplicarPoderes unaNave unosPoderes

aplicarPoderes :: Poder -> Nave -> Nave
aplicarPoderes unPoder unaNave = unPoder unaNave

diferenciaEntreAtaqueYEscudo :: Nave -> Nave -> Int
diferenciaEntreAtaqueYEscudo naveAtacada naveQueAtaca = abs (escudo naveAtacada - ataque naveQueAtaca)
-}
--4

naveFueraDeCombate :: Nave -> Bool
naveFueraDeCombate unaNave = durabilidad unaNave == 0

--5

type Estrategia = (Nave -> Bool)

navesDebiles :: Estrategia
navesDebiles unaNave = escudo unaNave < 200