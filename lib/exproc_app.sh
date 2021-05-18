#!/bin/bash
#required
#insatll sysstat -> mpstat
#bc

#list of dependancy package
pkgs=("mpstat" "bc")
file_name="proc_res_$(date '+%s')"
#regex to check if int or not
re='^[0-9]+$'
let end=0
let limit_flag=0

#dependancies checker
for each_pkg in ${pkgs[@]};
do
  if ! command -v ${each_pkg} &> /dev/null
  then
    echo "Package name <<${each_pkg}>> was not found."
    end=1
  fi
done
if [ ${end} -eq 1 ];
then
  echo ""
  echo "Please install the following package and retry the execution."
  exit
fi

#check if the param is int
if ! [[ $1 -eq 0 ]] ; then
    if ! [[ $1 =~ $re ]];
	then
		echo "Invalid Parameter: Accept Integer Only!"
		exit 1
	else
	  	limit_flag=1
	  	let res_limit=$1
	  	echo $res_limit
	fi
fi



#query once only
#get mem total value
let mem_total_mb=$(free -m | awk 'NR==2{print $2}')
#get apu model name
cpu_model_name=$(cat /proc/cpuinfo | grep "model name" | head -1 | awk 'NR==1{print substr($0, index($0,$4))}')
#get 1 cpu value in mhz
cpu_mhz=$(cat /proc/cpuinfo | grep "^[c]pu MHz" | head -1 | awk 'NR==1{print $4}')
#get total core assigned CPU
cpu_core_num=$(nproc)
#find total CPU power Mhz
cpu_total_power=$(echo "scale=2; ${cpu_mhz} * ${cpu_core_num}" | bc)

#print the summary spec
echo "--- Current system total spec --- ${file_name}"
echo "CPU Model: ${cpu_model_name}"
echo "CPUs power: ${cpu_core_num} Core(s) x ${cpu_mhz} Mhz = ${cpu_total_power} Mhz"
echo "Mem total: ${mem_total_mb} MB"
echo "---------------------------------"

#create output file
echo "system info" > ${file_name}
echo "cpu_model, ${cpu_model_name}" >> ${file_name}
echo "cpu_total_core, ${cpu_core_num} Core(s)" >> ${file_name}
echo "cpu_1_core_power, ${cpu_mhz} Mhz" >> ${file_name}
echo "cpu_total_power, ${cpu_total_power} Mhz" >> ${file_name}
echo "mem_total, ${mem_total_mb} MB" >> ${file_name}
echo "system info end" >> ${file_name}
echo "time,cpu(%),ram(%),cpu(Mhz),ram(MB)" >> ${file_name}

let interval=0
while true
do
if ! [[ $limit_flag -eq 0 ]]; 
then
	if [[ $interval -eq $res_limit ]]; 
	then
		echo "*****Comeplete*****"
		exit 1
	else
		((interval=interval+1))
	fi
fi
#find mem used
let mem_used_mb=$(free -m | awk 'NR==2{print $3}')
#fine percentage of mem used
mem_used_percentage=$(echo "scale=2; (${mem_used_mb}*100)/${mem_total_mb}" | bc)

#get cpu idel value
cpu_idle=$(mpstat 1 1 | awk 'NR==4{print $13}')
#find the used percentage
cpu_used_percentage=$(echo "scale=2; 100 - ${cpu_idle}" | bc)
#find used CPU Mhz
cpu_used_mhz=$(echo "scale=2; (${cpu_total_power} * ${cpu_used_percentage})/100" | bc)

current_time=$(date +"%H:%M:%S")
#append value to file
echo "${current_time},${cpu_used_percentage},${mem_used_percentage},${cpu_used_mhz},${mem_used_mb}" >> ${file_name}

#print
echo "--- ${current_time} ---"
echo "CPU Usage: ${cpu_used_percentage} % ${cpu_used_mhz} Mhz"
echo "Mem Usage: ${mem_used_percentage} % ${mem_used_mb} MB"
done