import ballerina/http;
import ballerina/io;

final json OriginalJson =
{
    "username": " ",
    "fiestname": " ",
    "lastname": " ",
    "prefered_formats": ["audio", "video", "text"],
        "past_subjects": [{"course": "Algorithms","score": "B+"}, {"course": "Programming I","score": "A+"}]
};

type userDetails record {|
    int Id;
    string username;
    string lastname;
    string firstname;
    any[] prefered_formats;
    any[] past_subjects;
|};

type Module record {|
    string course;
    string score;
|};

type new_info userDetails|string;

userDetails[] learners = [];

service /virtualSystem on new http:Listener(9090) {


    resource function POST newUser(@http:Payload userDetails newUser) returns json {

        io:println("Processing the information....");
        learners.push(newUser);
        return {"New user has been created at ":newUser.Id};
    }

    resource function GET getLearners() returns userDetails[] {
        io:println("Retreiving users....");
        return learners;
    }

    resource function GET get_learner(int Id) returns userDetails[]{
        io:println("Retreiving users....");
        return(learners.[Id]);
    }

    resource function PUT updateLearner/[int Id](@http:Payload userDetails newInfo) returns json {
        string firstName = newInfo.firstname;
        string lastName = newInfo.lastname;
        string userName = newInfo.lastname;
        string[] formats = newInfo.prefered_formats;
        Module[] modules = newInfo.past_modules;

        learners[Id].firstname = firstName;
        learners[Id].lastname = lastName;
        learners[Id].username = userName;
        learners[Id].prefered_formats = formats;
        learners[Id]past_modules = modules;

        return(new_info);
    }
}

      


