#!/bin/sh


_DOCKER=`which docker-compose`

$_DOCKER down
$_DOCKER up -d --build
