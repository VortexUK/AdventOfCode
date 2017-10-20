fileName <- 'D:\\git\\AdventOfCode\\2015\\Day1\\input.txt'
inp <- readChar(fileName, file.info(fileName)$size)
inpsplit <- unlist(strsplit(inp,""))
inpsplit_factor <- factor(inpsplit)
levels(inpsplit_factor) <- c("Up", "Down")
summary = summary(inpsplit_factor)
summary[1]-summary[2]
