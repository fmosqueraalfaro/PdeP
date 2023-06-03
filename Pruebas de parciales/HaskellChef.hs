data Participante = 
    Participante{
    nombre :: String,
    trucosDeCocina :: [Truco],
    platoEspecial :: Plato
    } 

type Truco = Plato -> Plato
data Plato = 
    Plato{
        nombreDePlato :: String,
        componentes :: [Componente],
        dificultad :: Int
    }
type Componente = (Ingrediente , Peso)
type Peso = Int
type Ingrediente = String
type Dificultad = Int

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
