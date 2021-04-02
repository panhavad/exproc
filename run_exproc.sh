#required
#insatll sysstat -> mpstat
#bc

#create output file
echo "time,cpu%,ram%" > proc_res
while sleep 1
do
#get mem total value
let mem_total=$(free | awk 'NR==2{print $2}')
#find mem used
let mem_used_kb=$(free | awk 'NR==2{print $3}')
#fine percentage of mem used
mem_used_percentage=$(echo "scale=2; (${mem_used_kb}*100)/${mem_total}" | bc)
#get cpu idel value
cpu_idle=$(mpstat 1 1 | awk 'NR==4{print $13}')
#find the used percentage
cpu_used=$(bc <<< "100 - ${cpu_idle}")

#append value to file
echo "$(date +"%H:%M:%S"),${cpu_used},${mem_used_percentage}" >> proc_res

#print
echo "--- $(date +"%H:%M:%S") ---"
echo "CPU Usage: ${cpu_used} %"
echo "Mem Usage: ${mem_used_percentage} %"
done

#file structure#
#time,cpu%,ram%
#value,value,value
#value,value,value
#value,value,value
#value,value,value