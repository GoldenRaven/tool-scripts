#include<iostream>
#include<iomanip>
#include<cstdlib>
#include<math.h>
#include<fstream>
using namespace std;

int row_num,column_num;
double ** data1;
double ** data2;
double ** data_curv;
bool derivatire_fileout;
int main(void)
{
    void diff1(double ** data);
    void diff2(double ** data);
    void curvature(double ** data1, double ** data2);
    ifstream file_row("row_num");
    ifstream file_column("column_num");
    file_row >> row_num ;
    file_column >> column_num ;
    derivatire_fileout=0;
    double ** data = new double * [row_num];
    for (int i=0;i<row_num;i++){
        data[i] = new double [column_num];
    }
    data1 = new double * [row_num-2];
    for (int i=0;i<row_num-2;i++){
        data1[i] = new double [column_num];
    }
    data2 = new double * [row_num-2];
    for (int i=0;i<row_num-2;i++){
        data2[i] = new double [column_num];
    }
    data_curv = new double * [row_num-2];
    for (int i=0;i<row_num-2;i++){
        data_curv[i] = new double [column_num];
    }
    ifstream file_data_in("before");
    for (int i=0;i<row_num;i++){
        for (int j=0;j<column_num;j++){
            file_data_in >> data[i][j];
        }
    }
    file_data_in.close();
    diff1(data);
    diff2(data);
    curvature(data1,data2);
}


void diff1(double ** data)
{
    for (int i=0;i<row_num-2;i++){
        data1[i][0]=data[i+1][0];
        for (int j=1;j<column_num;j++){
            data1[i][j]=(data[i+2][j]-data[i][j])/(data[i+2][0]-data[i][0]);
        }
    }
    if (derivatire_fileout){
        ofstream file_data_out("diff_1st.dat");
        for (int i=0;i<row_num-2;i++){
            for (int j=0;j<column_num;j++){
                file_data_out << left << setw(30) << setprecision(20) << data1[i][j];
            }
            file_data_out << endl;
        }
        file_data_out.close();
    }
}
void diff2(double ** data)
{
    for (int i=0;i<row_num-2;i++){
        data2[i][0]=data[i+1][0];
        for (int j=1;j<column_num;j++){
            data2[i][j]=(data[i+2][j]+data[i][j]-2*data[i+1][j])/((data[i+2][0]-data[i+1][0])*(data[i+1][0]-data[i][0]));
        }
    }
    if (derivatire_fileout){
        ofstream file_data_out("diff_2nd.dat");
        for (int i=0;i<row_num-2;i++){
            for (int j=0;j<column_num;j++){
                file_data_out << left << setw(30) << setprecision(20) << data2[i][j];
            }
            file_data_out << endl;
        }
        file_data_out.close();
    }
}
void curvature(double ** data1, double ** data2)
{
    for (int i=0;i<row_num-2;i++){
        data_curv[i][0]=data1[i][0];
        for (int j=1;j<column_num;j++){
            data_curv[i][j]=data2[i][j]/pow(1+pow(data1[i][j],2),3.0/2.0);
            // data_curv[i][j]=fabs(data2[i][j])/pow(1+pow(data1[i][j],2),3.0/2.0);
        }
    }
    ofstream file_data_out("after");
    for (int i=0;i<row_num-2;i++){
        for (int j=0;j<column_num;j++){
            file_data_out << left << setw(30) << setprecision(20) << data_curv[i][j];
        }
        file_data_out << endl;
    }
    file_data_out.close();
}
