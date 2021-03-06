##
Input = document.getElementById("input-area")
Output = document.getElementById("output-area")
Input.value = ""
Output.value = ""
InputMassive = []
Convol = []

turn = []
ConvRes = []
lex = 'lex'
syn = 'syn'


Keywords = ["ROWVECTOR", "COLVECTOR", "MATRIX", "PRINT"]  #1 in Convol
Separators = ["(", ",", ")", "=", "+", "-", "*", "^", "@"]  #2 in Convol
Literals = []   #3 in Convol


console.log("courseos@razumov:~> Let's test!")

#################################
#Lex analys
streamWords = ->
  stage = Input.value
  num_n = -1
  if event.keyCode is 13
    for word in stage
      for i in [0..word.length]
        if word.charAt(i) is "\n" then num_n++
    InputMassive = stage.split("\n")
    lexicalAnalysis(InputMassive,num_n)
    Convol.push([0,0])
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
#Syntax amalys
syntaxAnalys = (n) ->

  if Convol[0][0] is 1 and Convol[0][1] is 0 #ROW
    if Convol[1][0] is 3 #if literal
      if Literals[Convol[1][1]][1] is off and Literals[Convol[1][1]][3] is off and Literals[Convol[1][1]][5] is off #if unused
        if Convol[2][0] is 2 and Convol[2][1] is 0 #if "("
          if Convol[3][0] is 4 #if num1
            if Convol[4][0] is 2 and Convol[4][1] is 1 #if ","
              if Convol[5][0] is 4 #if num2
                if Convol[6][0] is 2 and Convol[6][1] is 2 #if ")"
                  if Convol[7][0] is 0 #if end of command
                    Literals[Convol[1][1]][5] = "ROWVECTOR"
                    Literals[Convol[1][1]][1] = Convol[3][1]
                    Literals[Convol[1][1]][2] = Convol[5][1]
                    deleteConvol()
                else errorMessage(lex,n)
              else errorMessage(lex,n)
            else errorMessage(lex,n)
          else errorMessage(lex,n)
        else errorMessage(lex,n)



  if Convol[0][0] is 1 and Convol[0][1] is 1 #COL
    if Convol[1][0] is 3 #if literal
      if Literals[Convol[1][1]][1] is off and Literals[Convol[1][1]][2] is off and Literals[Convol[1][1]][3] is off #if unused
        if Convol[2][0] is 2 and Convol[2][1] is 0 #if "("
          if Convol[3][0] is 4 #if num1
            if Convol[4][0] is 2 and Convol[4][1] is 1 #if ","
              if Convol[5][0] is 4 #if num2
                if Convol[6][0] is 2 and Convol[6][1] is 2 #if ")"
                  if Convol[7][0] is 0 #if end of command
                    Literals[Convol[1][1]][5] = "COLVECTOR"
                    Literals[Convol[1][1]][1] = Convol[3][1]
                    Literals[Convol[1][1]][2] = Convol[5][1]
                    deleteConvol()
                else errorMessage(lex,n)
              else errorMessage(lex,n)
            else errorMessage(lex,n)
          else errorMessage(lex,n)



  if Convol[0][0] is 1 and Convol[0][1] is 2 #MATRIX
    if Convol[1][0] is 3 #if literal
      if Literals[Convol[1][1]][1] is off and Literals[Convol[1][1]][2] is off and Literals[Convol[1][1]][3] is off #if unused
        if Convol[2][0] is 2 and Convol[2][1] is 0 #if "("
          if Convol[3][0] is 2 and Convol[3][1] is 0 #if "("
            if Convol[4][0] is 4 #if num1
              if Convol[5][0] is 2 and Convol[5][1] is 1 #if ","
                if Convol[6][0] is 4 #if num2
                  if Convol[7][0] is 2 and Convol[7][1] is 2 #if ")"
                    if Convol[8][0] is 2 and Convol[8][1] is 0 #if "("
                      if Convol[9][0] is 4 #if num3
                        if Convol[10][0] is 2 and Convol[10][1] is 1 #if ","
                          if Convol[11][0] is 4 #if num4
                            if Convol[12][0] is 2 and Convol[12][1] is 2 #if ")"
                              if Convol[13][0] is 2 and Convol[13][1] is 2 #if ")"
                                if Convol[14][0] is 0 #if end of command
                                  Literals[Convol[1][1]][5] = "MATRIX"
                                  Literals[Convol[1][1]][1] = Convol[4][1]
                                  Literals[Convol[1][1]][2] = Convol[6][1]
                                  Literals[Convol[1][1]][3] = Convol[9][1]
                                  Literals[Convol[1][1]][4] = Convol[11][1]
                                  deleteConvol()
                              else errorMessage(lex,n)
                            else errorMessage(lex,n)
                          else errorMessage(lex,n)
                        else errorMessage(lex,n)
                      else errorMessage(lex,n)
                    else errorMessage(lex,n)
                  else errorMessage(lex,n)
                else errorMessage(lex,n)
              else errorMessage(lex,n)
            else errorMessage(lex,n)
          else errorMessage(lex,n)
        else errorMessage(lex,n)
      else errorMessage(lex,n)


  if Convol[0][0] is 1 and Convol[0][1] is 3 #PRINT
    if Convol[1][0] is 2 and Convol[1][1] is 0 #if "("
      if Convol[2][0] is 3 #if literal
        if Convol[3][0] is 2 and Convol[3][1] is 2 #if ")"
          if Convol[4][0] is 0 #if end of command
            for word in Literals
              if word[0] is Literals[Convol[2][1]][0] and Literals[Convol[2][1]][5] isnt off
                if Literals[Convol[2][1]][5] is "MATRIX"
                  Output.value += Literals[Convol[2][1]][1]+" "
                  Output.value += Literals[Convol[2][1]][2]+"\n"
                  Output.value += Literals[Convol[2][1]][3]+" "
                  Output.value += Literals[Convol[2][1]][4]+"\n"+"\n"
                  deleteConvol()
                if Literals[Convol[2][1]][5] is "COLVECTOR"
                  Output.value += Literals[Convol[2][1]][1]+"\n"
                  Output.value += Literals[Convol[2][1]][2]+"\n"+"\n"
                  deleteConvol()
                if Literals[Convol[2][1]][5] is "ROWVECTOR"
                  Output.value += Literals[Convol[2][1]][1]+" "
                  Output.value += Literals[Convol[2][1]][2]+"\n"+"\n"
                  deleteConvol()
        else errorMessage(lex,n)
      else errorMessage(lex,n)
    else errorMessage(lex,n)


  if Convol[0][0] is 3 #Elem of vector
    for word in Literals
      if word[0] is Literals[Convol[0][1]][0] and Literals[Convol[0][1]][5] is "ROWVECTOR" or Literals[Convol[0][1]][5] is "COLVECTOR"
        if Convol[1][0] is 2 and Convol[1][1] is 0 #if "("
          if Convol[2][0] is 4 and Convol[2][1] is '1' or Convol[2][1] is '2'
            if Convol[3][0] is 2 and Convol[3][1] is 2 #if ")"
              if Convol[4][0] is 0 #if end of command
                Output.value += Literals[Convol[0][1]][Convol[2][1]]+"\n"+"\n"
                deleteConvol()
            else errorMessage(lex,n)
          else errorMessage(lex,n)


  if Convol[0][0] is 3 #Elem of matrix
    for word in Literals
      if word[0] is Literals[Convol[0][1]][0] and Literals[Convol[0][1]][5] is "MATRIX"
        if Convol[1][0] is 2 and Convol[1][1] is 0 #if "("
          if Convol[2][0] is 4 and Convol[2][1] is '1' or Convol[2][1] is '2'
            if Convol[3][0] is 2 and Convol[3][1] is 1 #if ","
              if Convol[4][0] is 4 and Convol[4][1] is '1' or Convol[4][1] is '2'
                if Convol[5][0] is 2 and Convol[5][1] is 2 #if ")"
                  if Convol[6][0] is 0 #if end of command
                    if Convol[2][1] is '1' and Convol[4][1] is '1' then Output.value += Literals[Convol[0][1]][1]+"\n"+"\n"
                    if Convol[2][1] is '1' and Convol[4][1] is '2' then Output.value += Literals[Convol[0][1]][2]+"\n"+"\n"
                    if Convol[2][1] is '2' and Convol[4][1] is '1' then Output.value += Literals[Convol[0][1]][3]+"\n"+"\n"
                    if Convol[2][1] is '2' and Convol[4][1] is '2' then Output.value += Literals[Convol[0][1]][4]+"\n"+"\n"
                    deleteConvol()
                else errorMessage(lex,n)
              else errorMessage(lex,n)
            else errorMessage(lex,n)



  #Math operations
  if Convol[0][0] is 3
    for word in Literals
      if word[0] is Literals[Convol[0][1]][0]
        if Literals[Convol[0][1]][5] is "ROWVECTOR" or Literals[Convol[0][1]][5] is "COLVECTOR" or Literals[Convol[0][1]][5] is "MATRIX"
          if Convol[1][0] is 2 and Convol[1][1] is 3 #if "="
           doBrackets()
           doPriority(2,Convol.length-1)
           console.log(turn+ " IS TURN")
           doMath()

#Math func

doMath = () ->
  for word, index in turn
    if Convol[word][1] is 7
      if Literals[Convol[word-1][1]][5] is "ROWVECTOR"
        ConvRes.push(Literals[Convol[word-1][1]])
        ConvRes[ConvRes.length-1][5] = "COLVECTOR"
        Convol[word-1][2] = ConvRes[ConvRes.length-1]
      else if Literals[Convol[word-1][1]][5] is "COLVECTOR"
        ConvRes.push(Literals[Convol[word-1][1]])
        ConvRes[ConvRes.length-1][5] = "ROWVECTOR"
        Convol[word-1][2] = ConvRes[ConvRes.length-1]
      else errorMessage(syn,n)

    if Convol[word][1] is 8
      if Literals[Convol[word-1][1]][5] is "MATRIX"
        ConvRes.push(Literals[Convol[word-1][1]])
        temp_m = ConvRes[ConvRes.length-1][2]
        ConvRes[ConvRes.length-1][2] = ConvRes[ConvRes.length-1][3]
        ConvRes[ConvRes.length-1][3] = temp_m
        Convol[word-1][2] = ConvRes[ConvRes.length-1]
      else errorMessage(syn,n)

    if Convol[word][1] is 6  # "*"
      first_num = ''
      first_type = ''
      second_num = ''
      second_type = ''
      for i in [word-1...1]
        unless Convol[i][2] is off
          if Convol[i][0] isnt 2
            if Convol[i][2] is 'use' and Convol[i][0] is 4
              first_num = i #адрес
              first_type = 'Number'
              break
            else if Convol[i][2] is 'use'
              first_num = i #адрес
              first_type = Literals[Convol[i][1]][5]
              break
            else
              first_num = i #адрес
              first_type = Convol[i][2][5]
              break
      for n in [word+1..Convol.length-2]
        unless Convol[n][2] is off
          if Convol[n][0] isnt 2
            if Convol[n][2] is 'use' and Convol[n][0] is 4
              second_num = n #адрес
              second_type = 'Number'
              break
            else if Convol[n][2] is 'use'
              second_num = n #адрес
              second_type = Literals[Convol[n][1]][5]
              break
            else
              second_num = n #адрес
              second_type = Convol[n][2][5]
              break

      console.log(first_num+" first_num")
      console.log(first_type+" first_type")
      console.log(second_num+" second_num")
      console.log(second_type+" second_type")

      if first_type is "MATRIX" and second_type is "MATRIX"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Literals[Convol[first_num][1]][1]*Literals[Convol[second_num][1]][1]+Literals[Convol[first_num][1]][2]*Literals[Convol[second_num][1]][3]
          ConvRes[ConvRes.length-1][2] = Literals[Convol[first_num][1]][1]*Literals[Convol[second_num][1]][2]+Literals[Convol[first_num][1]][2]*Literals[Convol[second_num][1]][4]
          ConvRes[ConvRes.length-1][3] = Literals[Convol[first_num][1]][3]*Literals[Convol[second_num][1]][1]+Literals[Convol[first_num][1]][4]*Literals[Convol[second_num][1]][3]
          ConvRes[ConvRes.length-1][4] = Literals[Convol[first_num][1]][3]*Literals[Convol[second_num][1]][2]+Literals[Convol[first_num][1]][4]*Literals[Convol[second_num][1]][4]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Literals[Convol[first_num][1]][1]*Convol[second_num][2][1]+Literals[Convol[first_num][1]][2]*Convol[second_num][2][3]
          ConvRes[ConvRes.length-1][2] = Literals[Convol[first_num][1]][1]*Convol[second_num][2][2]+Literals[Convol[first_num][1]][2]*Convol[second_num][2][4]
          ConvRes[ConvRes.length-1][3] = Literals[Convol[first_num][1]][3]*Convol[second_num][2][1]+Literals[Convol[first_num][1]][4]*Convol[second_num][2][3]
          ConvRes[ConvRes.length-1][4] = Literals[Convol[first_num][1]][3]*Convol[second_num][2][2]+Literals[Convol[first_num][1]][4]*Convol[second_num][2][4]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[first_num][2][1]*Literals[Convol[second_num][1]][1]+Convol[first_num][2][2]*Literals[Convol[second_num][1]][3]
          ConvRes[ConvRes.length-1][2] = Convol[first_num][2][1]*Literals[Convol[second_num][1]][2]+Convol[first_num][2][2]*Literals[Convol[second_num][1]][4]
          ConvRes[ConvRes.length-1][3] = Convol[first_num][2][3]*Literals[Convol[second_num][1]][1]+Convol[first_num][2][4]*Literals[Convol[second_num][1]][3]
          ConvRes[ConvRes.length-1][4] = Convol[first_num][2][3]*Literals[Convol[second_num][1]][2]+Convol[first_num][2][4]*Literals[Convol[second_num][1]][4]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[first_num][2][1]*Convol[second_num][2][1]+Convol[first_num][2][2]*Convol[second_num][2][3]
          ConvRes[ConvRes.length-1][2] = Convol[first_num][2][1]*Convol[second_num][2][2]+Convol[first_num][2][2]*Convol[second_num][2][4]
          ConvRes[ConvRes.length-1][3] = Convol[first_num][2][3]*Convol[second_num][2][1]+Convol[first_num][2][4]*Convol[second_num][2][3]
          ConvRes[ConvRes.length-1][4] = Convol[first_num][2][3]*Convol[second_num][2][2]+Convol[first_num][2][4]*Convol[second_num][2][4]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)


      if first_type is "MATRIX" and second_type is "Number"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Literals[Convol[first_num][1]][1]*Convol[second_num][1]
          ConvRes[ConvRes.length-1][2] = Literals[Convol[first_num][1]][2]*Convol[second_num][1]
          ConvRes[ConvRes.length-1][3] = Literals[Convol[first_num][1]][3]*Convol[second_num][1]
          ConvRes[ConvRes.length-1][4] = Literals[Convol[first_num][1]][4]*Convol[second_num][1]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Literals[Convol[first_num][1]][1]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][2] = Literals[Convol[first_num][1]][2]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][3] = Literals[Convol[first_num][1]][3]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][4] = Literals[Convol[first_num][1]][4]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[first_num][2][1]*Convol[second_num][1]
          ConvRes[ConvRes.length-1][2] = Convol[first_num][2][2]*Convol[second_num][1]
          ConvRes[ConvRes.length-1][3] = Convol[first_num][2][3]*Convol[second_num][1]
          ConvRes[ConvRes.length-1][4] = Convol[first_num][2][4]*Convol[second_num][1]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[first_num][2][1]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][2] = Convol[first_num][2][2]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][3] = Convol[first_num][2][3]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][4] = Convol[first_num][2][4]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)

      if first_type is "Number" and second_type is "MATRIX"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Literals[Convol[second_num][1]][1]*Convol[first_num][1]
          ConvRes[ConvRes.length-1][2] = Literals[Convol[second_num][1]][2]*Convol[first_num][1]
          ConvRes[ConvRes.length-1][3] = Literals[Convol[second_num][1]][3]*Convol[first_num][1]
          ConvRes[ConvRes.length-1][4] = Literals[Convol[second_num][1]][4]*Convol[first_num][1]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[second_num][2] = ConvRes[ConvRes.length-1]
          Convol[first_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[second_num][2][1]*Convol[first_num][1]
          ConvRes[ConvRes.length-1][2] = Convol[second_num][2][2]*Convol[first_num][1]
          ConvRes[ConvRes.length-1][3] = Convol[second_num][2][3]*Convol[first_num][1]
          ConvRes[ConvRes.length-1][4] = Convol[second_num][2][4]*Convol[first_num][1]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[second_num][2] = ConvRes[ConvRes.length-1]
          Convol[first_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Literals[Convol[second_num][1]][1]*Convol[first_num][2][1]
          ConvRes[ConvRes.length-1][2] = Literals[Convol[second_num][1]][2]*Convol[first_num][2][1]
          ConvRes[ConvRes.length-1][3] = Literals[Convol[second_num][1]][3]*Convol[first_num][2][1]
          ConvRes[ConvRes.length-1][4] = Literals[Convol[second_num][1]][4]*Convol[first_num][2][1]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[second_num][2] = ConvRes[ConvRes.length-1]
          Convol[first_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[second_num][2][1]*Convol[first_num][2][1]
          ConvRes[ConvRes.length-1][2] = Convol[second_num][2][2]*Convol[first_num][2][1]
          ConvRes[ConvRes.length-1][3] = Convol[second_num][2][3]*Convol[first_num][2][1]
          ConvRes[ConvRes.length-1][4] = Convol[second_num][2][4]*Convol[first_num][2][1]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[second_num][2] = ConvRes[ConvRes.length-1]
          Convol[first_num][2] = off
          console.log(Convol)
          console.log(ConvRes)


      if first_type is "Number" and second_type is "ROWVECTOR" or first_type is "Number" and second_type is "COLVECTOR"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Literals[Convol[second_num][1]][1]*Convol[first_num][1]
          ConvRes[ConvRes.length-1][2] = Literals[Convol[second_num][1]][2]*Convol[first_num][1]
          ConvRes[ConvRes.length-1][5] = Literals[Convol[second_num][1]][5]
          Convol[second_num][2] = ConvRes[ConvRes.length-1]
          Convol[first_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[second_num][2][1]*Convol[first_num][1]
          ConvRes[ConvRes.length-1][2] = Convol[second_num][2][2]*Convol[first_num][1]
          ConvRes[ConvRes.length-1][5] = Convol[second_num][2][5]
          Convol[second_num][2] = ConvRes[ConvRes.length-1]
          Convol[first_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Literals[Convol[second_num][1]][1]*Convol[first_num][2][1]
          ConvRes[ConvRes.length-1][2] = Literals[Convol[second_num][1]][2]*Convol[first_num][2][1]
          ConvRes[ConvRes.length-1][5] = Literals[Convol[second_num][1]][5]
          Convol[second_num][2] = ConvRes[ConvRes.length-1]
          Convol[first_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[second_num][2][1]*Convol[first_num][2][1]
          ConvRes[ConvRes.length-1][2] = Convol[second_num][2][2]*Convol[first_num][2][1]
          ConvRes[ConvRes.length-1][5] = Convol[second_num][2][5]
          Convol[second_num][2] = ConvRes[ConvRes.length-1]
          Convol[first_num][2] = off
          console.log(Convol)
          console.log(ConvRes)

      if first_type is "ROWVECTOR" and second_type is "Number" or first_type is "COLVECTOR" and second_type is "Number"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Literals[Convol[first_num][1]][1]*Convol[second_num][1]
          ConvRes[ConvRes.length-1][2] = Literals[Convol[first_num][1]][2]*Convol[second_num][1]
          ConvRes[ConvRes.length-1][5] = Literals[Convol[first_num][1]][5]
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Literals[Convol[first_num][1]][1]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][2] = Literals[Convol[first_num][1]][2]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][5] = Literals[Convol[first_num][1]][5]
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[first_num][2][1]*Convol[second_num][1]
          ConvRes[ConvRes.length-1][2] = Convol[first_num][2][2]*Convol[second_num][1]
          ConvRes[ConvRes.length-1][5] = Convol[first_num][2][5]
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[first_num][2][1]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][2] = Convol[first_num][2][2]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][5] = Convol[first_num][2][5]
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)


      if first_type is "ROWVECTOR" and second_type is "COLVECTOR"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Literals[Convol[first_num][1]][1]*Literals[Convol[second_num][1]][1]+Literals[Convol[first_num][1]][2]*Literals[Convol[second_num][1]][2]
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Literals[Convol[first_num][1]][1]*Convol[second_num][2][1]+Literals[Convol[first_num][1]][2]*Convol[second_num][2][2]
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[first_num][2][1]*Literals[Convol[second_num][1]][1]+Convol[first_num][2][2]*Literals[Convol[second_num][1]][2]
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[first_num][2][1]*Convol[second_num][2][1]+Convol[first_num][2][2]*Convol[second_num][2][2]
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)


      if first_type is "COLVECTOR" and second_type is "ROWVECTOR"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Literals[Convol[first_num][1]][1]*Literals[Convol[second_num][1]][1]
          ConvRes[ConvRes.length-1][2] = Literals[Convol[first_num][1]][1]*Literals[Convol[second_num][1]][2]
          ConvRes[ConvRes.length-1][3] = Literals[Convol[first_num][1]][2]*Literals[Convol[second_num][1]][1]
          ConvRes[ConvRes.length-1][4] = Literals[Convol[first_num][1]][2]*Literals[Convol[second_num][1]][2]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Literals[Convol[first_num][1]][1]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][2] = Literals[Convol[first_num][1]][1]*Convol[second_num][2][2]
          ConvRes[ConvRes.length-1][3] = Literals[Convol[first_num][1]][2]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][4] = Literals[Convol[first_num][1]][2]*Convol[second_num][2][2]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[first_num][2][1]*Literals[Convol[second_num][1]][1]
          ConvRes[ConvRes.length-1][2] = Convol[first_num][2][1]*Literals[Convol[second_num][1]][2]
          ConvRes[ConvRes.length-1][3] = Convol[first_num][2][2]*Literals[Convol[second_num][1]][1]
          ConvRes[ConvRes.length-1][4] = Convol[first_num][2][2]*Literals[Convol[second_num][1]][2]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[first_num][2][1]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][2] = Convol[first_num][2][1]*Convol[second_num][2][2]
          ConvRes[ConvRes.length-1][3] = Convol[first_num][2][2]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][4] = Convol[first_num][2][2]*Convol[second_num][2][2]
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
      if first_type is "Number" and second_type is "Number"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[first_num][1]*Convol[second_num][1]
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[first_num][1]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[first_num][2][1]*Convol[second_num][1]
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Convol[first_num][2][1]*Convol[second_num][2][1]
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
      if first_type is "MATRIX" and second_type is "ROWVECTOR" or first_type is "MATRIX" and second_type is "COLVECTOR"
        errorMessage(syn,n)
      if first_type is "ROWVECTOR" and second_type is "MATRIX" or first_type is "COLVECTOR" and second_type is "MATRIX"
        errorMessage(syn,n)


    if Convol[word][1] is 4 # "+"
      first_num = ''
      first_type = ''
      second_num = ''
      second_type = ''
      for i in [word-1...1]
        unless Convol[i][2] is off
          if Convol[i][0] isnt 2
            if Convol[i][2] is 'use' and Convol[i][0] is 4
              first_num = i #адрес
              first_type = 'Number'
              break
            else if Convol[i][2] is 'use'
              first_num = i #адрес
              first_type = Literals[Convol[i][1]][5]
              break
            else
              first_num = i #адрес
              first_type = Convol[i][2][5]
              break
      for n in [word+1..Convol.length-2]
        unless Convol[n][2] is off
          if Convol[n][0] isnt 2
            if Convol[n][2] is 'use' and Convol[n][0] is 4
              second_num = n #адрес
              second_type = 'Number'
              break
            else if Convol[n][2] is 'use'
              second_num = n #адрес
              second_type = Literals[Convol[n][1]][5]
              break
            else
              second_num = n #адрес
              second_type = Convol[n][2][5]
              break

      console.log(first_num+" first_num")
      console.log(first_type+" first_type")
      console.log(second_num+" second_num")
      console.log(second_type+" second_type")

      if first_type is "MATRIX" and second_type is "MATRIX"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Literals[Convol[first_num][1]][1])+Number(Literals[Convol[second_num][1]][1])
          ConvRes[ConvRes.length-1][2] = Number(Literals[Convol[first_num][1]][2])+Number(Literals[Convol[second_num][1]][2])
          ConvRes[ConvRes.length-1][3] = Number(Literals[Convol[first_num][1]][3])+Number(Literals[Convol[second_num][1]][3])
          ConvRes[ConvRes.length-1][4] = Number(Literals[Convol[first_num][1]][4])+Number(Literals[Convol[second_num][1]][4])
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Literals[Convol[first_num][1]][1])+Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][2] = Number(Literals[Convol[first_num][1]][2])+Number(Convol[second_num][2][2])
          ConvRes[ConvRes.length-1][3] = Number(Literals[Convol[first_num][1]][3])+Number(Convol[second_num][2][3])
          ConvRes[ConvRes.length-1][4] = Number(Literals[Convol[first_num][1]][4])+Number(Convol[second_num][2][4])
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])+Number(Literals[Convol[second_num][1]][1])
          ConvRes[ConvRes.length-1][2] = Number(Convol[first_num][2][2])+Number(Literals[Convol[second_num][1]][2])
          ConvRes[ConvRes.length-1][3] = Number(Convol[first_num][2][3])+Number(Literals[Convol[second_num][1]][3])
          ConvRes[ConvRes.length-1][4] = Number(Convol[first_num][2][4])+Number(Literals[Convol[second_num][1]][4])
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])+Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][2] = Number(Convol[first_num][2][2])+Number(Convol[second_num][2][2])
          ConvRes[ConvRes.length-1][3] = Number(Convol[first_num][2][3])+Number(Convol[second_num][2][3])
          ConvRes[ConvRes.length-1][4] = Number(Convol[first_num][2][4])+Number(Convol[second_num][2][4])
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)

      if first_type is "ROWVECTOR" and second_type is "ROWVECTOR"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Literals[Convol[first_num][1]][1])+Number(Literals[Convol[second_num][1]][1])
          ConvRes[ConvRes.length-1][2] = Number(Literals[Convol[first_num][1]][2])+Number(Literals[Convol[second_num][1]][2])
          ConvRes[ConvRes.length-1][5] = "ROWVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Literals[Convol[first_num][1]][1])+Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][2] = Number(Literals[Convol[first_num][1]][2])+Number(Convol[second_num][2][2])
          ConvRes[ConvRes.length-1][5] = "ROWVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])+Number(Literals[Convol[second_num][1]][1])
          ConvRes[ConvRes.length-1][2] = Number(Convol[first_num][2][2])+Number(Literals[Convol[second_num][1]][2])
          ConvRes[ConvRes.length-1][5] = "ROWVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])+Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][2] = Number(Convol[first_num][2][2])+Number(Convol[second_num][2][2])
          ConvRes[ConvRes.length-1][5] = "ROWVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)

      if first_type is "COLVECTOR" and second_type is "COLVECTOR"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Literals[Convol[first_num][1]][1])+Number(Literals[Convol[second_num][1]][1])
          ConvRes[ConvRes.length-1][2] = Number(Literals[Convol[first_num][1]][2])+Number(Literals[Convol[second_num][1]][2])
          ConvRes[ConvRes.length-1][5] = "COLVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Literals[Convol[first_num][1]][1])+Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][2] = Number(Literals[Convol[first_num][1]][2])+Number(Convol[second_num][2][2])
          ConvRes[ConvRes.length-1][5] = "COLVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])+Number(Literals[Convol[second_num][1]][1])
          ConvRes[ConvRes.length-1][2] = Number(Convol[first_num][2][2])+Number(Literals[Convol[second_num][1]][2])
          ConvRes[ConvRes.length-1][5] = "COLVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])+Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][2] = Number(Convol[first_num][2][2])+Number(Convol[second_num][2][2])
          ConvRes[ConvRes.length-1][5] = "COLVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)

      if first_type is "Number" and second_type is "Number"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][1])+Number(Convol[second_num][1])
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][1])+Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])+Number(Convol[second_num][1])
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])+Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)

      if first_type is "MATRIX" and second_type is "Number"
        errorMessage(syn,n)
      if first_type is "Number" and second_type is "MATRIX"
        errorMessage(syn,n)
      if first_type is "ROWVECTOR" and second_type is "COLVECTOR"
        errorMessage(syn,n)
      if first_type is "COLVECTOR" and second_type is "ROWVECTOR"
        errorMessage(syn,n)
      if first_type is "MATRIX" and second_type is "COLVECTOR" or first_type is "MATRIX" and second_type is "ROWVECTOR"
        errorMessage(syn,n)
      if first_type is "COLVECTOR" and second_type is "MATRIX" or first_type is "ROWVECTOR" and second_type is "MATRIX"
        errorMessage(syn,n)
      if first_type is "Number" and second_type is "COLVECTOR" or first_type is "Number" and second_type is "ROWVECTOR"
        errorMessage(syn,n)
      if first_type is "COLVECTOR" and second_type is "Number" or first_type is "ROWVECTOR" and second_type is "Number"
        errorMessage(syn,n)


    if Convol[word][1] is 5 # "-"
      first_num = ''
      first_type = ''
      second_num = ''
      second_type = ''
      for i in [word-1...1]
        unless Convol[i][2] is off
          if Convol[i][0] isnt 2
            if Convol[i][2] is 'use' and Convol[i][0] is 4
              first_num = i #адрес
              first_type = 'Number'
              break
            else if Convol[i][2] is 'use'
              first_num = i #адрес
              first_type = Literals[Convol[i][1]][5]
              break
            else
              first_num = i #адрес
              first_type = Convol[i][2][5]
              break
      for n in [word+1..Convol.length-2]
        unless Convol[n][2] is off
          if Convol[n][0] isnt 2
            if Convol[n][2] is 'use' and Convol[n][0] is 4
              second_num = n #адрес
              second_type = 'Number'
              break
            else if Convol[n][2] is 'use'
              second_num = n #адрес
              second_type = Literals[Convol[n][1]][5]
              break
            else
              second_num = n #адрес
              second_type = Convol[n][2][5]
              break

      console.log(first_num+" first_num")
      console.log(first_type+" first_type")
      console.log(second_num+" second_num")
      console.log(second_type+" second_type")

      if first_type is "MATRIX" and second_type is "MATRIX"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Literals[Convol[first_num][1]][1])-Number(Literals[Convol[second_num][1]][1])
          ConvRes[ConvRes.length-1][2] = Number(Literals[Convol[first_num][1]][2])-Number(Literals[Convol[second_num][1]][2])
          ConvRes[ConvRes.length-1][3] = Number(Literals[Convol[first_num][1]][3])-Number(Literals[Convol[second_num][1]][3])
          ConvRes[ConvRes.length-1][4] = Number(Literals[Convol[first_num][1]][4])-Number(Literals[Convol[second_num][1]][4])
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Literals[Convol[first_num][1]][1])-Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][2] = Number(Literals[Convol[first_num][1]][2])-Number(Convol[second_num][2][2])
          ConvRes[ConvRes.length-1][3] = Number(Literals[Convol[first_num][1]][3])-Number(Convol[second_num][2][3])
          ConvRes[ConvRes.length-1][4] = Number(Literals[Convol[first_num][1]][4])-Number(Convol[second_num][2][4])
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])-Number(Literals[Convol[second_num][1]][1])
          ConvRes[ConvRes.length-1][2] = Number(Convol[first_num][2][2])-Number(Literals[Convol[second_num][1]][2])
          ConvRes[ConvRes.length-1][3] = Number(Convol[first_num][2][3])-Number(Literals[Convol[second_num][1]][3])
          ConvRes[ConvRes.length-1][4] = Number(Convol[first_num][2][4])-Number(Literals[Convol[second_num][1]][4])
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])-Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][2] = Number(Convol[first_num][2][2])-Number(Convol[second_num][2][2])
          ConvRes[ConvRes.length-1][3] = Number(Convol[first_num][2][3])-Number(Convol[second_num][2][3])
          ConvRes[ConvRes.length-1][4] = Number(Convol[first_num][2][4])-Number(Convol[second_num][2][4])
          ConvRes[ConvRes.length-1][5] = "MATRIX"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)

      if first_type is "ROWVECTOR" and second_type is "ROWVECTOR"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Literals[Convol[first_num][1]][1])-Number(Literals[Convol[second_num][1]][1])
          ConvRes[ConvRes.length-1][2] = Number(Literals[Convol[first_num][1]][2])-Number(Literals[Convol[second_num][1]][2])
          ConvRes[ConvRes.length-1][5] = "ROWVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Literals[Convol[first_num][1]][1])-Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][2] = Number(Literals[Convol[first_num][1]][2])-Number(Convol[second_num][2][2])
          ConvRes[ConvRes.length-1][5] = "ROWVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])-Number(Literals[Convol[second_num][1]][1])
          ConvRes[ConvRes.length-1][2] = Number(Convol[first_num][2][2])-Number(Literals[Convol[second_num][1]][2])
          ConvRes[ConvRes.length-1][5] = "ROWVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])-Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][2] = Number(Convol[first_num][2][2])-Number(Convol[second_num][2][2])
          ConvRes[ConvRes.length-1][5] = "ROWVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)

      if first_type is "COLVECTOR" and second_type is "COLVECTOR"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Literals[Convol[first_num][1]][1])-Number(Literals[Convol[second_num][1]][1])
          ConvRes[ConvRes.length-1][2] = Number(Literals[Convol[first_num][1]][2])-Number(Literals[Convol[second_num][1]][2])
          ConvRes[ConvRes.length-1][5] = "COLVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Literals[Convol[first_num][1]][1])-Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][2] = Number(Literals[Convol[first_num][1]][2])-Number(Convol[second_num][2][2])
          ConvRes[ConvRes.length-1][5] = "COLVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])-Number(Literals[Convol[second_num][1]][1])
          ConvRes[ConvRes.length-1][2] = Number(Convol[first_num][2][2])-Number(Literals[Convol[second_num][1]][2])
          ConvRes[ConvRes.length-1][5] = "COLVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])-Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][2] = Number(Convol[first_num][2][2])-SNumber(Convol[second_num][2][2])
          ConvRes[ConvRes.length-1][5] = "COLVECTOR"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)

      if first_type is "Number" and second_type is "Number"
        if Convol[first_num][2] is 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][1])-Number(Convol[second_num][1])
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] is 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][1])-Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] is 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])-Number(Convol[second_num][1])
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
        else if Convol[first_num][2] isnt 'use' and Convol[second_num][2] isnt 'use'
          A = []
          ConvRes.push(A)
          ConvRes[ConvRes.length-1][1] = Number(Convol[first_num][2][1])-Number(Convol[second_num][2][1])
          ConvRes[ConvRes.length-1][5] = "Number"
          Convol[first_num][2] = ConvRes[ConvRes.length-1]
          Convol[second_num][2] = off
          console.log(Convol)
          console.log(ConvRes)
      if first_type is "MATRIX" and second_type is "Number"
        errorMessage(syn,n)
      if first_type is "Number" and second_type is "MATRIX"
        errorMessage(syn,n)
      if first_type is "ROWVECTOR" and second_type is "COLVECTOR"
        errorMessage(syn,n)
      if first_type is "COLVECTOR" and second_type is "ROWVECTOR"
        errorMessage(syn,n)
      if first_type is "MATRIX" and second_type is "COLVECTOR" or first_type is "MATRIX" and second_type is "ROWVECTOR"
        errorMessage(syn,n)
      if first_type is "COLVECTOR" and second_type is "MATRIX" or first_type is "ROWVECTOR" and second_type is "MATRIX"
        errorMessage(syn,n)
      if first_type is "Number" and second_type is "COLVECTOR" or first_type is "Number" and second_type is "ROWVECTOR"
        errorMessage(syn,n)
      if first_type is "COLVECTOR" and second_type is "Number" or first_type is "ROWVECTOR" and second_type is "Number"
        errorMessage(syn,n)


  for word, i in Convol
    unless Convol[i][2] is off or Convol[i][2] is 'use' or Convol[i][2] is undefined
      if Literals[Convol[0][1]][5] is "ROWVECTOR"
        if Convol[i][2][5] is "ROWVECTOR"
          Literals[Convol[0][1]][1] = Convol[i][2][1]
          Literals[Convol[0][1]][2] = Convol[i][2][2]
        else errorMessage('type',n)
      if Literals[Convol[0][1]][5] is "COLVECTOR"
        if Convol[i][2][5] is "COLVECTOR"
          Literals[Convol[0][1]][1] = Convol[i][2][1]
          Literals[Convol[0][1]][2] = Convol[i][2][2]
        else errorMessage('type',n)
      if Literals[Convol[0][1]][5] is "MATRIX"
        if Convol[i][2][5] is "MATRIX"
          Literals[Convol[0][1]][1] = Convol[i][2][1]
          Literals[Convol[0][1]][2] = Convol[i][2][2]
          Literals[Convol[0][1]][3] = Convol[i][2][3]
          Literals[Convol[0][1]][4] = Convol[i][2][4]
        else errorMessage('type',n)


  deleteConvol()
  deleteConvRes()
  deleteTurn()


doBrackets = () ->

  for word, index1 in Convol
    if word[0] is 2 and word[1] is 0   # "("
      first_br = index1+1
      index2 = first_br+1
      while index2 < Convol.length
        if Convol[index2][0] is 2 and Convol[index2][1] is 2   # ")"
          second_br = index2-1
          doPriority(first_br,second_br)
          break
        index2++


doPriority = (begin_smb,end_smb)-> #Love you!

  for word1, index1 in Convol[begin_smb..end_smb]
    if Convol[Number(begin_smb+index1)][0] is 2 and Convol[Number(begin_smb+index1)][1] is 7  # "^" TRANSPON
      unless Number(begin_smb+index1) in turn
        turn.push(Number(begin_smb+index1))
    if Convol[Number(begin_smb+index1)][0] is 2 and Convol[Number(begin_smb+index1)][1] is 8  # @
      unless Number(begin_smb+index1) in turn
        turn.push(Number(begin_smb+index1))

  for word2, index2 in Convol[begin_smb..end_smb]
    if Convol[Number(begin_smb+index2)][0] is 2 and Convol[Number(begin_smb+index2)][1] is 6  # "*"
      unless Number(begin_smb+index2) in turn
        turn.push(Number(begin_smb+index2))

  for word3, index3 in Convol[begin_smb..end_smb]
    if Convol[Number(begin_smb+index3)][0] is 2 and Convol[Number(begin_smb+index3)][1] is 4  # "+" TRANSPON
      unless Number(begin_smb+index3) in turn
        turn.push(Number(begin_smb+index3))
    if Convol[Number(begin_smb+index3)][0] is 2 and Convol[Number(begin_smb+index3)][1] is 5  # -
      unless Number(begin_smb+index3) in turn
        turn.push(Number(begin_smb+index3))

#Helpers

deleteConvol = ->
  Convol = []

deleteConvRes = ->
  ConvRes = []

deleteTurn = ->
  turn = []

isKeyword = (str,command) ->
  for word, index in Keywords
    if word is str
      Convol.push([1,index])
      console.log("#{str} is Keyword")
      return on
  return off

isNumber = (str,command) ->
  if "0" <= str <= "9"
    Convol.push([4,str,'use'])
    console.log("#{str} is Number")
    return on
  return off

isSeparator = (str,command) ->
  for word, index in Separators
    if word is str
      Convol.push([2,index])
      console.log("#{str} is Separator")
      return on
  return off

isLiteral = (str,command) ->
  if ("A" <= str <= "Z")
    flag = false
    for word, index in Literals
      if word[0] is str
        Convol.push([3,index,'use'])
        console.log("#{str} is Literal")
        flag = true
    if flag is off
      Literals.push([str,off,off,off,off,off]) #name value1 value2 type
      Convol.push([3,Literals.length-1,'use'])
      console.log("#{str} is Literal")
    return on
  return off


errorMessage = (type_err,num_str) ->

  if type_err is lex
    Output.value += "Lexical error in #{num_str} string!\n\n"
  if type_err is syn
    Output.value += "Syntax error in the last string!\n\n"
  if type_err is 'type'
    Output.value += "Type error in #{num_str} string!\n\n"

