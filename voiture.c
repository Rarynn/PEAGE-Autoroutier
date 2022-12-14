#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <string.h>
#include "voiture.h"

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wincompatible-pointer-types" //pour les warnings de conversion de int en pointeur

char alphabet[]="AZERTYUIOPQSDFGHJKLMWXCVBN";


vehicule creer_vehicule(int classe){
	if(classe<1 || classe>5){
		printf("Erreur de classe");
		exit(-1);
	}
	vehicule v;
	v.taxi=false;
	v.critair=rand()%2;
	v.classe=classe;
	switch (classe){
		case 1://véhicule léger
			v.siege=4;
			v.taxi=rand()%2;
			break;
		case 2://véhicule intermédiaire
			v.siege=7;
			v.taxi=rand()%2;
			break;
		case 3://poids lourds, autocars et autres véhicules à 2 essieux
			v.siege=10;
			
			break;
		case 4://poids lourds et autres véhicules à 3 essieux et plus
			v.siege=15;
			break;
		case 5://motos, sidecars et trikes
			v.siege=2;
			break;
	}

	
	creer_immatriculation(&v.immatriculation);

	v.passager=rand()%v.siege; // Génération aléatoire du nombre de passagers

	int telepeage=rand()%10; // Génération aléatoire du télépéage
	if (telepeage<4){
		v.telepeage=true;
	}
	else{
		v.telepeage=false;
	}
	
	return v;
}
void afficher_vehicule(vehicule v){
	printf("Nombre de passagers : %d\n",v.passager);
	printf("Nombre de sièges : %d\n",v.siege);
	printf("Classe : %d\n",v.classe);	
	printf("Télépéage : %d\n",(int)v.telepeage);
	printf("Immatriculation : %s\n\n",v.immatriculation);
	printf("Critair : %d\n",v.critair);
	printf("Taxi : %d\n",v.taxi);
}

void creer_immatriculation(char * matricule){

	strcpy(matricule,"");

	char c = 'A';
	char str1[2] = {c , '\0'};

	
	for(int i=0;i<9;i++){
		
		if(!(i==2 || i==6)){
			str1[0]=alphabet[rand()%9];
			strcat(matricule,str1);
		}else{
			strcat(matricule,"-");
		}
		

	}

	
}
#pragma GCC diagnostic pop