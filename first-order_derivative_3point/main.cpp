#include<iostream>
#include<iomanip>
#include<cstdlib>
#include<math.h>
#include<fstream>
using namespace std;

int main(void)
{
    void diff(int row_num, int column_num, double ** data);
    int row_num,column_num;
    ifstream file_row("row_num");
    ifstream file_column("column_num");
    file_row >> row_num ;
    file_column >> column_num ;
    double ** data = new double * [row_num];
    for (int i=0;i<row_num;i++){
        data[i] = new double [column_num];
    }
    ifstream file_data_in("before");
    for (int i=0;i<row_num;i++){
        for (int j=0;j<column_num;j++){
            file_data_in >> data[i][j];
        }
    }
    file_data_in.close();
    diff(row_num,column_num,data);
}

void diff(int row_num, int column_num, double ** data)
{
    double ** data_new = new double * [row_num-2];
    for (int i=0;i<row_num-2;i++){
        data_new[i] = new double [column_num];
    }
    for (int i=0;i<row_num-2;i++){
        data_new[i][0]=data[i+1][0];
        for (int j=1;j<column_num;j++){
            data_new[i][j]=(data[i+2][j]-data[i][j])/(data[i+2][0]-data[i][0]);
        }
    }
    ofstream file_data_out("after");
    for (int i=0;i<row_num-2;i++){
        for (int j=0;j<column_num;j++){
            file_data_out << left << setw(30) << setprecision(20) << data_new[i][j];
        }
        file_data_out << endl;
    }
    file_data_out.close();
}
