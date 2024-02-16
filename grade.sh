CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
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
javac ListExamples.java
javac -cp $CPATH *.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
