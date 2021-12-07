import ballerina/http;
import ballerina/io;

type userDetails record {
    int userId;
    string firstName;
    string lastName;
    string email;
};

userDetails[] users = [];

service /lab2 on new http:Listener(9090) {

    resource function POST  addUsers(@http:Payload userDetails new_user) returns json{
        io:println("Processing the caller....");
        users.push(new_user);
        return {"New user has been created at ":new_user.userId};
    }

    resource function GET getUsers() returns userDetails[]{
        io:println("Retrieving the user for you....");
        return users;
        
    }

}
