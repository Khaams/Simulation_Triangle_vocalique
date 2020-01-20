include Form_menu.praat

enonces$ = "'axes$'"

clearinfo

	sol = length (enonces$)
	find=index (enonces$, " ")
horizontal_max$ = left$(enonces$, find)
	enonces$ = extractLine$ (enonces$, " ")
	sol = length (enonces$)
	find=index (enonces$, " ")
horizontal_min$ = left$(enonces$, find)
	enonces$ = extractLine$ (enonces$, " ")
	sol = length (enonces$)
	find=index (enonces$, " ")
vertical_max$ = left$(enonces$, find)
	enonces$ = extractLine$ (enonces$, " ")
	sol = length (enonces$)
	find=index (enonces$, " ")

Axes... -'horizontal_min$' -'horizontal_max$' -'enonces$' -'vertical_max$'

clearinfo

path$ = "'dossier$'"
file_name$="'regexp$'"

string = Create Strings as file list... liste 'path$'\'file_name$'

file$ = path$ + "\" + file_name$

printline 'file$'

tar = Read TableOfReal from headerless spreadsheet file... 'file$'

select tar

Split into Pattern and Categories... 0 0 0 0
pattern = selected ("Pattern")
categorie = selected ("Categories")

select 'categorie'
To unique Categories
To Strings

string2 = selected ("Strings")
taille = Get number of strings

for j from 1 to taille

	select 'string2'
	phoneme$ =Get string... 'j'

	select 'tar'
	Extract rows where label... "is equal to" 'phoneme$'
	table_temp = selected ("TableOfReal")
	nombre = Get number of rows

	if (nombre>1)
		select 'table_temp'
			f1_mean = Get column mean (index)... 1
			f1_mean = -f1_mean
			f1_mean = round(f1_mean)
			f2_mean = Get column mean (index)... 2
			f2_mean = -f2_mean
			f2_mean = round(f2_mean)
	else
			f1_mean = Get column mean (index)... 1
			f1_mean = -f1_mean
			f1_mean = round(f1_mean)
			f2_mean = Get column mean (index)... 2
			f2_mean = -f2_mean
			f2_mean = round(f2_mean)
	endif

	# uniquement pour une impression sans les signes '-'
	form_f1_mean = -f1_mean
	form_f2_mean = -f2_mean
	
	printline phoneme 'tab$' 'phoneme$' 'tab$' f1_mean 'tab$' 'form_f1_mean' f2_mean 'tab$' 'form_f2_mean'

	Text... 'f2_mean' Centre 'f1_mean' Half 'phoneme$'

endfor

Draw inner box

horizontal_max = floor('horizontal_max$'/200)
horizontal_min = ceiling('horizontal_min$'/200)
vertical_max = floor('vertical_max$'/100)
vertical_min = ceiling('enonces$'/100)

for i from 'horizontal_max' to 'horizontal_min'
	f2 = i * 200
	One mark top... -f2 no yes yes 'f2'
endfor


for i from 'vertical_max' to 'vertical_min'
	f1 = i * 100
	One mark right... -f1 no yes yes 'f1'
endfor

Text left... yes %F_1 (Hz)
Text bottom... yes %F_2 (Hz)