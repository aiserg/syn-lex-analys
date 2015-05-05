#Глобальное объявление
Input = document.getElementById("input-area")
Output = document.getElementById("output-area")
OutputString = ""
#Инициализация по заданию
Keywords = ["ROWVECTOR", "COLVECTOR", "MATRIX", "PRINT"]
Separators = ["(", ",", ")", "=", "+", "-", "*", "^", "@"]
Identifies = []
Literals = []
#Вызовы вспомогательных функций

#       #       #       #
##     ###     ###     ##
###   ### ##   #####   ##
#### ####### ####### ####
#########################
#Логика

streamWords = ->
  stage = Input.value
  if event.keyCode is 13
    lexicalAnalysis(stage)

lexicalAnalysis = (stage) ->
  stageLength = stage.length - '11'
  preResult = ''
  for i in [0..stageLength]
    if stage.charAt(i) in Separators or stage.charAt(i) is '\n' or stage.charAt(i) is ' '
      k = isKeyword(preResult)
      l = off
      if k is off then l = isLiteral(preResult)
      n = isNumber(preResult)
      if k is off and l is off and n is off then console.log("undefined symbol")
      s = isSeparator(stage.charAt(i))
      preResult = ''
      continue

    preResult += stage.charAt(i)



Input.addEventListener('keyup', streamWords, false)

#       #       #       #
##     ###     ###     ##innerhtml очистить
###   #####  #####   ###
#### ####### ####### ####
#########################
lineNumbers = ->
  highLine = document.getElementById("high-line-numbers")
  lowLine = document.getElementById("low-line-numbers")
  for i in [1..50]
    highLine.innerHTML += i + "\n"
    lowLine.innerHTML += i + "\n"
lineNumbers()

isKeyword = (str) ->
  for word, index in Keywords
    if word is str
      console.log(Keywords[index] + " keyword")
      return on
  return off

isNumber = (str) ->
  if "0" <= str <= "9"
    console.log(str + " number  ")
    return on
  else return off

isSeparator = (str) ->
  for word, index in Separators
    if word is str
      console.log(Separators[index] + " seporator")
      return on
  return off

isLiteral = (str) ->
  if ("A" <= str <= "Z")
    console.log(str + " literal")
    return on
  else return off


###
output = (answer) ->
   Output.innerHTML = "courseos@razumov:~>  " + answer

answer = ''
output(answer)
###