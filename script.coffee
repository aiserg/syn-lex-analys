Input = document.getElementById("input-area")
Output = document.getElementById("output-area")

###Database###

Keywords = {
  1: "ROWVECTOR",
  2: "COLVECTOR",
  3: "MATRIX",
  4: "PRINT"
}

Sepfretors = {
  1: "("
  2: ","
  3: ")"
  4: "="
  5: "+"
  6: "-"
  7: "*"
  8: "^"
  9: "@"
}

Identifies ={

}

Literals = {

}

lineNumbers = ->
  highLine = document.getElementById("high-line-numbers")
  lowLine = document.getElementById("low-line-numbers")
  for i in [1..50]
    highLine.innerHTML += i + "\n"
    lowLine.innerHTML += i + "\n"

lineNumbers()

output = (answer) ->
   Output.innerHTML = "courseos@razumov:~>  " + answer

answer = ''

output(answer)

