#include <iostream>
#include <stdio.h>
#include <math.h>

using namespace std;
float all, hit, miss;


struct cache_content
{
	bool v;
	unsigned int tag;
    // unsigned int	data[16];
};

const int K = 1024;

double log2(double n)
{
    // log(n) / log(2) is log2.
    return log(n) / log(double(2));
}


void simulate(int cache_size, int block_size, char a[])
{
	unsigned int tag, index, x;
	hit = 0;
	miss = 0;
	all = 0;

	int offset_bit = (int)log2(block_size);
	int index_bit = (int)log2(cache_size / block_size);
	int line = cache_size >> (offset_bit);

	cache_content *cache = new cache_content[line];

  cout << "cache line: " << line << ", ";

	for(int j = 0; j < line; j++)
		cache[j].v = false;

	
    FILE *fp = fopen(a, "r");  // read file

	while(fscanf(fp, "%x", &x) != EOF)
    {
		// cout << hex << x << " ";
		index = (x >> offset_bit) & (line - 1);
		tag = x >> (index_bit + offset_bit);
		if(cache[index].v && cache[index].tag == tag) {
			cache[index].v = true;    // hit
			hit++;
			all++;
		}
		else{
			cache[index].v = true;  // miss
			cache[index].tag = tag;
			miss++;
			all++;
		}
	}
	fclose(fp);
	cout << "miss rate: " << miss/all << endl;

	delete [] cache;
}

int main()
{
	// Let us simulate 4KB cache with 16B blocks
	char a[2][30]={"DCACHE.txt","ICACHE.txt"};
	for(int w=0;w<2;w++){
        cout << a[w] << ":" << endl;
        for(int i=4; i<257; i=i*4){
            for(int j=16; j<257; j=j*2){
                cout << "cache size: " << i << "K, ";
                cout << "block size: " << j << "bytes, ";
                simulate(i * K, j,a[w]);
            }
        }
	}
}
