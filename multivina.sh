#!/bin/bash
#if [ -z "$1" ]; then
#    	echo "Vina_multiple needs multi-ligand file as input"
#	exit 1
#fi

while read line
do
  echo "$line" &> /dev/null
done < /dev/stdin
 
#echo "Converting sdf conformer file to pdbqt"
obabel -i sdf $line -o pdbqt -O conformers.pdbqt &> /dev/null 
    
#echo "Splitting ligands using vina_split"
vina_split --input conformers.pdbqt --ligand ligand &> /dev/null

#echo "Docking ligands using vina" 
for i in ligand*.pdbqt; do vina --ligand $i --config conf.txt; done &> /dev/null

#echo "Making single pdbqt file"
for i in ligand*_out.pdbqt; do cat $i; done > single.pdbqt 

#echo "Converting single pdbqt file to sdf file using openbabel"
obabel -i pdbqt single.pdbqt -o sdf -O single.sdf &> /dev/null

cat single.sdf
rm ligand* single*
rm conformers.pdbqt
