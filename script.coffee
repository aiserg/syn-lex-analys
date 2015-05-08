#Глобальное объявление
Input = document.getElementById("input-area")
Output = document.getElementById("output-area")
Input.value = ""
Output.value = ""
InputMassive = []

#Инициализация по заданию
Keywords = ["ROWVECTOR", "COLVECTOR", "MATRIX", "PRINT"]
Separators = ["(", ",", ")", "=", "+", "-", "*", "^", "@"]
Identifies = [""]
Literals = []
#Вызовы вспомогательных функций

#       #       #       #
##     ###     ###     ##
###   ### ##   #####   ##
#### ####### ####### ####
#########################
#Логика
console.log("courseos@razumov:~> Let's test!")

#Separators. push([1,2])

streamWords = ->
  stage = Input.value
  num_n = -1
  if event.keyCode is 13
    for word in stage
      for i in [0..word.length]
        if word.charAt(i) is "\n" then num_n++
    InputMassive = stage.split("\n")
    console.log(InputMassive)
    lexicalAnalysis(InputMassive,num_n)

lexicalAnalysis = (arr,n) ->
  word = arr[n]
  word = word.replace(/\s+$/, "");
  preResult = ""
  for i in [0..word.length]
    #console.log(word.charAt(i))
    if word.charAt(i) in Separators or word.charAt(i) is ' ' or i is word.length
      iK = isKeyword(preResult)
      if iK is off then iL = isLiteral(preResult)
      iN = isNumber(preResult)
      iS = isSeparator(word.charAt(i))

      if iK is on
        preResult = ""
        continue

      if iS is on
        preResult = ""
        continue

      if iL is on
        preResult = ""
        continue

      if iN is on
        preResult = ""
        continue

      if word.charAt(i-1) in Separators then continue
      if word.charAt(i-1) is " " then continue
      if word.charAt(i) is "" then continue

      console.log("undefined symbol")

      preResult = ""

      continue
    preResult += word.charAt(i)

Input.addEventListener('keyup', streamWords, false)

#       #       #       #
##     ###     ###     ##
###   ### ##  #####   ###
#### ####### ####### ####
#########################
#Вспомогательные функции

isKeyword = (str) ->
  for word, index in Keywords
    if word is str
      console.log("courseos@razumov:~> " + Keywords[index] + " is keyword")
      return on
  return off

isNumber = (str) ->
  if "0" <= str <= "9"
    console.log("courseos@razumov:~> " + str + " is number")
    return on
  return off

isSeparator = (str) ->
  for word, index in Separators
    if word is str
      console.log("courseos@razumov:~> " + Separators[index] + " is separator")
      return on
  return off

isLiteral = (str) ->
  if ("A" <= str <= "Z")
    console.log("courseos@razumov:~> " + str + " is literal")
    return on
  return off
