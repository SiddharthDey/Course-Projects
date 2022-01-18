#include <iostream> 
#include <math.h> 
#include <cstdlib> 
using namespace std; 

const double theta = 0.001;
const double reward = -1.0;
const double gamma = 1.0;
const int N = 10;
///// we can change the goal locations by changing the continue part in main loop and final direction loop
double next_state_max_v(double V[N][N],int x,int y){
	double v_n[4] = {0.0,0.0,0.0,0.0};
	//top v value
	if(x!=0){
		v_n[0]=V[x-1][y];
	}
	else{
		v_n[0]=V[x][y];
	}
	//bottom v value
	if(x!=N-1){
		v_n[1] = V[x+1][y];
	}
	else{
		v_n[1] = V[x][y];
	}
	//left v value
	if(y!=0){
		v_n[2]=V[x][y-1];
	}
	else{
		v_n[2]=V[x][y];
	}
	//right v value
	if(y!=N-1){
		v_n[3] = V[x][y+1];
	}
	else{
		v_n[3] = V[x][y];
	}
	double v_max = v_n[0];
	for (int i=1;i<4;i++){
		if (v_n[i]>v_max){
		v_max = v_n[i];
		}
	}
	return(v_max);
}

int next_state_max_v_loc(double V[N][N],int x,int y){
	double v_n[4] = {0.0,0.0,0.0,0.0};
	//top v value
	if(x!=0){
		v_n[0]=V[x-1][y];
	}
	else{
		v_n[0]=V[x][y];
	}
	//bottom v value
	if(x!=N-1){
		v_n[1] = V[x+1][y];
	}
	else{
		v_n[1] = V[x][y];
	}
	//left v value
	if(y!=0){
		v_n[2]=V[x][y-1];
	}
	else{
		v_n[2]=V[x][y];
	}
	//right v value
	if(y!=N-1){
		v_n[3] = V[x][y+1];
	}
	else{
		v_n[3] = V[x][y];
	}
	int v_max_loc = 0;
	double v_max = v_n[0];
	for (int i=1;i<4;i++){
		if (v_n[i]>v_max){
		v_max_loc = i;
		v_max = v_n[i];
		}
	}
	return(v_max_loc);
}

void display(double V[N][N]){
	for (int i = 0; i < N; i++){
        for (int j = 0; j < N; j++){
			cout << V[i][j] <<  " ";
    	}
		cout << endl;	
	}
}

int main(){
	double V[N][N];
	for(int i=0;i<N;i++){
		for(int j=0;j<N;j++){
			V[i][j] = 0.0;
		}
	}
	display(V);
	int loop_count = 0;
	while(1){
		double delta = 0.0;
		for (int i=0;i<N;i++){
			for (int j=0;j<N;j++){
				double v = V[i][j];
				if (i==0 && j==0){
					continue;
				}
				if (i==N-1 && j==N-1){
					continue;
				}
				double v_s_next = 0.0;
				v_s_next = next_state_max_v(V,i,j);
				V[i][j] = reward + v_s_next;
				double del = 0.0;
				if (V[i][j]>v){
					del = V[i][j] - v;
				}
				else{
					del = v - V[i][j];
				}
				if (del>delta){
					delta = del;
				}
				
			}
		}
		cout<<"The loop count is "<<loop_count<<endl<<endl;
		loop_count++;
		display(V);
		//cout<<"the delta is"<<delta<<endl;
		if (delta<theta){
			break;
		}
	}
	for(int i=0;i<N;i++){
		for(int j=0;j<N;j++){
			if (i==0 && j==0){
				cout<<"G ";
				continue;
				}
			if (i==N-1 && j==N-1){
				cout<<"G ";
				continue;
			}
			int max_loc = 0;
			max_loc = next_state_max_v_loc(V,i,j);
			if (max_loc==0){
				cout<<"T ";
			}
			if (max_loc==1){
				cout<<"D ";
			}
			if (max_loc==2){
				cout<<"L ";
			}
			if (max_loc==3){
				cout<<"R ";
			}
		}
		cout<< endl;
	}
	return 0;
}
