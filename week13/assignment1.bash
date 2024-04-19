#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas
function displayCoursesofRoom(){
echo -n "Please Input the room you wish to search: "
read roomName

echo ""
echo "Courses of $roomName :"
cat "$courseFile" | grep "$roomName" | cut -d';' -f1,2,5,6,7 | \
sed 's/;/ | /g'
echo ""

}


# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas
function displayCoursesofSubject(){
echo -n "Please input a subject name: "
read subjName

echo ""
echo "Availible courses in $subjName :"
local classesofSubj=$(cat "$courseFile" | grep "$subjName")
:> newtemp.txt
echo "$classesofSubj" | while read -r line;
do
	local number=$(echo "$line" | cut -d ";" -f1)
	local title=$(echo "$line" | cut -d ";" -f2)
	local credit=$(echo "$line" | cut -d ";" -f3)
	local seats=$(echo "$line" | cut -d ";" -f4)
	local day=$(echo "$line" | cut -d ";" -f5)
	local times=$(echo "$line" | cut -d ";" -f6)
	local instructor=$(echo "$line" | cut -d ";" -f7)
	local dates=$(echo "$line" | cut -d ";" -f8)
	local prereqs=$(echo "$line" | cut -d ";" -f9)
	local location=$(echo "$line" | cut -d ";" -f10)
	if [[ "${seats}" -ge "1" ]];
	then
		echo "$number | $title | $credit | $seats | $day | $times | $instructor | $dates | $prereqs | $location" >> newtemp.txt
	fi
done
cat "newtemp.txt"
echo ""
}

while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses of a classroom"
	echo "[4] Display courses of subject"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

	elif [[ "$userInput" == "3" ]]; then
		displayCoursesofRoom

	elif [[ "$userInput" == "4" ]]; then
		displayCoursesofSubject
	# TODO - 3 Display a message, if an invalid input is given
	else
		echo "Please enter a valid input from 1-5"
		echo ""

	fi
done
