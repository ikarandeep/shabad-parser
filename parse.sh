#/bin/sh
# written by Karandeep
# used for the Asa Ki Vaar iPad App
# export data from Google Docs into CSV
# data should be in the following order:
# "Ang" "Shabad Search Line" "Notes" "Index Name" "Unicode"

input="shabads.csv"
output="sample.xml"
export IFS=","

regex='[0-9]'

i=0
cat "$input" | while read part1 part2 part3 part4 part5;
do
	if [ $i -ne 0 ]; then
		# if part 1 is a number, we have the first line...
		if [[ "$part1" =~ $regex ]]; then
			# if is 1 then we should skip
			if [ $i -ne 1 ]; then
				echo "</shabad>" >> $output 
			fi
			echo "<shabad title=$part5\" type=\"extraShabad\" shabadName=\"$part4\">" >> $output
		else
			string=`echo $part1 | sed 's/["]//g'`
			echo $string >> $output
		fi
	fi
	i=`expr $i + 1`
done
echo "</shabad>" >> $output 
 