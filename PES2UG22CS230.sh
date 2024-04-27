# error code
# 201 - wrong username
# 202 - wrong password
# 203 - dirName has no username or srn

# update the variables
usernamed="12345"
progName="PES2UG22CS230.sh"
srn="PES2UG22CS230"

function log_debug ()
{
	echo "LOG: $1"
}

function check_user_creds()
{
	log_debug "check_user_creds:args: username=[$1] password=[$2] srn=[$3]"
	# validate username
	if [ $1 != $srn ]
	then
		echo "Username is wrong. Going to exit the application"
		exit 201 ; 
	fi

	#validate password
	realPassword=`echo $srn | rev`
	log_debug "check_user_creds:realPassword:$realPassword"
	if [ $2 != $realPassword ]
	then
		echo "Password is wrong. Going to exit the application"
		exit 202 ; 
	fi	
}

function is_even_number()
{
	#log_debug "is_even_number:args:$1:"
	if [ `expr $1 % 2` == 0 ]
	then
		return 1 ; 
	else
		return 0 ; 
	fi
}

function check_dir()
{
	log_debug "check_dir:args:$1:: username:$usernamed,srn:$srn:"
	#check username
	if [[ $1 == *"$usernamed"* ]]
	then
  		log_debug "check_dir:username matched!"
	elif [[ $1 == *"$srn"* ]]
	then
  		log_debug "check_dir:srn matched!"
	else
		echo "No matching username or SRN in dirname. Going to exit the application"
		exit 203
	fi
}

nArgs=$#
log_debug "main:nArgs=[$nArgs]"
if [ $nArgs != 3 ]
then
	echo "Invalid number of arguments"
	echo "Usage: $progName [username] [password] [folder name]"
	exit
fi
username=$1
password=$2
dirName=$3

# check user credentials
check_user_creds $username $password $srn

# check dirName
check_dir $dirName

# create output extension
last3char=${srn: -3}
#log_debug "last3char:[last3char]"
char1=${last3char:0:1}
char2=${last3char:1:1}
char3=${last3char:2:2}
log_debug "char1=[$char1] char2=[$char2] char3=[$char3]"
ext=""
is_even_number $char1
ret=$?
if [ $ret == 1 ]
then
	ext=$ext"P"
else
	ext=$ext"p"
fi
is_even_number $char2
ret=$?
if [ $ret == 1 ]
then
	ext=$ext"N"
else
	ext=$ext"n"
fi
is_even_number $char3
ret=$?
if [ $ret == 1 ]
then
	ext=$ext"G"
else
	ext=$ext"g"
fi
log_debug "finalext:$ext:"

# get the list of files
cd $dirName
for entry in *
do
	#log_debug "filename: $entry"
	# check if file extenstion is png is small/large char
	file=${entry: +3}
	ext1=${entry: -3}
	ext2=`echo $ext1 | tr '[A-Z]' '[a-z]'`
	#log_debug "file ext:$ext1:$ext2:"
	if [ $ext2 == "png" ]
	then
		# rename the file
		file=`basename $entry "."$ext1`
		destfile=$file"."$ext
		log_debug "renaming [$file] to [$destfile]"
		# mv $entry $destfile
		cp $entry $destfile".final"
	fi
done




