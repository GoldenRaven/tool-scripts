#include<iostream>
#include<iomanip>
#include<fstream>
#include<cstdlib>
#include<math.h>
using namespace std;

void sort(int raw_num, int column_num, int column, double ** data,char X);
int main(void)
{
	int raw_num,column_num=2;
	ifstream file_raw("raw_num");
	file_raw >> raw_num ;
	double ** data = new double * [raw_num];
	for (int i=0;i<raw_num;i++){
		data[i] = new double [column_num];
	}
	ifstream file_data_in("s");
	for (int i=0;i<raw_num;i++){
		for (int j=0;j<column_num;j++){
			file_data_in >> data[i][j];
		}
	}
	sort(raw_num,column_num,1,data,'A');
	file_data_in.close();
	ofstream file_data_out("s");
	for (int i=0;i<raw_num;i++){
		for (int j=0;j<column_num;j++){
			file_data_out << left << setw(20) << data[i][j];
			//file_data << setw(30) << setprescition(20) << data[i][j];
		}
		file_data_out << endl;
	}
	file_data_out.close();
}
