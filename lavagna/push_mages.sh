#!/bin/sh

export HOST=$1
export USER=$2
export LOGIN="docker login -u AWS -p eyJwYXlsb2FkIjoielN2RTBYdjFsS2hHZnNCdmRaVEIzeVhwWXU1bzYyS251cmlRbitoUnI5Y2lJR0s1Y25Fei9QV3cwaFRQK20rKzFwcEx4NnNsQ3pkYnhzOUtqYXFiTlU0Ym9xSXhhaVpzNWRNck92OVg0VFc4YnNwZ1p2RSsyQXVLMEswODJOUlh1ZktwMmx6aU1uc29LZjNkR2U4VjQrNnJTVTBTV2huVU5uUVJmajM2QXI4T0E4ai9OVmZLRW9EVUxkTmczQ1ZscE42S3Y5QjBIWWgzR3BlQ3FYRW40U2hPMXhQYjlBa0l6T2xmL0RneE1ZaFNzM2dEakJzcXc5RFMxNXhQd0M2VFRZNkdqVVZlK2dUUWFETVMvcjFsRWFRZlVBbkZzb0ZFb1B3bzNRWFNaREpuUmJTSXNIR0hCZlNlMkg1U2szNDhNdFdaeHZsTjJiR1BGd2V0YXVVK1crWk9IUkhaR1FLbGMyV1B5Rk5JMlYxYWJ5Uk9DdW52c0c0MS9pNlk2cXdkOXRublpuWTcyWnQ0QXhxeXpobVpsUmNxN2poRG5nUnRLcU1uSWtFTCtvTDZNekZtc3ArSmRSY2FrV3VuU01LQ3plNmIwcnJyOHJKcU9EOXhEc2lscE94YkpCY0tXdk56Ti8ydlNTcDZxM3M4Yy8vMWk1ZnhzNDdSdGtuSTkvYVZtaWMyVm5jRUxDUi9kUkZZZXBJV1FQL3JGYVJnN2ErazllMFloeW83NEZHWEhPMm9oMWNpSTVaRkF5NnZNeVIvSkNDN3Z6VFp3a1FqK29qVFFkbVFqMkJERXY5Q0psK1lLbEREWEt1Qms1b0N1V0NZK0JEelZVaUtWWk8vTkNudlJQMGs5cDlyVWd1THpzUXpLTUE1bzJjdFhySGY2ODJOQlJDKzVHelhab2J4Tk5rREVjNCtGa2thdVE2NmlIUkxucnZ1dkpueDh5YUdJY1FneW54Z3N6U003dlRhdDNLY1J2U1BLUXZqdkpTRldxcGl4aWhHMEVGc1ppRFlJQkEyRUFBL0pValpqVGxuQnlRajdRUW1oYVZ3QTlWbncxUjI5TnhKcU9IU2JuSmdWZWZZRU45RE10WjNNMUdvTWVRYloyOGJHVXY3ZEVNVzBhZ0ErUzg4STl5cGh6WUFPMlZBTHcrZ0Y4dG1rOTcxRzg0aS9sUG1SRGNvdFZKOFpPMkNQZnNXS2VLMGs5ZkdUaXlJbUJYc0Z0MnZoUE1hS3VqRVU1NTh5cENPanFRZ1hkOVJGNS9PN0l2dThqNU9HN3ZsV1JSV1NKcEV1aXRLeXVsMTNBYUN2NSt4TDlINVhaSTdvYmc2T1hYNFlpS09ZMlhjaUhPcnZRVnhJTlNuSTdmTUpZU056aCs5cXpuOXZWdUU5azRNbG9PNEVqZEd1NlJCR3NFMjR3aktsQVVkZXNIZ0hrb3VKMmRQTFRsY3duR1J2Ym5oSjJHRzlSckpBTWR2VTNEZXUzRT0iLCJkYXRha2V5IjoiQVFFQkFIaDN6WU9kdHBCQlNWdy9ZMmFuOEJYSUQ0a3dMUWZub1RqNXp3WnRHSlpvWlFBQUFINHdmQVlKS29aSWh2Y05BUWNHb0c4d2JRSUJBREJvQmdrcWhraUc5dzBCQndFd0hnWUpZSVpJQVdVREJBRXVNQkVFRE0za1FXcVZaWXliSFpVRWpnSUJFSUE3UCtrVmJuQWxRQ0ZVTjhwbTh0NjFJQTY1cmNhOHdBSlVpN2Fscmt4VStWVnpOYzFzdCtNUVlLcVFYNE54enlCaU1UVXJoTC9xdFlDUUIvOD0iLCJ2ZXJzaW9uIjoiMiIsInR5cGUiOiJEQVRBX0tFWSIsImV4cGlyYXRpb24iOjE2MTkwNjA5MjN9 822423649500.dkr.ecr.eu-central-1.amazonaws.com/container"
APP="lavagna"
SERVER="proxy"

if [ ! -z $# ]
then
    eval $LOGIN
    if [ ! -f version.lck ]
    then
        VERSION=1
        echo $VERSION > version.lck
    fi
    VERSION=`cat version.lck`
    VERSION=$((VERSION+1))
    echo $VERSION > version.lck
    cd project
    docker build -t "${APP}_${VERSION}" .
    docker tag "${APP}_${VERSION}":latest 822423649500.dkr.ecr.eu-central-1.amazonaws.com/containers:"${APP}_${VERSION}"
    cd ..
    cd reverse_proxy/
    echo "docker build -t "${SERVER}_${VERSION}" ."
    docker build -t "${SERVER}_${VERSION}" .
    docker tag "${SERVER}_${VERSION}":latest 822423649500.dkr.ecr.eu-central-1.amazonaws.com/containers:${SERVER}_${VERSION}
    docker push 822423649500.dkr.ecr.eu-central-1.amazonaws.com/containers:${APP}_${VERSION}
    docker push 822423649500.dkr.ecr.eu-central-1.amazonaws.com/containers:${SERVER}_${VERSION}
    cd ..
    echo "AWSAPP=822423649500.dkr.ecr.eu-central-1.amazonaws.com/containers:${APP}_${VERSION}" > .env
    echo "AWSPROXY=822423649500.dkr.ecr.eu-central-1.amazonaws.com/containers:${SERVER}_${VERSION}" >> .env
fi


mkdir -p pack
cp -rp docker-compose.yaml .env version.lck DB pack/

tar -zcf pack.tar.gz pack

scp -i ~/.ssh/fadi-key.pem -Crp pack.tar.gz $USER@$HOST:~/


ssh -i ~/.ssh/fadi-key.pem -q $USER@$HOST "sh -s" < inflate.sh 



