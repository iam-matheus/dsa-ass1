import ballerina/http;
import ballerina/io;

// Creates a client 
final http:Client clientEndpoint = check new ("http://localhost:9090");

public function main() returns error? {

    
    // This sends a request to the service endpoints
    io:println("GET request:");
    json resp = check clientEndpoint->get("/get?test=123");
    io:println(resp.toJsonString());

    io:println("\nGET request with Headers:");
    resp = check clientEndpoint->get(virtualSystem/getLearner,
            {"Matheus": "Mulundu"});
    io:println(resp.toJsonString());

    // Posts to the 9090 endpoint
    io:println("\nPOST:");
    resp = check clientEndpoint->post(virtualSystem, newUser);
    io:println(resp.toJsonString());

    io:println("\nUse defined resources: ");
    http:Response response = check clientEndpoint->execute(
                        "COPY", "/get", " Welcome ");

    io:println("Status: " + response.statusCode.toString());
}
