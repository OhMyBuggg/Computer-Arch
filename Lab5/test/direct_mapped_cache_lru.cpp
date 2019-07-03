#include <iostream>
#include <stdio.h>
#include <math.h>
#include <string>
#include <bits/stdc++.h>

using namespace std;

struct cache_content
{
	bool v;
	unsigned int tag;
    // unsigned int	data[16];
};

double log2(double x)
{
    // log(n) / log(2) is log2.
    return log(x) / log(double(2));
}

unsigned int baseA, baseB, baseC;

int m, n, p;

vector< unsigned int > addr;

vector< unsigned int > miss;

void simulate( int cache_size, int block_size, int &hit_time, int &miss_time )
{
	miss.clear();

	unsigned int tag, index, x;

    int way = 8; //8-way set

	int offset_bit = (int)log2(block_size);

	int index_bit = (int)log2(cache_size / block_size)-(int)log2(way);

	int line = cache_size >> (offset_bit); // 可放幾個block

	cache_content *cache = new cache_content[line];


	for(int j = 0; j < line/way; j++)   //初始化valid
		for(int i=0;i<way;i++)
            cache[j*way+i].v = false;

        for(int a = 0 ; a < addr.size() ; a++ )
        {
            x = addr[a];

            index = (x >> offset_bit) & (line/way - 1);

            tag = x >> (index_bit + offset_bit);

            bool find=0;

            for(int i=0;i<way;i++){

                if(cache[index*way+i].v && cache[index*way+i].tag == tag)
                {
                    cache[index*way+i].v = true; // hit
                    hit_time++;
                    find=true;
                    int j=0;
                    for(j=i; j<way-1;j++){
                        if(!cache[index*way+j+1].v){
                            break;
                        }
                        cache_content temp;
                        temp = cache[index*way+j];
                        cache[index*way+j] = cache[index*way+j+1];
                        cache[index*way+j+1] = temp;
                    }
                    break;
                }

                else if(!cache[index*way+i].v)
                {
                    cache[index*way+i].v = true;  // miss
                    cache[index*way+i].tag = tag;
                    miss_time++;
                    find=true;
                    miss.push_back(x);
                    break;
                }

            }

            if(!find){
                for(int i=0;i<way-1;i++){
                	cache_content temp;
                  temp = cache[index*way+i];
                  cache[index*way+i] = cache[index*way+i+1];
                  cache[index*way+i+1] = temp;
                }
                cache[index*way+way-1].tag = tag;
                miss_time++;
                miss.push_back(x);
            }
        }

	delete [] cache;
}

int main(int argc, char *argv[])
{
		ifstream fin(argv[1]);
		ofstream fout(argv[2]);

		fin >> hex >> baseA >> baseB >> baseC;
		fin >> dec >> m >> n >> p;

		unsigned int A[m][n];
		unsigned int B[n][p];
		unsigned int C[m][p];

		for(int i=0; i<m; i++){
			for(int j=0; j<n; j++){
				int temp;
				fin >> dec >> temp;
				A[i][j] = temp;
			}
		}

		for(int i=0; i<n; i++){
			for(int j=0; j<p; j++){
				int temp;
				fin >> dec >> temp;
				B[i][j] = temp;
			}
		}

		for(int i=0; i<m; i++){
			for(int j=0; j<p; j++){
				C[i][j] = 0;
			}
		}

		for(int i=0; i<m; i++){
			for(int j=0; j<p; j++){
				for(int k=0; k<n; k++){
					C[i][j] += A[i][k] * B[k][j];
					addr.push_back(baseC + i*p*4 + j*4);
					addr.push_back(baseA + i*n*4 + k*4);
					addr.push_back(baseB + k*p*4 + j*4);
					addr.push_back(baseC + i*p*4 + j*4);
				}
				fout << C[i][j] << " ";
			}
			fout << endl;
		}

		// simulate execution cycle
		fout << (22*m*p*n + 7*m*p + 7*m + 2 + 3) << " ";

		// a memory stall
		int hitTime = 0;
		int missTime = 0;
		int cache_size = 512;
		int block_size = 32;
		simulate(cache_size, block_size, hitTime, missTime);
		fout << hitTime * 4 + missTime * 836 << " ";

		// b memory stall
		fout << hitTime * 4 + missTime * 108 << " ";

		// c memory stall
	  int hitTimeL1 = 0;
		int missTimeL1 = 0;
		cache_size = 128;
		block_size = 16;
		simulate(cache_size, block_size, hitTimeL1, missTimeL1);
		int hitTimeL2 = 0;
		int missTimeL2 = 0;
		cache_size = 4096;
		block_size = 128;
		addr=miss;
		simulate(cache_size, block_size, hitTimeL2, missTimeL2);
		fout << (hitTimeL1 * 3 + hitTimeL2 * 55 + missTimeL2 * 3639) << endl;
}
