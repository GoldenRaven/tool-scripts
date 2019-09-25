#.SILENT:
cc=g++
name=sort.x
objects=main.o sort.o

$(name): $(objects)
	$(cc) -o $(name) $(objects)

main.o: main.cpp
	$(cc) -c main.cpp

sort.o: sort.cpp
	$(cc) -c sort.cpp

clean:
	rm $(name) $(objects)
