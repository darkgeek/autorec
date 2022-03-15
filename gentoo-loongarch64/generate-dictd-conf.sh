#!/bin/bash
# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

DICTDCONF=/etc/dict/dictd.conf
DLIBDIR=/usr/share/dict

prepconfig() {
	local TMPCONF INDEXFILES CNT DNAME DICT SAVEDIR
	if [ ! -e "${DICTDCONF}" ]; then
		echo "Config file ${DICTDCONF} not found."
		return 1
	fi

	# if no dictionaries, skip startup.
	# The new way of doing this is to scan /usr/share/dict and tweek the conf
	echo "Scanning for dictionaries..."
	if [ ! -d "${DLIBDIR}" ]; then
		echo "${DLIBDIR} doesn't exist, no dictionaries found."
		return 1
	fi

	SAVEDIR=${PWD}
	cd "${DLIBDIR}"
	INDEXFILES=$(ls *.index)
	if [ -z "${INDEXFILES}" ]; then
		echo "No dictionaries found at ${DLIBDIR}."
		echo "Please, emerge at least one of app-dicts/dictd-* dictionaries."
		return 1
	fi

	TMPCONF=$(mktemp -t dictd.conf.XXXXXXXXXX)
	cat ${DICTDCONF} | sed -e '/^#LASTLINE/,$d' > ${TMPCONF}
	echo "#LASTLINE" >> ${TMPCONF}

	CNT=0
	for i in ${INDEXFILES}; do
		DNAME=$(echo $i | sed -e 's/[.]index$//')
		#two possible names for a matching dictionary, check which is there.
		if [ -f ${DNAME}.dict.dz ]; then
			DICT=${DNAME}.dict.dz
		elif [ -f ${DNAME}.dict ];then
			DICT=${DNAME}.dict
		else
			echo "Index $i has no matching dictionaray..."
		fi

		#ok, go an index, and a dixtionary, append.
		echo "database ${DNAME} { data \"${DLIBDIR}/${DICT}\"" >> ${TMPCONF}
		echo "         index \"${DLIBDIR}/$i\" }" >> ${TMPCONF}

		CNT=$(expr ${CNT} + 1)
	done

	cd "${SAVEDIR}"
	mv "${TMPCONF}" "${DICTDCONF}"
	chown 0:dictd "${DICTDCONF}"
	chmod g+r "${DICTDCONF}"
	echo "Done, ${CNT} dictionaries found."
}

prepconfig
