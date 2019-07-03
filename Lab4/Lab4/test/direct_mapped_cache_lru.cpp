#include <iostream>
#include <stdio.h>
#include <math.h>

using namespace std;

struct cache_content
{
	bool v;
	unsigned int tag;
    // unsigned int	data[16];
};

const int K = 1024;
int way = 2;


double log2(double n)
{
    // log(n) / log(2) is log2.
    return log(n) / log(double(2));
}


void simulate(int cache_size, int block_size)
{
	unsigned int tag, index, x;

	int offset_bit = (int)log2(block_size);
	int index_bit = (int)log2(cache_size / block_size)-(int)log2(way);
	int line = cache_size >> (offset_bit);


	cache_content *cache = new cache_content[line];


    cout << "cache line: " << line << ", ";


	for(int j = 0; j < line/way; j++)   //¥ýªì©l¤Ævalid
		for(int i=0;i<way;i++)
            cache[j*way+i].v = false;


    FILE *fp = fopen("RADIX.txt", "r");  // read file
    double access=0,miss=0;
	while(fscanf(fp, "%x", &x) != EOF)
    {
		//cout << hex << x << " ";
		index = (x >> offset_bit) & (line/way - 1);

		tag = x >> (index_bit + offset_bit);
		bool find=0;
		for(int i=0;i<way;i++){
            if(cache[index*way+i].v && cache[index*way+i].tag == tag)
            {
                cache[index*way+i].v = true; // hit
                access++;
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
                access++;
                miss++;
                find=true;
                break;
            }
		}

		if(!find){
            for(int i=0;i<way-1;i++)
                cache[index*way+i].tag=cache[index*way+i+1].tag;
            cache[index*way+way-1].tag=tag;
            miss++;
            access++;
		}
	}

	cout << "miss rate: " << miss/access << endl;
    cout << "total bit: " << 32-offset_bit-index_bit+1 << endl;
	fclose(fp);

	delete [] cache;
}

int main()
{
	// Let us simulate 4KB cache with 16B blocks
	for(int i=1; i<33; i=i*2){
        for(way = 2; way < 9; way = way*2){
            cout << "cache size: " << i << "K, ";
            cout << "way: " << way << ", "; 
            simulate(i * K, 64);
        }
    }
}
