/*:
 # Intro a Swift
 
 */
import Foundation


//: ## variables y constantes
var size : Float = 42.0
var answer = 42
let name = "Anakin"

//: ## Todo es un objeto
Int.max
Double.abs(-42.0)


//: ## conversiones
let a = Int(size)
let ans = String(answer)

//: ## typealias: sirve para otros nombres a un tipo
typealias Integer = Int

let a1 : Integer = 42

//: ## Colecciones
var swift = "Nuevo lenguaje de Apple"
swift = swift + "!"

var words = ["uno", "dos", "tres", "cuatro"]
words[0]

let numberNames = [1: "one", 2: "two"]
numberNames[2]

//: ## Iterar
var total = ""
for element in [1,2,3,4,5,5,6,7,7]{
    total = "\(total) \(element)"
}
print(total)

for (key, value) in numberNames{
    print("\(key) -- \(value)")
}

// Tuple
let pair = (1, "one")
pair.0
pair.1


for i in 1...5{
    print(i)
}

for i in 1..<5{
    print(i)
}


//: ## Funciones

func h(perico a:Int, deLosPalotes b:Int) -> Int{
    return (a + b) * a
}

h(perico: 3, deLosPalotes: 5)

// función sin nombres externos:
// la variable anónima _
func f(_ a:Int, _ b: Int) -> Int{
    return (a + b)
}

f(3,4)


func sum(_ a:Int, _ b:Int, thenMultiplyBy c:Int)->Int{
    
    return (a+b) * c
}

sum(3, 4, thenMultiplyBy: 5)

// default values
func addSuffixTo(_ a:String, suffix:String = "ingly")->String{
    
    return a + suffix
}

addSuffixTo("accord")
addSuffixTo("Objective-", suffix: "C")

// Return values
func namesofNumbers(_ a:Int) -> (Int, String, String){
    
    var val: (Int, String, String)
    
    switch a {
    case 1:
        val = (1, "one", "uno")
    case 2:
        val = (2, "two", "dos")
    default:
        val = (a, "Go check Google translator", "vete a google" )
    }
    return val
}

let r = namesofNumbers(2)
let (_, en, es) = namesofNumbers(1)

en
es
(es, en)

//: ## Funciones de alto nivel

typealias IntToIntFunc = (Int)->Int
var z : IntToIntFunc

// Funciones como parámetros
func apply(f: IntToIntFunc, n: Int)->Int{
    return f(n)
}

func doubler(a:Int)->Int{
    return a * 2
}

func add42(a:Int) ->Int{
    return a + 42
}

apply(f: doubler, n: 4)


// Funciones como valores de retorno

func compose(_ f: @escaping IntToIntFunc,
             _ h: @escaping IntToIntFunc) -> IntToIntFunc{
    
    // funciones dentro de funciones??
    func comp(a:Int) -> Int{
        return f(h(a))
    }
    return comp
}

compose(add42, doubler)(8)

let comp = compose(add42, doubler)

// Funciones de un mismo tipo, en un array
let funcs = [add42, doubler, comp]
for f in funcs{
    f(33)
}

//: ## Closure Syntax (representación literal de funciones)

func g(_ a:Int)->Int{
    return a + 42
}
// exactamente igual a...
let gg = {(a:Int) ->Int in
        return a + 42
}

g(1)
gg(1)


// sintaxis simplificada de clausuras
let closures = [g,
                {(a:Int)->Int in return a - 42},
                {a in return a + 45},
                {a in a / 42},
                {$0 * 42}
]

//: Operadores: son clausuras

typealias BinaryFunc = (Int,Int)->Int
let applier = {(f: BinaryFunc, m:Int, n:Int) ->Int
                    in
                    return f(m,n)}

applier(*, 2, 4)


// Trailing closure
func applierInv(_ m:Int, _ n:Int, f:BinaryFunc)->Int{
    return applier(f,m,n)
}

let c = applierInv(2, 4, f: {$0 * 2 + $1 * 3})

// 100% equivalent a:
let cc = applierInv(2, 4){
    return $0 * 2 + $1 * 3
}

//: ## Optionals

// empaqueto algo dentro de un opcional
var maybeAString: String? = "I'm boxed!"
var maybeAnInt: Int?
print(maybeAString ?? "yo")
print(maybeAnInt ?? 0)

// desempaquetado seguro
if let certainlyAString = maybeAString{
    print("Ya te decía yo que era una cadena, joé")
    print(certainlyAString)
}

// desempaquetado por cojones
//var allaVoy = maybeAnInt!


// Opcional desempaquetado de forma implícita
var msg : String! = "Hola Swift"
print(msg)
// Se accede como una string y no un opcional con una string
msg.uppercased()

// Vamos bien, hasta que metes la mano y está vacio: se te cae la app
var catacrac : Float!
//print(catacrac)   // Te se cae la App!

// USO: Cunado quieres que si alguna suposición falla, se caiga todo.
// Se usa en tests.

//: Aggregate types: enums, structs, classes, tuples

//: ### Valores para las enums
/*:
 * ninguno, como es el caso de LightSabreColor.
 * Un tipo homogeneo que se accede via la propiedad rawValue, como por ejemplo StarwarsAffiliation
 * Tipos asociados, distintos en cada caso. Por ejemplo, Optional.
*/




enum LightSabreColor{
    
    case Blue, Red, Green, Purple
}


struct LightSabre {
    
    // static or "class" property (stored)
    static let quote = "An elegant weapon for a more civilized time"
    
    // Instance properties
    var color : LightSabreColor = .Blue {
        // Property observer
        willSet(newValue){
            print("About to change color to \(newValue)")
        }
    }
    
    var isDoubleBladed = false
    
}

class Jedi {
    
    // Si puedes dar valor por defecto, hazlo
    // Si no, crea un init
    // solo usa opcionales cuando sea indispensable
    // No uses ! a no ser que sepas lo que estás haciendo
    
    // Stored properties
    var lightSabre = LightSabre()
    
    var name : String
    var midichlorians = 1_000
    
    var master  : Jedi?
    var padawan : Jedi?
    
    // computed property
    var fullName : String{
        get{
            var full = name
            
            if let master = master{
                full = full + " padawan of \(master.name)"
            }
            return full
        }
    }
    
    
    // Inicializadores
    init(name : String, midichlorians : Int, lightSabre : LightSabre,
         master: Jedi?, padawan : Jedi?){
        
        // Usando pattern matching y mirando al tendío
        (self.name, self.midichlorians, self.lightSabre) = (name, midichlorians, lightSabre)
        
        // El resto en plan normal
        self.master = master
        self.padawan = padawan
    }
    
    convenience init(name: String){
        self.init(name: name, midichlorians: 1000,
                  lightSabre: LightSabre(), master: nil, padawan: nil)
    }
    
    convenience init(masterName name: String){
        
        self.init(name: name, midichlorians: 10_000,
                  lightSabre: LightSabre(color: .Green ,isDoubleBladed: false),
                  master: nil, padawan: nil)
    }
    
    // Regular method
    func totalMidichlorians() -> Int {
        var total = midichlorians
        
        // Optional chaining
        if let masterMidichlorians = master?.midichlorians{
            total = total + masterMidichlorians
        }
        
        return total
    }
}

let luke = Jedi(masterName: "Luke Skywalker")


// Inheritance
class Sith : Jedi{
    
    convenience init(sithName name: String){
        
        self.init(name: name, midichlorians: 1000,
                  lightSabre: LightSabre(color: .Red, isDoubleBladed: true),
                  master: nil, padawan: nil)
    }
    
}


//: Extensions
typealias Euro = Double
extension Euro{
    var €: Double {return self}
    var $: Double {return self * 0.7}
    
}

var totalEuros = 123.€ + 45.09.$

typealias Task = ()->()
extension Int{
    func times(task: Task){
        for _ in 1...self{
            task()
        }
    }
}

4.times{
    print("My name is Groot")
}


//: Nil y la tupla que lo parió

// 2-tuples
(2,"hola")

// tuplas dentro de tuplas:3-tupla con una 2-tupla dentro
(45, ("Hola", NSDate()), 45)

// ¿Hay 1-tupla?
// NO.
(2) == 2


// ¿Qué pasa con la 0-tupla?
// representa al valor ausente. Viene a ser como nil. Es una una
// pequeña incoherencia de Swift:
// () tambien se representa como Void
// Void -> No hay valor
// nil  -> Existe el valor pero no lo tengo o es incorrecto
func p(){
    print("Hola mundo")
}

func pp()->(){
    print("Hola Mundo")
}


//: Averiguar tipo en tiempo de ejecución
type(of: 43.9)



//: ## Gestión de errores
// Palabrejas: try, throw, throws, catch, do

// Toda función que pueda generar un error, está marcada con throw
// Toda función que lanza un error, se llama con try

let err : Error

func inverse(_ n: Double) throws -> Double{
    
    guard n != 0 else{
        throw NSError(domain: "Divide by Zero", code: 42, userInfo: nil)
    }
    
    return 1 / n
}


do{
    let inv = try inverse( 42)
    
}catch{
    print("La cagamos!")
}

// Variaciones dentro del try
//try! inverse(0)  // se cae la app
try? inverse(0)

//: ### Init fallable
class Thing: NSObject{
    
    let url : NSURL
    
    init?(urlString: String) {
        let theUrl : NSURL? = NSURL(string: urlString)
        if theUrl == nil{
            // Ha fallado y hay que devolver nil
            return nil
        }else{
            url = theUrl!
        }
        super.init()
    }
}

let t = Thing(urlString: "no es una url")

//: ### Casts en Swift
class Thong : Thing{}

let tt = Thing(urlString: "http://www.google.com")

let ttt = tt as? Thong  // por las buenas
//let tttt = tt as! Thong // por las bravas


//: ### Optional Chaining
//: #### Es otra forma de desempaquetado seguro
let n : String? = "Anakin Skywalker"
let firstName = n?.components(separatedBy:" ")[0]
print(firstName ?? "Soy un opcional vacío, que conste")
let caps = firstName?.uppercased()
let maybeAFloat: Optional<Float>


//: ## Niveles de Acceso
/*: Hay 4 opciones
 
 * public: se ve fuera del módulo. Util cuancdo haces Frameworks propias
 * internal: visible dentro del módulo (framework o app en la que estás trabajando). Es la opción por defeto y no hace falta escribirla
 * fileprivate: visible solo dentro del fichero
 * private: visible solo dentro del tipo
*/

// Prinicipio de un implementación de un Bag(http://algs4.cs.princeton.edu/13stacks/)
// Es *public* porque es parte de una Framework de estructuras de datos que vamos a
// publicar en GitHub y hacernos más famosos que Trump
public struct Bag<Value: Hashable>{
    
    // Esta función es privada y no quiero que se vea fuera de la implementación
    // de Bag. Además, empiezo su nombre con _ para que quede aun más claro
    private func _doSomeWeirdÑapa(){}
}
























