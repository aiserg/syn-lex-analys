#Глобальное объявление
Input = document.getElementById("input-area")
Output = document.getElementById("output-area")
Input.value = ""
Output.value = ""
InputMassive = []
Convol = []

#Инициализация по заданию
Keywords = ["ROWVECTOR", "COLVECTOR", "MATRIX", "PRINT"]  #1 in Convol
Separators = ["(", ",", ")", "=", "+", "-", "*", "^", "@"]  #2 in Convol
Literals = []   #3 in Convol
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
    lexicalAnalysis(InputMassive,num_n)

lexicalAnalysis = (arr,n) ->
  word = arr[n]
  console.log(word)
  word = word.replace(/\s+$/, "");
  preResult = ""
  for i in [0..word.length]

    if word.charAt(i) in Separators or word.charAt(i) is ' ' or i is word.length
      iK = isKeyword(preResult,word)
      if iK is off then iL = isLiteral(preResult,word)
      iN = isNumber(preResult,word)
      iS = isSeparator(word.charAt(i),word)

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

isKeyword = (str,command) ->
  for word, index in Keywords
    if word is str
      Convol.push([1,index])
      console.log(Convol)
      return on
  return off

isNumber = (str,command) ->
  if "0" <= str <= "9"
    console.log("courseos@razumov:~> " + str + " is number")
    return on
  return off

isSeparator = (str,command) ->
  for word, index in Separators
    if word is str
      console.log("courseos@razumov:~> " + Separators[index] + " is separator")
      return on
  return off

isLiteral = (str,command) ->
  if ("A" <= str <= "Z")
    flag = false
    for word in Literals
      if word[0] is str
        console.log("courseos@razumov:~> " + str + " is literal")
        flag = true
    if flag is off
      Literals.push([str,undefined,undefined])
      Convol.push([3,Literals.length-1])
    return on
  return off

#########################
#Синтаксический анализатор

MatrixWay = () ->

