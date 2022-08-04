public with sharing class HttpGeneratorMock implements HttpCalloutMock {
    public static final String RANDOM_STRING = 'EGWLZLeOqwWVkZF6fdSN';

    public HTTPResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setBody(RANDOM_STRING);
        response.setStatusCode(200);
        return response;
    }
}
