data Participante = Participante{
    nombre :: String,
    trucosDeCocina :: [Truco],
    platoEspecial :: Plato
    }

type Truco = Plato -> Plato
data Plato = 
    Plato{
        componentes :: [Componente],
        dificultad :: Int
    } deriving Show
type Componente = (Ingrediente , Cantidad)
type Cantidad = Int
type Ingrediente = String
type Dificultad = Int


--Parte A


endulzar :: Int -> Truco
endulzar unosGramos unPlato = agregarComponente "Azucar" unosGramos unPlato

agregarComponente :: String -> Int -> Plato -> Plato
agregarComponente unNombre unosGramos unPlato = modificarComponentes (\unosComponentes -> (unNombre, unosGramos) : unosComponentes) unPlato

modificarComponentes :: ([Componente] -> [Componente]) -> Plato -> Plato
modificarComponentes unaFuncion unPlato = unPlato { componentes = unaFuncion . componentes $ unPlato }

salar :: Int -> Truco
salar unosGramos unPlato = agregarComponente "Sal" unosGramos unPlato

darSabor :: Int -> Int -> Truco
darSabor unosGramosDeSal unosGramosDeAzucar unPlato = endulzar unosGramosDeAzucar . salar unosGramosDeSal $ unPlato

duplicarPorcion :: Truco
duplicarPorcion unPlato = modificarComponentes (map duplicarCantidad) unPlato

duplicarCantidad :: Componente -> Componente
duplicarCantidad (ingrediente, cantidad) = (ingrediente, cantidad * 2)

simplificar :: Truco
simplificar unPlato 
    | esUnBardo unPlato = disminuyeDificultad . quitarComponentes $ unPlato
    | otherwise = unPlato

esUnBardo :: Plato -> Bool
esUnBardo unPlato = cantidadDeComponentes unPlato > 5 && dificultad unPlato >= 7

cantidadDeComponentes :: Plato -> Int
cantidadDeComponentes unPlato = length . componentes $ unPlato

disminuyeDificultad :: Plato -> Plato
disminuyeDificultad unPlato = unPlato{dificultad = 5}

quitarComponentes :: Plato -> Plato
quitarComponentes unPlato = modificarComponentes (filter hayMucho) $ unPlato

hayMucho :: Componente -> Bool
hayMucho unComponente = snd unComponente >= 10

esVegano :: Plato -> Bool
esVegano unPlato = not . any esProductoAnimal . componentes $ unPlato

esProductoAnimal :: Componente -> Bool
esProductoAnimal (ingrediente,_) = elem ingrediente productosAnimales

productosAnimales :: [Ingrediente]
productosAnimales = ["Leche", "Carne", "Huevo", "Manteca"]

esSinTacc :: Plato -> Bool
esSinTacc unPlato = not . tiene "Harina" $ unPlato

tiene :: Ingrediente -> Plato -> Bool
tiene unIngrediente unPlato = elem unIngrediente . ingredientes $ unPlato 

ingredientes :: Plato -> [Ingrediente]
ingredientes unPlato = map (fst) . componentes $ unPlato

esComplejo :: Plato -> Bool
esComplejo unPlato = esUnBardo unPlato

noAptoHipertension :: Plato -> Bool
noAptoHipertension unPlato = any tieneMuchaSal . componentes $ unPlato

tieneMuchaSal :: Componente -> Bool
tieneMuchaSal (ingrediente , cantidad) = ingrediente == "Sal" && cantidad > 2


--Parte B


pepe :: Participante
pepe = Participante "Pepe Roncino" [darSabor 2 5 , simplificar , duplicarPorcion] platoComplejo

platoComplejo :: Plato
platoComplejo = Plato [("Sal", 100), ("Sal", 100), ("Sal", 100), ("Sal", 100), ("Sal", 100), ("Sal", 100)] 10 


--Parte C


cocinar :: Participante -> Plato
cocinar unParticipante = aplicarTrucos (trucosDeCocina unParticipante) (platoEspecial unParticipante)

aplicarTrucos :: [Truco] -> Plato -> Plato
aplicarTrucos unosTrucos unPlato = foldr ($) unPlato unosTrucos

esMejorQue :: Plato -> Plato -> Bool
esMejorQue unPlato otroPlato = esMasDificil unPlato otroPlato && esMasLigero unPlato otroPlato

esMasDificil :: Plato -> Plato -> Bool
esMasDificil unPlato otroPlato = dificultad unPlato > dificultad otroPlato

esMasLigero :: Plato -> Plato -> Bool
esMasLigero unPlato otroPlato = peso  unPlato > peso  otroPlato

peso :: Plato -> Cantidad
peso unPlato = sum . map cantidad . componentes $ unPlato

cantidad:: Componente -> Cantidad
cantidad unComponente = snd unComponente

participanteEstrella :: [Participante] -> Participante
participanteEstrella unosParticipantes = foldr1 mejorParticipante unosParticipantes

mejorParticipante :: Participante -> Participante -> Participante
mejorParticipante unParticipante otroParticipante
    | esMejorQue (cocinar unParticipante) (cocinar otroParticipante) = unParticipante
    | otherwise = otroParticipante


--Parte D


platinum :: Plato
platinum = Plato unaListaDecomponentesRara 10

unaListaDecomponentesRara :: [Componente]
unaListaDecomponentesRara =
  map (\unNumero -> ("Ingrediente " ++ show unNumero, unNumero)) [1..]