/*****************************************************************
* Name: Tyler Bartlett
* Class:CS360 Fall 2018
* Class time: 1300-1350
* Date: 11/03/18
* Project #: Lab 2
* Driver Name: NA
* Program Description: input an mp3 file, parse its header,
*		if file type is MPEG Layer 3: print file size, bit rate,
*		frequency, copyright status, original file status
* Test Oracle: NA
*				
* NOTES: I should probably be passing a pointer to my struct 
*		and not the struct itself as it takes more stack space
*		This code could benefit from being refactored in general
*****************************************************************/ 
//libraries
#include <stdio.h>
#include <stdlib.h>

//defined constants
#define OneMB 1048576
#define TenMB OneMB*10

//global vars
FILE *fp = NULL;

//a record keeper to hold relevant file information
struct record
{
	float fileSize; //size of file
	int bitRate; //bitrate of file in kbps
	int frequency;  //frequency of media stream in Hz
	int copyrighted; //1: copyrighted, 0: not copyrighted
	int originalFile; //1: original file, 0: copy of original file
	int mpegLayer3File; //1: file is of type MPEG Layer3, 0: file is not of type MPEG Layer3
};

//Clean up
void end(FILE *fp)
{
	fclose(fp);				// close and free the file
	exit(EXIT_SUCCESS);		// or return 0;
}

// Open the file given on the command line
int initialize(int argc, char** argv)
{
	
	if( argc != 2 )
	{
		printf( "Usage: %s filename.mp3\n", argv[0] );
		return(EXIT_FAILURE);
	}

	fp = fopen(argv[1], "rb");
	if( fp == NULL )
	{
		printf( "Can't open file %s\n", argv[1] );
		return(EXIT_FAILURE);
	}	

	return 0;
}

/* Finds the header of the mp3 file, 0xFFF, and returns the byte number it was found at */
int findHeader(unsigned char* data, float size)
{
	//variables to store the values of nybbles of the current byte and high nybble of next byte   
	unsigned char curByte_hiNib, curByte_loNib, nextByte_hiNib;

	for (int i = 0; i < size; i++)
	{	
		//splitting the bytes into nybbles
		//referenced this site for how to split a byte into nybbles https://stackoverflow.com/questions/25327211/how-to-split-hex-byte-of-an-ascii-character
		curByte_hiNib = (data[i] >> 4) & 0x0F;
		curByte_loNib = data[i] & 0x0F;
		nextByte_hiNib = (data[i+1] >> 4) & 0x0F;

		//have we found 0xFFF?
		if(curByte_hiNib == 0xF && curByte_loNib == 0xF && nextByte_hiNib == 0xF)
		{
			return i;
		}
	}

	return -1; //header not found
}

//helper fuction to calculate bitRate
// got values from here: https://www.mp3-tech.org/programmer/frame_header.html
int bitRate(int* ptrToBitArray)
{
	int value = 0; 
	int bitRate;
	if (ptrToBitArray[16] == 1) {value += 8;} //binary addition
	if (ptrToBitArray[17] == 1) {value += 4;} //binary addition
	if (ptrToBitArray[18] == 1) {value += 2;} //binary addition
	if (ptrToBitArray[19] == 1) {value += 1;} //binary addition

	switch (value)
		{
			case 14:
				bitRate = 320;
				break;
			case 13:
				bitRate = 256;
				break;
			case 12:
				bitRate = 224;
				break;
			case 11:
				bitRate = 192;
				break;
			case 10:
				bitRate = 160;
				break;
			case 9:
				bitRate = 128;
				break;
			case 8:
				bitRate = 112;
				break;
			case 7:
				bitRate = 96;
				break;
			case 6:
				bitRate = 80;
				break;
			case 5:
				bitRate = 64;
				break;
			case 4:
				bitRate = 56;
				break;
			case 3:
				bitRate = 48;
				break;
			case 2:
				bitRate = 40;
				break;
			case 1:
				bitRate = 32;
				break;			
			default:
				printf("Bad bit rate!!!\n");
				bitRate = -1;
		}
	return bitRate;
}

//helper function to calculate frequency
int frequency(int* ptrToBitArray)
{
	int value = 0;
	int frequency;

	if (ptrToBitArray[20] == 1) {value += 2;} //binary addition
	if (ptrToBitArray[21] == 1) {value += 1;} //binary addition

	switch (value)
	{
		case 2:
			frequency = 32000;
			break;
		case 1:
			frequency = 48000;
			break;
		case 0:
			frequency = 44100;
			break;
		default:
			printf("Bad frequency!!!\n");
			frequency = -1;
	}

	return frequency;
}

//Reads through the header file and fills in the record with pertinient information
struct record readHeader(unsigned char* data, int headerLocation, struct record record)
{
	int bitArray[32]; //array to hold the bits of the header
	int* ptrToBitArray = bitArray;
	int byteMod = 8; //used in loops to move through array appropriately

	//read the header into the array
	for (int i = headerLocation; i < headerLocation+4; i++)
	{
		if (i == headerLocation+0) {byteMod=0;}
		if (i == headerLocation+1) {byteMod=8;}
		if (i == headerLocation+2) {byteMod=16;}
		if (i == headerLocation+3) {byteMod=24;}
		for (int j = byteMod; j < 8+byteMod; j++)
		{
			bitArray[j] = (data[i] & 0x80)/128; // most significant bit
			data[i] <<= 1; //shift bits
		}
	
	} 

	//check mp3 version and layer (bits 13-15 inclusive must be 0b101)
	if (bitArray[12] == 1 && bitArray[13] == 0 && bitArray[14] == 1)
	{
		//printf("Inputted mp3 is of type MPEG Layer 3\n");
		record.mpegLayer3File = 1;
	}

	//Calculates bit rate
	record.bitRate = bitRate(ptrToBitArray);
	//printf("bit rate is: %d kpbs\n", record.bitRate);

	//Calculate frequency
	record.frequency = frequency(ptrToBitArray);

	//Determine if file is copyrighted (bit 29 determines this)
	if (bitArray[28] == 1)
	{
		record.copyrighted = 1; // is copyrighted
	}
	else
	{
		record.copyrighted = 0; //is not copyrighted
	}

	//Determine if file is original or is a copy (bit 30 determines this)
	if (bitArray[29] == 1)
	{
		record.originalFile =1; //file is original
	}
	else
	{
		record.originalFile =0; //file is not original
	}

	return record;
}

//Reads the file to memory and returns a record to main
struct record readFileToMem(FILE* fp, struct record record)
{
	// How many bytes are there in the file?  If you know the OS you're
	// on you can use a system API call to find out.  Here we use ANSI standard
	// function calls.
	record.fileSize = 0;
	fseek( fp, 0, SEEK_END );		// go to 0 bytes from the end
	record.fileSize = ftell(fp);				// how far from the beginning?
	rewind(fp);						// go back to the beginning
	
	if( record.fileSize < 1 || record.fileSize > TenMB )
	{
		printf("File size is not within the allowed range\n"); 
		end(fp); //goto cleanup
	}

	// Allocate memory on the heap for a copy of the file
	unsigned char* data = (unsigned char*)malloc(record.fileSize);
	
	// Read it into our block of memory
	size_t bytesRead = fread( data, sizeof(unsigned char), record.fileSize, fp );
	if( bytesRead != record.fileSize )
	{
		printf( "Error reading file. Unexpected number of bytes read: %ld\n",bytesRead );
		free(data); // release memmory
		end(fp); // goto cleanup
		
	}

	// We now have a pointer to the first byte of data in a copy of the file, have fun
	// unsigned char * data    <--- this is the pointer
	int headerLocation = findHeader(data, record.fileSize);
	//printf("header @ %d\n", headerLocation);
		
	record = readHeader(data, headerLocation, record);

	free(data); // release memmory

	return record;
}

//print out the record
int printRecord(struct record record)
{
	printf("******************************\n");
	printf("* File Name Here\n");
	printf("******************************\n");
	if (record.mpegLayer3File != 1)
	{
		printf("File type was not MPEG Layer 3");
		return -1;
	}
	
	else
	{
		printf("File type: MPEG Layer 3\n");		
		printf("File size: %.02f MB\n", record.fileSize/OneMB);
		printf("Bit rate: %d kpbs\n", record.bitRate);
		printf("PLayback frequency: %d Hz\n", record.frequency);
		if (record.copyrighted == 1)
		{
			printf("Copyright: Yes\n");
		}
		else
		{
			printf("Copyright: No\n");
		}
		if (record.originalFile == 1)
		{
			printf("File is original: Yes\n");
		}
		else
		{
			printf("File is original: No\n");
		}
	}

	return 0;
}

int main( int argc, char** argv )
{
	//create the record
	struct record record;

	//initialize the file
	initialize(argc, argv);
	
	//read the file and generate a record
	record = readFileToMem(fp, record);

	//print the record
	printRecord(record);

	end(fp);// goto cleanup
	return 0;	
}