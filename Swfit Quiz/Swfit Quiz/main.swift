/*
    Brandan Tyler Lasley
    CSE335 Quiz 2 (Swift)
    2/14/2021 20:40
*/
import Foundation

// 1a
var personSage: Int?

// 1b
let gravity = 9.8

// 2
var fat = 25
switch fat {
case 0..<21:
    print("You are Underfat")
case 21..<36:
    print("You are Healthy")
case 36..<43:
    print("You are Overfat")
default:
    print("You are Obese")
}

// 3a
var someStringVar = "asdf1234"
for i in 1..<someStringVar.count+1
{
    print(Array(someStringVar)[someStringVar.count - i], terminator:"")
}

print("")


// 3b
someStringVar = "asdf1234 890989 hjkhkj 897897"
let words = someStringVar.components(separatedBy: " ")
for word in words
{
   for i in 1..<word.count+1
   {
       print(Array(word)[word.count-i], terminator:"")
   }
   print(" ", terminator:"")
}

print("")

// 4i
func sumOf(numbers: [Int]) -> (sumOdd: Int, sunEven: Int)
 {
    var oddSum  = 0
    var evenSum = 0

    for n in numbers
    {

        if ((n % 2) == 0)
        {
            evenSum = evenSum + n
        }
        else
        {
            oddSum = oddSum + n
        }
    }
    return (oddSum, evenSum)
}

// 4ii.
func searchSomeIntArray(strings: [String]) -> (shortestString: Int, longestString: Int)
{
   var shortestString   = Int.max
   var longestString    = 0
   for s in strings
    {
        if (s.count < shortestString)
        {
            shortestString = s.count
        }

        if (s.count > longestString)
        {
            longestString = s.count
        }
     }
    return (shortestString, longestString)
}

//4iii.
func doesExistInArray(numbers: [Int], numberToFind: Int) -> Bool
{
    for n in numbers
    {
        if (n == numberToFind)
        {
            return true
        }
    }
    return false
}

// 5.
class cityStatistics
{
    var name:       String          = ""
    var population: Int             = 0
    var lat:        Double          = 0.0
    var lon:        Double          = 0.0
    
    internal required init(cname: String, cpop: Int, clat: Double, clon: Double) {
        self.name = cname
        self.population = cpop
        self.lat = clat
        self.lon = clon
    }
    
    func getPopulation() -> Int
    {
        return self.population
    }
    
    func getLattitude() -> Double
    {
        return self.lat
    }
    
    func getName() -> String
    {
        return self.name
    }
}

// 6a.
var Unknown     = cityStatistics(   cname: "UNK",      cpop: -1,       clat: -1.0,     clon: -1.0      )
var Paris       = cityStatistics(   cname: "Paris",    cpop: 900,      clat: 20.5,     clon: 30.5      )
var London      = cityStatistics(   cname: "London",   cpop: 97987,    clat: 798.5,    clon: 378.5     )
var NewYork     = cityStatistics(   cname: "New York", cpop: 58765,    clat: 5678.5,   clon: 465.5     )
var Portland    = cityStatistics(   cname: "Portland", cpop: 67868,    clat: 567576.5, clon: 567567.5  )
var Phoenix     = cityStatistics(   cname: "Phoenix",  cpop: 6576,     clat: 67576.5,  clon: 3545.5    )

var TheCities:[String: cityStatistics] = ["Paris":Paris, "London":London, "NewYork":NewYork, "Portland":Portland, "Phoenix":Phoenix]

// 6b.
var largestCity : cityStatistics = Unknown
var largestCityPop: Int = 0
for (_, CityObj) in TheCities
{
    if (CityObj.getPopulation() > largestCityPop)
    {
        largestCityPop = CityObj.getPopulation()
        largestCity = CityObj
    }
}
print("The largest city is " + largestCity.getName() + " with population " + String(largestCity.getPopulation()) )

// 6c.
var northestCity : cityStatistics = Unknown
var northestLat : Double = 0
for (_, CityObj) in TheCities
{
    if (CityObj.getLattitude() > northestLat)
    {
        northestLat = CityObj.getLattitude()
        northestCity = CityObj
    }
}
print("The northest city is " + northestCity.getName() )


// 7.
var students : [[String:Any]] =
[[ "firstName": "John", "lastName": "Wilson", "gpa": 2.4 ], [
"firstName": "Nancy", "lastName": "Smith", "gpa": 3.5 ], [
"firstName": "Michael", "lastName": "Liu", "gpa": 3.1 ]]

var StudentWithHighestGpa : [String:Any] = [ "firstName": "UNK", "lastName": "UNK", "gpa": -1.0 ]

for student in students
{
    if (student["gpa"] as! Double > StudentWithHighestGpa["gpa"] as! Double)
    {
        StudentWithHighestGpa = student
    }
}

print(StudentWithHighestGpa)
