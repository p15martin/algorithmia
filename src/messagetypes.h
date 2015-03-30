//
//  messagetypes.h
//  algorithmia
//
//  Created by Peter Martin on 3/21/15.
//  Copyright (c) 2015 Peter Martin. All rights reserved.
//

#ifndef algorithmia_messagetypes_h
#define algorithmia_messagetypes_h

#include <cpprest/http_client.h>

#define ERROR U("error")
#define DURATION U("duration")
#define RESULT U("result")

struct Error
{
    utility::string_t message;
    
    static Error FromJSON(const web::json::object &object)
    {
        Error error;
        
        auto result = object.find(ERROR);
        if (result == object.end())
        {
            throw web::json::json_exception(U("No ERROR found in response"));
        }
        
        web::json::value message = result->second;
        error.message = message.as_string();
        
        return error;
    }
};

struct Answer
{
    double duration;
    web::json::value result;
    
    Answer() {}
    
    static Answer FromJSON(const web::json::object &object)
    {
        Answer answer;
        
        answer.duration = object.at(DURATION).as_double();
        
        auto result = object.find(RESULT);
        if (result == object.end())
        {
            throw web::json::json_exception(U("No RESULT found in response"));
        }
        
        web::json::value value = result->second;
        answer.result = value;
        
        return answer;
    }
};


#endif
