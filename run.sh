if ping -c 1 10.123.123.123 &> /dev/null
then
  echo "10.123.123.123 exists"
else
sudo ifconfig lo0 alias 10.123.123.123
fi

rm -rf ./workspace/prj_internmatch
git clone https://github.com/OutcomeLife/prj_internmatch ./workspace/prj_internmatch

docker-compose up

cd ./workspace/genny-main && ./run.sh internmatch up