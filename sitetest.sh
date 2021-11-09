:
ip=$1
actions=(read download scooby)
for theaction in ${actions[@]}; do
echo "|$theaction|"
curl -s -o /dev/null -w "$ip $theaction %{http_code}\n" http://$ip/manage_file \
   -H 'Content-Type: application/json' \
   -d "{\"action\":  \"$theaction\"}"
done
