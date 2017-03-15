#!/bin/bash
while $(true);
do
	for i in $(ls *.fig);
	do
		cp $i $i.bk
	done
	sleep 5;
done
