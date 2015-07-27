# -*- coding:utf-8 -*-
import multiprocessing

## Server Socket
bind = "127.0.0.1:8000"
backlog = 2048

## Worker Processes
workers = multiprocessing.cpu_count() * 2 + 1
worker_class = "egg:gunicorn#tornado"
worker_connections = 512 * workers

max_requests = 4096

timeout = 10
keepalive = 1

## Security
#limit_request_line = 4096
#limit_request_fields = 100
#limit_request_field_size = 8096

## Debugging


## Server Mechanics


## Logging
accesslog = 'logs/access_log'
access_log_format = '%(h)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s'
errorlog = 'logs/error_log'

## Server Hooks

