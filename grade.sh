CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission > grading-area/temp.txt
echo 'Finished cloning'

# Check that the student submission contains the correct file.
if  [[ -f student-submission/ListExamples.java ]]
then
    echo "ListExamples.java found!"
else 
    echo "The file [ListExamples.java] was not found."
    echo "Check that the file name matches the above."
    exit
fi

# Get the student code, java testers, and other stuff into grading-area
cp student-submission/ListExamples.java grading-area/
cp TestListExamples.java grading-area/
cp -r lib grading-area

cd grading-area

# Compile code
javac -cp $CPATH *.java

if [ $? -ne 0 ]
then
    echo "Your code does not compile!"
    exit
else
    echo "Student code compiled successfully."
fi 

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > testerOutput.txt

tail -2 testerOutput.txt > testScores.txt

cut -d ' ' -f 1 testScores.txt > passCheck.txt

if [[ -n $(grep "OK" passCheck.txt) ]]
then
    echo "All tests passed!"
fi



# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
