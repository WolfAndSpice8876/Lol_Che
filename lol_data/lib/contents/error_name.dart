

String getErrorName(int statusCode){
  switch(statusCode){
    case 0 :
      return "0 : Not initialized";
    case -100 :
      return "-100 : Dto broken";
    case 401:
      return "401 : Unauthorized";
    case 403:
      return "403 : Forbidden";
    case 404:
      return "404 : Data not found";
    case 405:
      return "405 : Method not allowed";
    case 415:
      return "415 : Unsupported media type";
    case 429:
      return "429 : Rate limit exceeded";
    case 500:
      return "500 : Internal server error";
    case 502:
      return "502 : Bad gateway";
    case 503:
      return "503 : Service unavailable";
    case 504:
      return "504 : Gateway timeout";
    case 600:
      return "600 : Internet connection waiting timeout";
    default:
        return "Unknown Error";
  }
}