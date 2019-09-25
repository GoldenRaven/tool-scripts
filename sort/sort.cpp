#include<iostream>
#include<iomanip>
#include<fstream>
#include<cstdlib>
#include<math.h>
using namespace std;

void sort(int raw_num, int column_num, int column, double ** data,char X)
{
	if (X=='A'){
		cout << "#sorting in ascending order!" << endl;
	}else if (X=='D'){
		cout << "#sorting in descending order!" << endl;
	}
	for (int i=0;i<raw_num-1;i++){
		for (int ii=0;ii<raw_num-i-1;ii++){
			if ( data[ii][column-1] > data[ii+1][column-1] ){
				double * temp = new double [column_num];
				temp=data[ii];
				data[ii]=data[ii+1];
				data[ii+1]=temp;
			}
		}
	}
}
/*
 * raw_num : raw number of file data
 * column_num : column number of file data
 * column : column the program act on
 * data : data
 * X : Ascending order, or Descending order
 */
