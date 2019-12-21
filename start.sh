#!/bin/bash
(sleep 5 && service php7.2-fpm start) &
nginx -g 'daemon off;'