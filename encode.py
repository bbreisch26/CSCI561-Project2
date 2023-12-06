s = 'movedisk_'
pegs = ['disk1','disk2','peg1','peg2','peg3']
allMoves = []
allEncodes = []
fileMoves = open('allMoves.txt','w')
fileEncodes = open('allEncodes.txt','w')
fileExcludes = open('allExcludes.txt','w')
for x in range(0,3):
    for i in pegs:
        for j in pegs:
            for k in pegs:
                if 'peg' in i or j == k or i == j or i == k:
                    continue
                newStr = f'{s}{i}_{j}_{k}-{x+1}'
                encode = f'(:implies {newStr} (and clear_{i}-{x+1} smaller_{i}_{k}-{x+1} on_{i}_{j}-{x+1} clear_{k}-{x+1} on_{i}_{k}-{x+2} clear_{j}-{x+2} (not on_{i}_{j}-{x+2}) (not clear_{k}-{x+2})))'
                allMoves.append(newStr)
                fileMoves.write(newStr+'\n')
                fileEncodes.write(encode+'\n')

for i in range(len(allMoves)):
    newStr = '(:implies ' + allMoves[i] + ' (and '
    for j in range(len(allMoves)):
        if allMoves[i] != allMoves[j] and allMoves[j].endswith(allMoves[i][-1]):
            newStr = newStr + ' (not ' + allMoves[j] + ')'
    newStr = newStr +'))'
    fileExcludes.write(newStr+'\n')

fileMoves.close()
fileEncodes.close()
fileExcludes.close()

fileBegin = open('allBegin.txt','w')
predicates = ['clear','on','smaller']
true = ['clear_peg3-0','clear_peg2-0','clear_disk1-0','smaller_disk2_peg1-0','smaller_disk2_peg2-0','smaller_disk2_peg3-0','smaller_disk1_disk2-0','smaller_disk1_peg1-0','smaller_disk1_peg2-0','smaller_disk1_peg3-0','on_disk1_disk2-0','on_disk2_peg1-0']
for i in predicates:
    if i == 'clear': #unary
        for j in pegs:
            startStr = f'{i}_{j}-0'
            if startStr not in true:
                writeStr = f'(not {i}_{j}-0)'
                fileBegin.write(writeStr+'\n')
            else:
                fileBegin.write(startStr+'\n')
    else:
        for j in pegs:
            for k in pegs:
                startStr = f'{i}_{j}_{k}-0'
                if startStr not in true:
                    writeStr = f'(not {i}_{j}_{k}-0)'
                    fileBegin.write(writeStr+'\n')
                else:
                    fileBegin.write(startStr+'\n')
fileBegin.close()

fileFrames = open('allFrames.txt','w')
predicates = ['clear','on','smaller']
moves = 'movedisk'
for t in range(0,4):
    for i in predicates:
        if i == 'clear': #unary
            for j in pegs:
                strCompare = f'clear_{j}-{t}'
                frameStr = f'(or (:iff clear_{j}-{t} clear_{j}-{t+1})' # (:iff clear_disk1-0 clear-disk1-1) or movedisk_disk1_peg?_disk?-0 or
                for movedisk in allMoves:
                    operands = movedisk.split("_")
                    if movedisk.endswith(strCompare[-1]) and ((operands[2] == j) or (j in operands[3])):
                        frameStr = frameStr + f' {movedisk}'
                        
                frameStr = frameStr +')'
                fileFrames.write(frameStr+'\n')
        elif i == 'smaller':
            for j in pegs:
                for k in pegs:
                    frameStr = f'(or (:iff smaller_{j}_{k}-{t} smaller_{j}_{k}-{t+1}))' # smaller never changes throughout simulation
                    fileFrames.write(frameStr+'\n')
        elif i == 'on':
            for j in pegs:
                for k in pegs:
                    strCompare = f'on_{j}_{k}-{t}'
                    frameStr = f'(or (:iff on_{j}_{k}-{t} on_{j}_{k}-{t+1})' # (:iff clear_disk1-0 clear-disk1-1) or movedisk_disk1_peg?_disk?-0 or
                    #movedisk_disk1_peg3_disk2-3
                    if 'peg' in j or j == k:
                        continue
                    for movedisk in allMoves:
                        operands = movedisk.split("_")
                        if (movedisk[9:9+len(j)] == j) and movedisk.endswith(strCompare[-1]) and ((operands[2] == k) or k in operands[3]):
                            frameStr = frameStr + f' {movedisk}'
                            
                    frameStr = frameStr +')'
                    fileFrames.write(frameStr+'\n')
fileFrames.close()
