public with sharing class StringGeneratorCallout {
    
    public static final String URL_BASE_RANDOM_ORG = 'callout:StringGenerator';
    public static final Integer MAX_LENGTH = 20;

    public static Map<String, String> requestValuesMap = new Map<String, String> {
        'num' => '1',
        'digits' => 'on',
        'upperalpha' => 'on',
        'loweralpha' => 'on',
        'unique' => 'on',
        'format' => 'plain',
        'rnd' => 'new'
    };

    /**
     * This method is used as a part of random string generation process. It is called from the LWC component 
     * and the returned values is displayed in the response field in this component.
     * 
     * @param accountId     If of the account from LWC component. Can be null.
     * @return              Body of the response. Can be null.
     */
    @AuraEnabled
    public static String doStringRandomizerCallout(Id accountId){
        Account account = queryAccountById(accountId);
        addStringLengthToTheMap(account.Name);

        HttpRequest request = createRequest();

        Http http = new Http();
        HTTPResponse response = http.send(request);

        return response.getBody();
    }

    private static Account queryAccountById(Id accountId) {
        return [SELECT Id, Name FROM Account WHERE Id = :accountId LIMIT 1];
    }

    private static void addStringLengthToTheMap(String accountName) {
        Integer nameLength = accountName.length();
        String stringLength = String.valueOf(nameLength < 20 ? nameLength : MAX_LENGTH);

        requestValuesMap.put('len', stringLength);
    }

    private static HttpRequest createRequest() {
        HttpRequest request = new HttpRequest();

        String url = constructUrlForCallout();

        request.setEndpoint(url);
        request.setMethod('GET');

        return request;
    }

    private static String constructUrlForCallout() {
        String url = URL_BASE_RANDOM_ORG + '?';

        for(String parameter : requestValuesMap.keySet()) {
            url += parameter + '=' + requestValuesMap.get(parameter) + '&';
        }

        url = url.removeEnd('&');

        return url;
    }
}
