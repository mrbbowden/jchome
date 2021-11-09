:
if [ -z ${1+x} ];
then
 echo "usage: sitetest.sh ipaddress"
 exit
fi
ip=$1
correctcount=0
actions=(read download scooby)
for theaction in ${actions[@]}; do
#curl -s -o /dev/null -w "$ip $theaction %{http_code}\n" http://$ip/manage_file \
curl_status=$(curl -s -o /dev/null -H  'Content-Type: application/json' -d "{\"action\":  \"$theaction\"}" -w '%{http_code}' --connect-timeout 3 http://$ip/manage_file)
echo "$ip $theaction $curl_status"
if [ $theaction  ==  "scooby" -a $curl_status -eq 500 ]
then
 ((correctcount=correctcount+1))
elif [ $theaction != "scooby" -a $curl_status -eq 200 ]
then
 ((correctcount=correctcount+1))
fi
done
if [ $correctcount -eq 3 ]
then
 echo "correctcount is $correctcount tests pass"
else
 echo "correctcount is $correctcount tests fail"
fi
 $theaction $curl_status"
done
