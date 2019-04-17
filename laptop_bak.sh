#!/bin/bash

/usr/bin/rsync -avhe ssh --delete /home/bswilson/docs/ bswilson@doctordre:/home/laptop/docs/
/usr/bin/rsync -avhe ssh --delete /home/bswilson/bin/ bswilson@doctordre:/home/laptop/bin/
/usr/bin/rsync -avhe ssh --delete /home/bswilson/backup/ bswilson@doctordre:/home/laptop/backup/
/usr/bin/rsync -avhe ssh --delete /home/bswilson/download/ bswilson@doctordre:/home/laptop/download/
