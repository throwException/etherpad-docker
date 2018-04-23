#!/bin/bash

su -c 'createuser --username=postgres --no-superuser --pwprompt etherpad' postgres
su -c 'createdb --username=postgres --owner=etherpad --encoding=UTF8 etherpad' postgres

