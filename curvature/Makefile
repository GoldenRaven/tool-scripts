#.SILENT:
cc=g++
name=curvature.x
objects=main.o

$(name): $(objects)
	$(cc) -o $(name) $(objects)

main.o: main.cpp
	$(cc) -c main.cpp
clean:
	rm $(name) $(objects)
