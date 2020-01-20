from os.path import join
from praatio import tgio
import parselmouth


#Permet de lire les fichier TextGrid
inputFile = "projet_2.TextGrid"
tg = tgio.openTextgrid(inputFile)
print(tg.tierNameList)

#Permet de trouver les formants dans le fichier wav
sound = parselmouth.Sound("projet_2.wav")
formant = sound.to_formant_burg(max_number_of_formants=5, maximum_formant=5500)
print(formant.get_value_at_time(1, 0.5))



#get the segmentations
for e in tg.tierNameList:
    first = tg.tierDict[tg.tierNameList[0]] 
    second = tg.tierDict[tg.tierNameList[1]]


durationList = []

#get times 
for start, stop, _ in first.entryList:
    durationList.append(stop - start)

#creat a file to save the results
resultat_formant = open("resultat_formants_projet_2.txt", "w")
resultat_formant.write("segment f1 f2\n")
vowel_list= []

#Get formants using start time and end time in TextGrid
for start, stop, label in first.entryList:
    midpoint = (float(start)+float(stop)) /2
    formant_1 = formant.get_value_at_time(1, midpoint)
    formant_2 = formant.get_value_at_time(2, midpoint)
    values = '{0} {1} {2}'.format(label,formant_1, formant_2) 
    #We focus only on the vowels
    if label in ('i', 'y', 'u', 'j', 'w', 'o', '2','a~', 'a', "O", 'U~', 'e', 'E','@', 'O~'):
        vowel_list.append(values)

for e in sorted(vowel_list):
    resultat_formant.write(e+'\n')
    
resultat_formant.close()

print("Build SUCESS")