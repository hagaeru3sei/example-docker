#!/usr/bin/env bash

GUNICORN=gunicorn
TORNADO_HOME=/opt/app
PORT=$2
if [ ! $PORT ];
then
    PORT=8000;
fi
#WORKER_CLASS="egg:gunicorn#tornado"
WORKER_CLASS="tornado"
BIND_ADDRESS=0.0.0.0:$PORT
LOCKFILE=/tmp/gunicorn.pid.$PORT
CONFIGFILE=$TORNADO_HOME/conf/gunicorn.conf.py
APP=main:application
APP_NAME=app

set -e

start ()
{
    cd $TORNADO_HOME
    [ -e $LOCKFILE ] && echo "lockfile exists!" && exit -1

    echo -n $"Starting $APP_NAME: "

    # startup tornado
    echo "$GUNICORN -k $WORKER_CLASS -c $CONFIGFILE -b $BIND_ADDRESS --pid=$LOCKFILE $APP -D"
    nohup $GUNICORN -k $WORKER_CLASS -c $CONFIGFILE -b $BIND_ADDRESS --pid=$LOCKFILE $APP
    RETVAL=$?

    cat $TORNADO_HOME/nohup.out
    cat $TORNADO_HOME/logs/error_log

    [ $RETVAL -eq 0 ] && echo -en "\t\t\t[\\033[1;32m OK \\033[0;37m]"
    sleep 1

    echo
    return $RETVAL
}

stop ()
{
    echo -n $"Stopping $PROG_NAME: "
    PID=$(cat $LOCKFILE)
    kill $PID
    RETVAL=$?

    [ $RETVAL -eq 0 ] && echo -en "\t\t\t[\\033[1;32m OK \\033[0;37m]"
    sleep 1

    echo
    [ $RETVAL -eq 0 ] && rm -rf $LOCKFILE
    return $RETVAL
}

restart ()
{
    stop 
    start
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    test)
        test
        ;;
    *)
    echo "Usage: gunicorn.sh {start|stop|restart} {port}" ;;
esac

exit $?
