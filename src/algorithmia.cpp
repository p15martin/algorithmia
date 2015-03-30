//
//  algorithmia.cpp
//  algorithmia
//
//  Created by Peter Martin on 3/21/15.
//  Copyright (c) 2015 Peter Martin. All rights reserved.
//

#include "algorithmia.h"
#include "messagetypes.h"

#include <cpprest/http_client.h>

using namespace ::pplx;
using namespace std;
using namespace boost;

using namespace web;
using namespace web::http;
using namespace web::http::client;
using namespace web::json;

void DisplayErrorMessage(const web::json::value &value)
{
    Error error = Error::FromJSON(value.as_object());
    
    ucout << "Error: " << error.message << endl;
}

void DisplayAnswer(const value &value)
{
    Answer answer = Answer::FromJSON(value.as_object());
    
    for (auto iterator = answer.result.as_array().begin(); iterator != answer.result.as_array().end(); ++iterator)
    {
        if (!iterator->is_null())
        {
            wcout << L"Value: " << iterator->as_integer() << endl;
        }
    }
}

extern "C" void callalgorithmia()
{
    http_client client(U("https://api.algorithmia.com/api/kenny/Factor"));
    http_request request(methods::POST);
    request.headers().set_content_type("application/json");
    request.headers().add("Authorization", "cb7c94e13a224ab6b127800ad2afa81e");
    request.set_body("667");
    
    client
    .request(request)
    .then([](http_response response)
          {
              if (starts_with(response.headers().content_type(), "application/json"))
              {
                  value value = response.extract_json().get();
                  
                  wcout << L"Status code: " << response.status_code() << endl;
                  if (response.status_code() == status_codes::OK)
                  {
                      DisplayAnswer(value);
                  }
                  else
                  {
                      DisplayErrorMessage(value);
                  }
              }
              else
              {
                  throw U("ERROR: unexpected return type");
              }
          })
    .wait();
}