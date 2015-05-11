#Глобальное объявление
Input = document.getElementById("input-area")
Output = document.getElementById("output-area")
Input.value = ""
Output.value = ""
InputMassive = []
Convol = []
value_command = []

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

streamWords = ->
  stage = Input.value
  num_n = -1
  if event.keyCode is 13
    for word in stage
      for i in [0..word.length]
        if word.charAt(i) is "\n" then num_n++
    InputMassive = stage.split("\n")
    lexicalAnalysis(InputMassive,num_n)
    Convol.push([0,0]) #new command
    syntaxAnalys(num_n)

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

#########################
#Синтаксический анализатор
syntaxAnalys = (n) ->

  if Convol[0][0] is 1 and Convol[0][1] is 0 #ROW
    if Convol[1][0] is 3 #if literal
      if Literals[Convol[1][1]][1] is off and Literals[Convol[1][1]][2] is off and Literals[Convol[1][1]][3] is off #if unused
        if Convol[2][0] is 2 and Convol[2][1] is 0
          if Convol[3][0] is 4
            if Convol[4][0] is 2 and Convol[4][1] is 1
              if Convol[5][0] is 4
                if Convol[6][0] is 2 and Convol[6][1] is 2
                  if Convol[7][0] is 0
                    Literals[Convol[1][1]][3] = "ROWVECTOR"
                    Literals[Convol[1][1]][1] = Convol[3][1]
                    Literals[Convol[1][1]][2] = Convol[5][1]
                    console.log(Convol)
                    console.log(Literals)
                    Convol = []

  ###if Convol[0][0] is 1 and Convol[0][1] is 1
    console.log("COL")
  if Convol[0][0] is 1 and Convol[0][1] is 2
    console.log("MATRIX")
  if Convol[0][0] is 1 and Convol[0][1] is 3 #PRINT
    console.log("PRIIIINT")###










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
      return on
  return off

isNumber = (str,command) ->
  if "0" <= str <= "9"
    Convol.push([4,str])
    value_command.push(str)
    console.log("courseos@razumov:~> " + str + " is number")
    return on
  return off

isSeparator = (str,command) ->
  for word, index in Separators
    if word is str
      Convol.push([2, index])
      console.log("courseos@razumov:~> " + Separators[index] + " is separator")
      return on
  return off

isLiteral = (str,command) ->
  if ("A" <= str <= "Z")
    flag = false
    for word, index in Literals
      if word[0] is str
        Convol.push([3, index])
        console.log("courseos@razumov:~> " + str + " is literal")
        flag = true
    if flag is off
      console.log("courseos@razumov:~> " + str + " is new literal")
      Literals.push([str,off,off,off]) #name value1 value2 type
      console.log(Literals[0])
      Convol.push([3,Literals.length-1])
    return on
  return off




