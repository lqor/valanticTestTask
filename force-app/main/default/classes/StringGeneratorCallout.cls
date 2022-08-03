public with sharing class StringGeneratorCallout {
    
    public static final Map<String, String> REQUEST_VALUES_MAP = new Map<String, String> {
        'num' => '1',
        'len' => '20',
        'digits' => 'on',
        'upperalpha' => 'on',
        'loweralpha' => 'on',
        'unique' => 'on',
        'format' => 'plain',
        'rnd' => 'new'
    };

    public static final String URL_BASE_RANDOM_ORG = 'https://www.random.org/strings/?';

    /**
     * This method is used as a part of ... process. It is called from ... and the returned values is displayed ...
     * 
     * @return      Body of the response. Can be null.
     */
    public String doStringRandomizerCallout(){
        HttpRequest request = createRequest();

        Http http = new Http();
        HTTPResponse response = http.send(request);

        return response.getBody();
    }

    private HttpRequest createRequest() {
        HttpRequest request = new HttpRequest();

        String url = constructUrlForCallout();

        request.setEndpoint(url);
        request.setMethod('GET');

        return request;
    }

    private String constructUrlForCallout() {
        String url = URL_BASE_RANDOM_ORG;

        for(String parameter : REQUEST_VALUES_MAP.keySet()) {
            url += parameter + '=' + REQUEST_VALUES_MAP.get(parameter) + '&';
        }

        url = url.removeEnd('&');

        return url;
    }
}
