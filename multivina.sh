#!/bin/bash
if [ -z "$1" ]; then
    	echo "Vina_multiple needs multi-ligand file as input"
	exit 1
fi

INPUT=$1
#OUTPUT=$2

echo "Splitting ligands using vina_split"
vina_split --input $1 --ligand ligand &> /dev/null

echo "Docking ligands using vina" 
for i in ligand*.pdbqt; do vina --ligand $i --config conf.txt; done &> /dev/null


#echo $1
#echo $2
